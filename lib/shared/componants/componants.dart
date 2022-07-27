import 'package:flutter/material.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
        (route)
        {
          return false;
        }
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  String? Function(String? s)? onSubmit,
  String? Function(String? s)? onChange,
  required String? Function(String? val)? validator,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function? suffixPressed,

}) => TextFormField(
  controller: controller,
  keyboardType:type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: IconButton(
      icon: Icon(
        suffix,
      ),
      onPressed: ()
      {
        suffixPressed!();
      },
    ),
  ),
  validator: validator,
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 0.0,
  bool isUpperCase = true,
  required Function function,
  required String text,
}) => Container(
  width: width,
  height: 50,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: background,
  ),
  child: MaterialButton(
    onPressed: (){
      function();
    },
    child: Text(
      isUpperCase? text.toUpperCase() : text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),

  ),
);

Widget defaultTextButton({
  required String text,
  required Function function,
}) => TextButton(
    onPressed: ()
    {
      function();
    },
    child: Text(
      text.toUpperCase(),
    ),
);
