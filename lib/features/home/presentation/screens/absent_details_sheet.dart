import 'package:attendance/core/constant/appColors.dart';
import 'package:attendance/features/home/data/model/home_response_absent_model.dart';
import 'package:attendance/features/home/data/model/home_response_half_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class absentDetailsSheet extends StatelessWidget {
  final List<HomeResponseAbsentModel> data;
  final List<HomeResponseHalfModel>? halfData;
  dynamic days;

  absentDetailsSheet({
    super.key,
    required this.data,
    required this.halfData,
    required this.days,
  });

  String formatDate(String? date) {
    if (date == null) return '--';
    return DateFormat('dd MMM yyyy').format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
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

          const SizedBox(height: 18),

          Text(
            "Absent Details ($days Days)",
            style: TextStyle(
              fontSize: 22,
              color: primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),

          if (halfData != null && halfData!.isNotEmpty) ...[
            _sectionTitle("Permission To Half Day"),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: halfData!.length,
              itemBuilder: (context, index) {
                final item = halfData![index];

                return _statusCard(
                  date: item.date,
                  day: item.inTime,
                  isHalf: true,
                );
              },
            ),
          ],

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              itemBuilder: (_, index) {
                final item = data[index];
                final isHalf = (item.absentValue ?? 0) == 0.5;

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isHalf ? Colors.orange.shade50 : Colors.red.shade50,
                    border: Border.all(
                      color: isHalf
                          ? Colors.orange.shade200
                          : Colors.red.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: isHalf
                            ? Colors.orange.shade100
                            : Colors.red.shade100,
                        child: Icon(
                          isHalf ? Icons.schedule : Icons.event_busy,
                          color: isHalf ? Colors.orange : Colors.red,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatDate(item.date),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              item.day ?? '',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isHalf
                              ? Colors.orange.withOpacity(0.15)
                              : Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isHalf ? "Half Day" : "Absent",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isHalf ? Colors.orange : Colors.red,
                          ),
                        ),
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

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primaryBlue,
      ),
    );
  }

  Widget _statusCard({
    required String? date,
    required String? day,
    required bool isHalf,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isHalf ? Colors.orange.shade50 : Colors.red.shade50,
        border: Border.all(
          color: isHalf ? Colors.orange.shade200 : Colors.red.shade200,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: isHalf
                ? Colors.orange.shade100
                : Colors.red.shade100,
            child: Icon(
              isHalf ? Icons.schedule : Icons.event_busy,
              color: isHalf ? Colors.orange : Colors.red,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatDate(date),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(day?.split(" ")[1] ?? ''),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isHalf
                  ? Colors.orange.withOpacity(0.15)
                  : Colors.red.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(isHalf ? "Half Day" : "Absent"),
          ),
        ],
      ),
    );
  }
}
