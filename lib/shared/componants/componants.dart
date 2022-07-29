import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

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

void showToast({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: choseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

//enum
enum ToastStates {SUCCESS ,ERROR, WARNING}

Color choseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildListItems(model,context , {bool isOldPrice = true,}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 120,
              width:120,
              fit: BoxFit.contain,
            ),
            if(model.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: .9,),
                child: const Text(
                  'Discount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    model.price!.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  if(model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice!.toString(),
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: AppCubit.get(context).favorites[model.id]! ? defaultColor: Colors.grey,
                    radius: 14,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()
                      {
                        AppCubit.get(context).changeFavorites(model.id!);
                      },
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);