import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/shared/style/colors.dart';

Widget customTextField({
  @required TextEditingController controller,
  @required TextInputType textType,
  @required String label,
  @required Icon prefixIcon,
  IconButton suffixIcon,
  int lines = 1,
  Function validator,
  Function onTab,
  bool visibility,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: textType,
    maxLines: lines,
    obscureText: visibility ?? false,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue.shade800,
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green,
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    validator: validator,
    onTap: onTab,
  );
}

Widget customText({
  @required String text,
  @required Color color,
  @required double fontSize,
  FontWeight fontWeight = FontWeight.normal,
  FontStyle fontStyle,
  bool softWrap,
  TextOverflow overflow,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    ),
    softWrap: softWrap,
    overflow: TextOverflow.ellipsis,
  );
}

Widget customButton({
  @required BuildContext context,
  @required String title,
  @required Function onClick,
  Color color,
  double radius,
  double height,
  double width,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onClick,
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          )),
    ),
  );
}

Widget customCard({
  @required String title,
  @required String description,
  @required String time,
  @required String date,
  @required String stateTask,
  @required Color colorText,
}) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: colorText,
              boxShadow: [
                BoxShadow(
                  color: colorText,
                  blurRadius: 10,
                  offset: Offset.zero,
                ),
              ],
            ),
            child: Text(
              stateTask,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            /*child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: colorText,
                  radius: 8,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  stateTask,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),*/
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.indigo.shade900,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.date_range,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.indigo.shade900,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
