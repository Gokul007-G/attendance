<?php
require_once '../config/config.php';
require_once '../config/db.php';

header('Content-Type: application/json');
$json = file_get_contents('php://input');
$data = json_decode($json, true);

try {
    $userId = $data['userId'] ?? null;

    if (isset($userId)) {
        // Check Employees table for normal Employees
        $stmt = $pdo->prepare("SELECT 
            EmployeeId as emp_id, 
            EmployeeName as emp_name, 
            Designation as designation,
            Location as location
            -- EmployeeCode as emp_code, 
            -- DepartmentId as dept_id
            FROM Employees WHERE EmployeeCode = ?");
        $stmt->execute([$userId]);
        $emp = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($emp) {
            $emp['role'] = 'Employee';
            echo json_encode(["message" => "Login successful", "status" => true, "data" => $emp]);
        } else {
            if ($userId == '0000') {
                $emp = [
                    'emp_id' => '0000',
                    'emp_code' => '0000',
                    'emp_name' => 'Admin',
                    'dept_id' => '0',
                    'role' => 'Admin'
                ];

                echo json_encode([
                    "message" => "Login successful",
                    "status" => true,
                    "data" => $emp
                ]);
            } elseif ($userId == '0017' || $userId == '17') {
                $emp = [
                    'emp_id' => '0017',
                    'emp_code' => '0017',
                    'emp_name' => 'HR',
                    'dept_id' => '0',
                    'role' => 'HR'
                ];

                echo json_encode([
                    "message" => "Login successful",
                    "status" => true,
                    "data" => $emp
                ]);
            } else {
                echo json_encode([
                    "message" => "Login Failed",
                    "status" => false
                ]);
            }
        }
    } else {
        echo json_encode(["message" => "Login failed :: User Id Required", "status" => false, "id" => $userId]);
    }
} catch (Exception $e) {
    echo json_encode(["message" => $e->getMessage(), "status" => false]);
}
