import 'package:evently_app1/core/resources/AppStyle.dart';
import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:evently_app1/providers/ThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);

    return Container(
      margin: EdgeInsets.all(12),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage("assets/images/eventsBG/BookClubImage.png"),
          fit: BoxFit.fill,
        ),
          border: Border.all(
              color: ColorManager.blue,
              width: 1
          )
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            width:54 ,
            height: 58,
            decoration: BoxDecoration(
              color: provider.themeMode == ThemeMode.dark ? ColorManager.darkBackground : ColorManager.lightBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorManager.blue,
                width: 1
              )

            ),
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    "21",
                    style: TextStyle(
                      color: ColorManager.blue,
                      fontSize: 18
                    )
                  ),
                ),
                Expanded(
                  child: Text(
                    "Nov",
                    style: TextStyle(
                      color: ColorManager.blue,
                      fontSize: 14
                    )
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            width:double.infinity ,
            height: 58,
            decoration: BoxDecoration(
              color: provider.themeMode == ThemeMode.dark ? ColorManager.darkBackground.withOpacity(0.95) : ColorManager.lightBackground.withOpacity(0.95),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "playing football with friends!!",
                    style: TextStyle(
                      color: provider.themeMode == ThemeMode.dark ? ColorManager.white : ColorManager.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                    )
                  ),
                  flex: 80,
                ),
                Expanded(
                  child: Align(
                      child: Icon(CupertinoIcons.heart , color: ColorManager.blue, size: 25,),
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                  flex: 20,
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}
