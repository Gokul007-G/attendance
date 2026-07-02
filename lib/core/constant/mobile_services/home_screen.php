<?php
require_once '../config/config.php';
require_once '../config/db.php';

header('Content-Type: application/json');

$json = file_get_contents('php://input');
$data = json_decode($json, true);

date_default_timezone_set('Asia/Kolkata');

try {
    $userId = $data['userId'] ?? null;
    $month = $data['month'] ?? date('n');
    $year = $data['year'] ?? date('Y');

    if (!$userId) {
        echo json_encode([
            "status" => false,
            "message" => "User ID required"
        ]);
        exit;
    }

    /* ---------------- TODAY DETAILS ---------------- */
    $stmt = $pdo->prepare("SELECT 
            sno,
            PunchTimeDetailsId,
            date
            FROM PunchTimeDetails
            WHERE tktno = ?
            AND CAST(date AS DATE) = CAST(GETDATE() AS DATE)
            ORDER BY date ASC
        ");

    $stmt->execute(['00' . $userId]);
    $records = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $todayResponse = [
        "in_time" => null,
        "out_time" => null,
        "working_hours" => null
    ];

    $count = count($records);

    if ($count > 0) {

        // First IN time
        $firstIn = new DateTime($records[0]['date']);
        $todayResponse["in_time"] = $firstIn->format('h:i A');

        $totalMinutes = 0;

        for ($i = 0; $i < $count; $i += 2) {

            $inTime = new DateTime($records[$i]['date']);

            // If OUT exists
            if (($i + 1) < $count) {
                $outTime = new DateTime($records[$i + 1]['date']);
            } else {
                // Still inside company
                $outTime = new DateTime();
            }

            $diff = $inTime->diff($outTime);

            $minutes = ($diff->h * 60) + $diff->i + ($diff->days * 24 * 60);

            $totalMinutes += $minutes;
        }

        // Last record is OUT only if count is even
        if ($count % 2 == 0) {
            $lastOut = new DateTime($records[$count - 1]['date']);
            $todayResponse["out_time"] = $lastOut->format('h:i A');
        } else {
            $todayResponse["out_time"] = null;
        }

        $hours = floor($totalMinutes / 60);
        $minutes = $totalMinutes % 60;

        $todayResponse["working_hours"] =
            $hours . "H " . $minutes . " m";
    }
    /* ---------------- MONTH CALCULATION ---------------- */

    $monthTotalDays = cal_days_in_month(CAL_GREGORIAN, $month, $year);

    // Current month => count only until today
    if ($month == date('n') && $year == date('Y')) {
        $daysToCheck = date('j');
    } else {
        $daysToCheck = $monthTotalDays;
    }

    if ($year == date('Y') && $month == date('n')) {
        $availableDays = date('j'); // today date
    } elseif ($year > date('Y') || ($year == date('Y') && $month > date('n'))) {
        $availableDays = 0; // future month
    } else {
        $availableDays = $monthTotalDays; // past month
    }
    $fullDays = 0;
    $halfDays = 0;

    $availableFullDays = 0;
    $availableHalfDays = 0;

    for ($day = 1; $day <= $monthTotalDays; $day++) {
        $dateString = sprintf('%04d-%02d-%02d', $year, $month, $day);
        $weekDay = date('w', strtotime($dateString));

        if ($weekDay == 0) {
            continue; // Sunday
        } elseif ($weekDay == 6) {
            $halfDays++;

            if ($day <= $availableDays) {
                $availableHalfDays++;
            }
        } else {
            $fullDays++;

            if ($day <= $availableDays) {
                $availableFullDays++;
            }
        }
    }
    $workingDays = $fullDays + ($halfDays * 0.5);

    $availableWorkingDays =
        $availableFullDays + ($availableHalfDays * 0.5);
        
    /* ---------------- PRESENT DAYS ---------------- */

    $monthStmt = $pdo->prepare("SELECT 
        COUNT(DISTINCT CAST(date AS DATE)) AS present_days
        FROM PunchTimeDetails
        WHERE tktno = ?
          AND MONTH(date) = ?
          AND YEAR(date) = ?
    ");

    $monthStmt->execute([
        '00' . $userId,
        $month,
        $year
    ]);

    $monthData = $monthStmt->fetch(PDO::FETCH_ASSOC);
    $presentDays = (int)$monthData['present_days'];

    $dateStmt = $pdo->prepare("SELECT 
                CAST(date AS DATE) AS attendance_date,
                MIN(date) AS in_time,
                MAX(date) AS out_time
            FROM PunchTimeDetails
            WHERE tktno = ?
            AND MONTH(date) = ?
            AND YEAR(date) = ?
            GROUP BY CAST(date AS DATE)
            ORDER BY attendance_date
        ");

    $dateStmt->execute([
        '00' . $userId,
        $month,
        $year
    ]);

    $dates = $dateStmt->fetchAll(PDO::FETCH_ASSOC);

    $presentDateList = [];

    // Convert present dates to array for fast lookup
    foreach ($dates as $row) {
        $presentDateList[] = $row['attendance_date'];
    }

    // Permission / Late / Half Day calculation based on FIRST IN TIME
    $lateDays = [];
    $permissionList = [];
    $halfDayList = [];

    $normalLimit = 555;      // 09:15
    $lateLimit = 570;        // 09:30
    $permissionLimit = 630;  // 10:30

    foreach ($dates as $row) {

        // First punch time of the day
        $inTime = new DateTime($row['in_time']);

        $totalMinutes =
            ((int)$inTime->format('H') * 60) +
            (int)$inTime->format('i');

        $data = [
            "date" => $row['attendance_date'],
            "in_time" => $row['in_time']
        ];

        // <= 9:15 AM = Normal (ignore)
        if ($totalMinutes <= $normalLimit) {
            continue;
        }

        // > 9:15 and <= 9:30 = Late
        if ($totalMinutes > $normalLimit && $totalMinutes <= $lateLimit) {
            $lateDays[] = $data;
        }

        // > 9:30 and <= 10:30 = Permission
        elseif ($totalMinutes > $lateLimit && $totalMinutes <= $permissionLimit) {
            $permissionList[] = $data;
        }

        // > 10:30 = Half Day
        else {
            $halfDayList[] = $data;
        }
    }
    // Absent Days
    $absentDaysList = [];

    for ($day = 1; $day <= $daysToCheck; $day++) {
        $dateString = sprintf('%04d-%02d-%02d', $year, $month, $day);

        $weekDay = date('w', strtotime($dateString));

        // Skip Sunday
        if ($weekDay == 0) {
            continue;
        }

        if (!in_array($dateString, $presentDateList)) {
            $isHalfDay = ($weekDay == 6);

            $absentDaysList[] = [
                "date" => $dateString,
                "day" => date('l', strtotime($dateString)),
                // "is_half_day" => $isHalfDay,
                "absent_value" => $isHalfDay ? 0.5 : 1
            ];
        }
    }
    $absentCount = 0;

    foreach ($absentDaysList as $absent) {
        $absentCount += $absent['absent_value'];
    }

    if ($year > date('Y') || ($year == date('Y') && $month > date('n'))) {
        $absentDays = 0;
    } else {
        $absentDays = max(0, $availableWorkingDays - $presentDays);
    }


    echo json_encode([
        "status" => true,
        "message" => "Success",
        "todayData" => $todayResponse,
        "monthData" => [
            /*"month" => $month,
            "year" => $year,
            "total_days_in_month" => $monthTotalDays,
            "days_counted" => $daysToCheck,
            "full_working_days" => $fullDays,
            "half_days" => $halfDays,*/
            "working_days" => $workingDays,
            "present_days" => $presentDays,
            "absent_days" => $absentDays,
            "lateCount" => count($lateDays),
            "permissionCount" => count($permissionList),
            "halfDayCount" => count($halfDayList)
        ],
        "punchRecords" => $records,
        "presentDataList" => $dates,
        "absentDaysList" => $absentDaysList,
        "lateDaysList" => $lateDays,
        "permissionList" => $permissionList,
        "halfDayList" => $halfDayList
    ]);
} catch (Exception $e) {
    echo json_encode([
        "status" => false,
        "message" => $e->getMessage()
    ]);
}
