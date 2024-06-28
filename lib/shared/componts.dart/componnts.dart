import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../style/colors.dart';

void navigatorFinish(context, wScreen) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => wScreen,
      ),
      (Route<dynamic> route) => false,
    );
void navigatorTo(context, wScreen) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => wScreen,
      ),
    );
AppBar defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(IconBroken.Arrow___Left_2)),
      title: title != null ? Text(title) : null,
      titleSpacing: 0.0,
      actions: actions,
    );
Widget buildTextField(
        {required TextEditingController? controller,
        required String? Function(String?)? validator,
        TextInputType textInputType = TextInputType.text,
        required String label,
        required IconData preFixIcon,
        IconData? sufFixIcon,
        Function? sufFixIconPress,
        Function(String)? onSubmitted,
        bool obscureText = false}) =>
    TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: textInputType,
      obscureText: obscureText,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        suffixIcon: sufFixIcon != null
            ? IconButton(
                onPressed: () {
                  sufFixIconPress!();
                },
                icon: Icon(sufFixIcon))
            : null,
        labelText: label,
        prefixIcon: Icon(preFixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
Widget defaultTextButton({
  required Function() onPress,
  required String label,
  MaterialColor color = defaultColorThem,
}) =>
    TextButton(
      onPressed: onPress,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          fontFamily: 'font1',
          color: color,
        ),
      ),
    );
Widget defaultMartialButton(
        {required String label,
        bool isUpperCase = false,
        required Function() btnOnPress,
        double height = 50}) =>
    Container(
      width: double.infinity,
      child: MaterialButton(
        onPressed: btnOnPress,
        color: defaultColorThem,
        height: height,
        child: Text(
          isUpperCase ? label.toUpperCase() : label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'font1',
          ),
        ),
      ),
    );
//////////////////////////////////////////////
void showTost({
  required String msg,
  required TostState state,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: selectTostSates(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

// ignore: constant_identifier_names
enum TostState { SUCCESS, ERROR, WARNING }

Color selectTostSates(TostState state) {
  Color color;
  switch (state) {
    case TostState.ERROR:
      color = Colors.red;
      break;
    case TostState.SUCCESS:
      color = Colors.green;
      break;
    case TostState.WARNING:
      color = Colors.orange;
      break;
  }
  return color;
}
//////////////////////////////////