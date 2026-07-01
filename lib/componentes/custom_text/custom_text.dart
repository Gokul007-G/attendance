import 'package:attendance/componentes/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;

  const CustomText.headingOne(this.text, this.color, {super.key})
    : style = heading1Style;
  const CustomText.headingTwo(this.text, this.color, {super.key})
    : style = heading2Style;
  const CustomText.headingThree(this.text, this.color, {super.key})
    : style = heading3Style;
  const CustomText.headingFour(this.text, this.color, {super.key})
    : style = heading4Style;
  const CustomText.headingFive(this.text, this.color, {super.key})
    : style = heading5Style;
  const CustomText.headline(this.text, this.color, {super.key})
    : style = headlineStyle;
  const CustomText.subheading(this.text, this.color, {super.key})
    : style = subheadingStyle;
  const CustomText.caption(this.text, this.color, {super.key})
    : style = captionStyle;
  const CustomText.captionOne(this.text, this.color, {super.key})
    : style = caption1Style;
  const CustomText.captionTwo(this.text, this.color, {super.key})
    : style = caption2Style;
  const CustomText.body(this.text, this.color, {super.key}) : style = bodyStyle;
  const CustomText.bodyBold(this.text, this.color, {super.key})
    : style = bodyStyleBold;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: true,
      style: GoogleFonts.poppins(textStyle: style, color: color),
    );
  }
}
