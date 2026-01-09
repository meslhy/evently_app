import 'package:easy_localization/easy_localization.dart';
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
  int selectedLanguage = 0 ;

  int selectedTheme = 0;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async{
    //
    // });
  }
  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode == 'en' ? 0 : 1;
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
              Text(StringManager.startTitle.tr() , style:Theme.of(context).textTheme.titleMedium ),
              const SizedBox(height: 28,),
              Text(StringManager.startDesc.tr() , style:Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 28,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringManager.language.tr(),style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500
                  ),),
                  CustomSwitch(item1: AssetsManager.us,
                    item2: AssetsManager.eg,
                    selected: selectedLanguage,
                    onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;
                      if(value == 1)
                        {
                        context.setLocale(Locale('ar'));
                        }else{
                        context.setLocale(Locale('en'));
                      }

                    });
                    },
                  )
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringManager.theme.tr(),style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                  title: StringManager.begin.tr(),
                  onTap: (){})
            ],
          ),
        ),
      ),
    );
  }
}
