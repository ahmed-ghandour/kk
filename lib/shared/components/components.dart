import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultButton ({
  double width = double.infinity ,
  Color background = Colors.blue,
  required String text ,
  required VoidCallback function,
  bool isUpperCase = true
    })=> Container(
    width: width ,
    child: MaterialButton(
        onPressed: function,
        child :
              Text(
                isUpperCase ? text.toUpperCase() : text ,
                style: const TextStyle( color: Colors.white),
              ),
        ),
    decoration: BoxDecoration( borderRadius : BorderRadius.circular(10.0),
      color: background,
    )
    );
Widget defaultTextButton({
  required String text,
  required VoidCallback function,
}) =>TextButton(onPressed: function, child: Text(text.toUpperCase()));

Widget defaultFormField (
{
  required String label,
  required TextEditingController controller,
  TextInputType? type,
  required IconData prefix,
  IconData? suffix,
  bool isPasword = false,
  required final String? Function (String? value)? validate,
  final void Function (String? value)? onSubmit,
  final void Function (String? value)? onChange,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
}
    )=> TextFormField(
  controller: controller ,
  keyboardType: type,
  obscureText: isPasword,
  decoration: InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ? IconButton(
        icon : Icon(suffix),
        onPressed : suffixPressed ): null

  ),
  validator: validate,
  onTap: onTap,
  onFieldSubmitted: onSubmit,
  onChanged: onChange
);


Widget dividerBuilder()=>Container(
  color: Colors.grey[300],
  height: 1,
  width: double.infinity,
);

void navigateTo(context,widget) => Navigator.push(context,
    MaterialPageRoute( builder:(context) => widget)
);
void navigateAndFinish(context,widget) =>
    Navigator.pushAndRemoveUntil( context,
      MaterialPageRoute(
        builder: (context) => widget),
          (route)
      {
        return false;
      },
);

void showToast({
  required String text,
  required ToastStates state,
})=> Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: choseToastColor(state) ,
textColor: Colors.white,
fontSize: 16.0
);

enum ToastStates { success , error , warning }
Color choseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.success :
      color =  Colors.green;
      break;
    case ToastStates.error :
      color = Colors.red;
      break;
    case ToastStates.warning :
      color = Colors.amber;
      break;
  }
  return color;

}

Widget buildListProducts(model,context,{bool isOldPrice = true})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 120,
              width: 120,
            ),
            if(model.discount !=0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(
                    horizontal:5 ),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
              )
          ],
        ),
        const SizedBox(
          width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text(model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13,
                    height: 1.3
                ),
              ),
              const Spacer(),
              Row(
                children:
                [
                  Text(model.price.toString() + " L.E",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize:14,
                        height: 1.3,
                        color: defaultColor
                    ),),
                  const SizedBox(
                    width: 5,),
                  if(model.discount != 0 && isOldPrice)
                    Text(model.oldPrice.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ) ,
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id!);

                    },
                    icon:CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favourites[model.id!]! ? defaultColor : Colors.grey,
                      child:  const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ]
            ,),
        )
      ],
    ),
  ),
);


