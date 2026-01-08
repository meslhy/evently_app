import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:evently_app1/core/resources/StringManager.dart';
import 'package:evently_app1/core/reusable_componant/CustomButton.dart';
import 'package:evently_app1/core/reusable_componant/CustomSwitch.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/AssetsManager.dart';

class StartScreen extends StatefulWidget {
  static const String routeName = "StartScreen";


   StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int selectedLanguage = 0;

  int selectedTheme = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManager.startLogo),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 28
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                    Theme.of(context).brightness == Brightness.light ?
                AssetsManager.startPhotoLight :
                AssetsManager.startPhotoDark ,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 28,),
              Text(StringManager.startTitle , style:Theme.of(context).textTheme.titleMedium ),
              const SizedBox(height: 28,),
              Text(StringManager.startDesc , style:Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 28,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringManager.language,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500
                  ),),
                  CustomSwitch(item1: AssetsManager.us,
                    item2: AssetsManager.eg,
                    selected: selectedLanguage,
                    onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;

                    });
                    },
                  )
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringManager.them,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500
                  ),),
                  CustomSwitch(item1: AssetsManager.sun,
                    item2: AssetsManager.moon,
                    isColored: true, selected: selectedTheme,
                    onChanged: (value) {
                      setState(() {
                        selectedTheme = value;

                      });
                    },)
                ],
              ),
              const SizedBox(height: 28,),
              CustomButton(
                  title: StringManager.begin,
                  onTap: (){})
            ],
          ),
        ),
      ),
    );
  }
}
