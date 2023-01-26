import 'package:darkstore/components/constants.dart';
import 'package:darkstore/view/widget/halfheart_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defText({
  required String text,
  double size = 20,
  FontWeight fontWeight = FontWeight.bold,
  TextDecoration decoration = TextDecoration.none,
  Color decorationColor = Colors.black,
  Color color = Colors.white,
  int? maxlines,
  TextOverflow? overflow,
}) =>
    Text(
      text.tr,
      maxLines: maxlines,
      overflow: overflow,
      style: GoogleFonts.cairo(
        textStyle: TextStyle(fontSize: size, color: color),
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: TextDecorationStyle.wavy,
      ),
    );

Widget defTextForm({
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required String hint,
  TextDirection textdirection = TextDirection.ltr,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Function()? ontapPre,
  Function()? ontapSuff,
  FocusNode? focusNode,
  Function(String)? onchange,
  void Function()? ontap,
  bool obscureText = false,
  Color hintcolor = Colors.black,
  FontWeight fontWeight = FontWeight.bold,
  TextInputAction? textInputAction,
  TextInputType? textInputType,
}) =>
    TextFormField(
      obscureText: obscureText,
      onTap: ontap,
      onChanged: onchange,
      focusNode: focusNode,
      textDirection: textdirection,
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      decoration: InputDecoration(
          hintStyle: TextStyle(color: hintcolor, fontWeight: fontWeight),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: defcolor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: defcolor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          fillColor: Colors.grey[350],
          filled: true,
          prefixIcon: prefixIcon == null
              ? null
              : IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: ontapPre,
                  icon: Icon(
                    prefixIcon,
                    color: defcolor,
                  ),
                ),
          suffixIcon: suffixIcon == null
              ? null
              : IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: ontapSuff,
                  icon: Icon(
                    suffixIcon,
                    color: defcolor,
                  ),
                ),
          hintText: hint.tr),
    );

Widget defbutton(
        {bool boxshade = true,
        Color backgroundcolor = Colors.white,
        double radius = 10,
        required String text,
        Color? colors,
        required Function()? tap}) =>
    Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: boxshade == false
            ? null
            : [
                BoxShadow(
                  color: Colors.grey[900]!,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(3, 4),
                ),
              ],
      ),
      child: MaterialButton(
        onPressed: tap,
        child: defText(
            text: text, size: 20, color: colors == null ? defcolor : colors),
      ),
    );

Widget defcirculer() => Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        color: defcolor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: CircularProgressIndicator()),
    );

Widget starcont(
        {required String text,
        Widget widget = const Icon(
          Halfheart.star,
          color: Colors.yellow,
        )}) =>
    Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            widget,
            defText(text: text, size: 18),
          ],
        ),
      ),
    );

Widget defprice(
        {required int discount,
        required int price,
        required String finalprice}) =>
    Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: discount == 0
            ? defText(text: "${price} \$", size: 16)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  defText(
                    text: "$finalprice \$",
                    size: 18,
                  ),
                  defText(
                    text: "${price}",
                    decoration: TextDecoration.lineThrough,
                    size: 12,
                    color: Colors.red,
                  )
                ],
              ),
      ),
    );
