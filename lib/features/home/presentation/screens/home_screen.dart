import 'package:attendance/componentes/custom_text/custom_text.dart';
import 'package:attendance/core/constant/appColors.dart';
import 'package:attendance/core/utils/local_data_store.dart';
import 'package:attendance/core/utils/logger.dart';
import 'package:attendance/features/home/presentation/provider/home_provider.dart';
import 'package:attendance/features/home/presentation/screens/absent_details_sheet.dart';
import 'package:attendance/features/home/presentation/screens/permit_details_sheet.dart';
import 'package:attendance/features/home/presentation/screens/persent_details_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final outTime = homeProvider.homeResponseModel.todayData;
    final isCheckedOut = outTime != null;

    final monthData = homeProvider.homeResponseModel.monthData;
    return Scaffold(
      //Show the
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            backgroundColor: whiteBg,
            child: Icon(Icons.person, color: white),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.bodyBold(
                    HiveService.instance.getUserName() ?? '',
                    white,
                  ),
                  CustomText.caption(
                    HiveService.instance.getUserDept() ?? '',
                    white,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: whiteBg,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.notifications_active, color: white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          //Working time Container
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.28,
            child: Stack(
              // clipBehavior: Clip.none,
              children: [
                // Header
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.13,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    decoration: const BoxDecoration(
                      color: secondaryBlue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: white,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            CustomText.bodyBold('Today Attendance', white),
                          ],
                        ),
                        CustomText.captionTwo(
                          DateFormat('dd MMM, yyyy').format(DateTime.now()),
                          white,
                        ),
                      ],
                    ),
                  ),
                ),

                // Card
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.065,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: cardShadow.withOpacity(0.12),
                          blurRadius: 18,
                          spreadRadius: 2,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.schedule, color: primaryBlue, size: 20),
                            const SizedBox(width: 6),
                            CustomText.body("Working Time", greyText),
                          ],
                        ),

                        const SizedBox(height: 14),

                        CustomText.headingOne("09 : 00 : AM", primaryBlue),

                        const SizedBox(height: 16),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: loginBgColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: errorRed,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              CustomText.body(
                                HiveService.instance.getUserLocation(),
                                textDark,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Button no needs
                // Positioned(
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   child: Center(
                //     child: ElevatedButton.icon(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: accentGreen,
                //         foregroundColor: white,
                //         elevation: 3,
                //         shadowColor: successGreen,
                //         padding: const EdgeInsets.symmetric(
                //           horizontal: 28,
                //           vertical: 14,
                //         ),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //       ),
                //       icon: const Icon(Icons.logout),
                //       onPressed: () {},
                //       label: const Text(
                //         'Check Out',
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),

          //Today Log Details
          GestureDetector(
            onTap: homeProvider.homeResponseModel.punchData != null
                ? () {
                    Log.i("-----------Punch Records Start-----------");
                    showDialog(
                      context: context,
                      builder: (_) {
                        final punchList =
                            homeProvider.homeResponseModel.punchData ?? [];

                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            constraints: const BoxConstraints(maxHeight: 500),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_filled,
                                      color: primaryBlue,
                                      size: 28,
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      child: Text(
                                        "Punch Details",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                Divider(),

                                const SizedBox(height: 8),

                                Expanded(
                                  child: ListView.separated(
                                    itemCount: punchList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 10),
                                    itemBuilder: (_, index) {
                                      final punch = punchList[index];

                                      final dateTime = DateTime.parse(
                                        punch.date!,
                                      );

                                      final formattedTime = DateFormat(
                                        'hh:mm a',
                                      ).format(dateTime);

                                      final isCheckIn = index % 2 == 0;

                                      return Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: background,
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          border: Border.all(
                                            color: isCheckIn
                                                ? successGreen.withOpacity(0.4)
                                                : warning.withOpacity(0.4),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              child: Icon(
                                                isCheckIn
                                                    ? Icons.login
                                                    : Icons.logout,
                                              ),
                                            ),
                                            const SizedBox(width: 12),

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    isCheckIn
                                                        ? "Check In"
                                                        : "Check Out",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(formattedTime),
                                                ],
                                              ),
                                            ),

                                            Text("#${index + 1}"),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    Log.i("------------Punch Records End------------");
                  }
                : null,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryBlue.withOpacity(0.2)),
                color: cardBg,
                boxShadow: [
                  BoxShadow(
                    color: cardShadow.withOpacity(0.15),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  attendanceItem(
                    Icons.login,
                    homeProvider.homeResponseModel.todayData?.inTime ?? "-",
                    'Check-In',
                    primaryBlue,
                  ),

                  const SizedBox(
                    height: 70,
                    child: VerticalDivider(thickness: 1),
                  ),

                  attendanceItem(
                    isCheckedOut ? Icons.logout : Icons.access_time,
                    outTime?.outTime ??
                        (outTime?.inTime != null ? "Still Working" : '-'),
                    'Check-Out',
                    isCheckedOut ? successColor : warningColor,
                  ),

                  const SizedBox(
                    height: 70,
                    child: VerticalDivider(thickness: 1),
                  ),

                  attendanceItem(
                    Icons.hourglass_bottom,
                    homeProvider.homeResponseModel.todayData?.workingHours ??
                        "-",
                    'Hours',
                    secondaryBlue,
                  ),
                ],
              ),
            ),
          ),

          //Select the attendance for month
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.headingFive(
                      "Full Working Days : ${monthData?.workingDays ?? 0}",
                      black,
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () async {
                        final DateTime? selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2016),
                          lastDate: DateTime.now(),
                          initialDate: DateTime.now(),
                        );

                        if (selectedDate != null) {
                          homeProvider.selectedDate = selectedDate;

                          print(selectedDate); // full date
                          print(
                            DateFormat('M yyyy').format(selectedDate),
                          ); // month + year
                          print(selectedDate.month); // month number
                          print(selectedDate.year); // year

                          homeProvider
                              .execute(); // Call the execute method to refresh data
                        }
                      },
                      label: Text(
                        DateFormat(
                          'MMMM yyyy',
                        ).format(homeProvider.selectedDate),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //show days for attendance

          //Persent and absents conatiner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap:
                        homeProvider.homeResponseModel.presentData != null &&
                            homeProvider
                                .homeResponseModel
                                .presentData!
                                .isNotEmpty
                        ? () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => PresentDetailsSheet(
                                data:
                                    homeProvider
                                        .homeResponseModel
                                        .presentData ??
                                    [],
                              ),
                            );
                          }
                        : null,
                    child: attendanceCard(
                      text: 'Present',
                      icon: Icons.check_circle,
                      days: monthData?.persent ?? 0,
                      color: successGreen,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: GestureDetector(
                    onTap:
                        homeProvider.homeResponseModel.absentData != null &&
                            homeProvider
                                .homeResponseModel
                                .absentData!
                                .isNotEmpty
                        ? () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => AbsentDetailsSheet(
                                data:
                                    homeProvider.homeResponseModel.absentData ??
                                    [],
                                days:
                                    ((monthData?.absent ?? 0) +
                                    (monthData?.halfDay ?? 0)),
                                halfData:
                                    homeProvider.homeResponseModel.halfData ??
                                    [],
                              ),
                            );
                          }
                        : null,
                    child: attendanceCard(
                      text: 'Absents',
                      icon: Icons.event_busy,
                      days:
                          ((monthData?.absent ?? 0) +
                          (monthData?.halfDay ?? 0)),
                      color: errorRed,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //Persent and late permission
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap:
                        (homeProvider.homeResponseModel.lateData?.isNotEmpty ??
                            false)
                        ? () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => PermitDetailsSheet(
                                title: "Late Details",
                                data:
                                    homeProvider.homeResponseModel.lateData ??
                                    [],
                                color: warning,
                                icon: Icons.access_time,
                              ),
                            );
                          }
                        : null,
                    child: attendanceCard(
                      text: 'Late',
                      icon: Icons.access_time,
                      days: monthData?.late ?? 0,
                      color: warning,
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                Expanded(
                  child: GestureDetector(
                    onTap:
                        (homeProvider
                                .homeResponseModel
                                .permissionData
                                ?.isNotEmpty ??
                            false)
                        ? () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => PermitDetailsSheet(
                                title: "Permission Details",
                                data:
                                    homeProvider
                                        .homeResponseModel
                                        .permissionData ??
                                    [],
                                color: secondaryBlue,
                                icon: Icons.cancel,
                              ),
                            );
                          }
                        : null,
                    child: attendanceCard(
                      text: 'Permit',
                      icon: Icons.cancel,
                      days: monthData?.permission ?? 0,
                      color: secondaryBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget attendanceItem(IconData icon, String time, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 10),
        CustomText.bodyBold(time, black),
        const SizedBox(height: 6),
        CustomText.body(label, color),
      ],
    );
  }
}

// ignore: must_be_immutable
class attendanceCard extends StatelessWidget {
  String text;
  IconData icon;
  int days;
  Color color;

  attendanceCard({
    super.key,
    required this.text,
    required this.icon,
    required this.days,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.bodyBold(text, black),
                  const SizedBox(height: 4),
                  CustomText.caption('This Month', greyText),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText.headingFive(days.toString(), color),
              const SizedBox(height: 4),
              CustomText.caption('Days', greyText),
            ],
          ),
        ],
      ),
    );
  }
}
