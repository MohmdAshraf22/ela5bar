import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news/modules/news_app/web_view/web_view.dart';

Widget defaultformfield({
  required TextEditingController controle ,
  TextInputType? type,
  bool obscure = false,
  String? label,
  String? hint,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? onpress,
  FormFieldValidator? validate,
  GestureTapCallback? ontap,
  bool isClickable = true,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  Color? iconColor,
  Color? textColor,
}) => TextFormField(
  onFieldSubmitted: onSubmit,
  enabled: isClickable,
  onTap: ontap,
validator: validate,
controller: controle,
keyboardType: type,
obscureText: obscure ,
decoration: InputDecoration(
  hintStyle: TextStyle(
    color: textColor
  ),
 labelStyle: TextStyle(
    color: textColor,
  ),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular (30),
  borderSide: BorderSide(
      width: 3,
  ),

),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
        width: 3,
    ),
  ),
labelText: label,
hintText: hint,
prefixIcon: Icon(
prefix,
  color: iconColor ,
),
suffixIcon:IconButton(
icon : Icon(
  suffix,
),

onPressed: onpress,
),
),
  onChanged: onChange,
);

Widget defaultTextButton({
  required VoidCallback onPress,
  required String text,
  Color? textColor,
  Color? pressColor,
  double? fontSize,
}) => TextButton(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return pressColor; //<-- SEE HERE
          return null; // Defer to the widget's default.
        },
      ),
    ),
    onPressed: onPress,
    child: Text(text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize
      ),));

Widget BuildArticleItem(list,context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(list['url']));
  },
  child:   Padding(
  
    padding: EdgeInsets.all(20),
  
    child: Row(
  
      children: [
  
        Container(
  
          height: 120,
  
          width: 120,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(12),
  
            image: DecorationImage(
  
              image: NetworkImage('${list['urlToImage']==null? 'https://image.shutterstock.com/image-vector/hacked-glitched-abstract-digital-background-260nw-1053850997.jpg' : list['urlToImage']}'),
  
              fit: BoxFit.cover,
  
            ),
  
          ),
  
        ),
  
        SizedBox(width: 15,),
  
        Expanded(
  
          child: Container(
  
            height: 130,
  
            child: Column(
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text('${list['title']}',
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                  ),
  
                ),
  
                Text('${list['publishedAt'] }',
  
                  style: TextStyle(
  
                      color: Colors.grey
  
                  ),),
  
              ],
  
            ),
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);

Widget myDivider() => Padding(
  padding:  EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey[400],
  ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) =>
      ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => BuildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,),
  fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
);

navigateTo(context , widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
navigateAndFinish(context , widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(
  builder: (context) => widget,
), (route) => false
);

void showToast({
  required String text ,
  required ToastColor state ,

}) =>  Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: ChangeToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastColor {SUCCESS,ERROR,WARNING}
Color ChangeToastColor(ToastColor state)
{
  Color color;
  switch(state){
    case ToastColor.SUCCESS:
    color = Colors.green;
    break;
    case ToastColor.ERROR:
      color = Colors.red;
      break;
    case ToastColor.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}






