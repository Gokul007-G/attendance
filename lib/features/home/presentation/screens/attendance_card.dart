

import 'package:attendance/componentes/custom_text/custom_text.dart';
import 'package:attendance/core/constant/appColors.dart';
import 'package:flutter/material.dart';

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
