import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({ Key? key, this.height=50, this.width=100, required this.color,required this.text, required this.onTap, this.textColor=Colors.white,  this.pading=false }) : super(key: key);
  final double height;
  final double width;
  final Color color;
  final String text;
  final Function onTap;
  final Color textColor;
  final bool pading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){ onTap();},
      child: Container(
        height: height,
        width: width,
        
        padding:pading?const EdgeInsets.all(3): const EdgeInsets.symmetric(vertical:8,horizontal: 8),
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius:const BorderRadius.all(Radius.circular(5))
        ),
        child: FittedBox(
          child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor,fontSize: 15,),),
        ),
    
        
      ),
    );
  }
}