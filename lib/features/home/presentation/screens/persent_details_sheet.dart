import 'package:attendance/core/constant/appColors.dart';
import 'package:attendance/features/home/data/model/home_response_present_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PresentDetailsSheet extends StatelessWidget {
  final List<HomeResponsePresentModel> data;

  const PresentDetailsSheet({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String formatDate(String? date) {
      if (date == null) return '--';
      return DateFormat('dd MMM yyyy').format(DateTime.parse(date));
    }

    String formatTime(String? datetime) {
      if (datetime == null) return '--';
      return DateFormat('hh:mm a').format(DateTime.parse(datetime));
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),

          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            "Present Details (${data.length})",
            style: TextStyle(
              fontSize: 22,
              color: primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: data.length,
              itemBuilder: (_, index) {
                final item = data[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: Offset(0, 2),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: successGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          formatDate(item.date),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: successGreen,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Expanded(
                            child: _timeCard(
                              icon: Icons.login,
                              title: "Check In",
                              value: formatTime(item.inTime),
                              isIn: true,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _timeCard(
                              icon: Icons.logout,
                              title: "Check Out",
                              value:
                                  formatTime(item.inTime) ==
                                      formatTime(item.outTime)
                                  ? "-"
                                  : formatTime(item.outTime),
                              isIn: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _timeCard({
  required IconData icon,
  required String title,
  required String value,
  required bool isIn,
}) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      children: [
        Icon(icon, color: isIn ? Colors.green : Colors.red),
        const SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    ),
  );
}
