import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app1/core/DilogUtils.dart';
import 'package:evently_app1/core/resources/AssetsManager.dart';
import 'package:evently_app1/core/reusable_componant/CustomButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/StringManager.dart';
import '../../../../core/reusable_componant/CustomTextFF.dart';

class ForgetPassScreen extends StatelessWidget {
  static const String routeName = "ForgetPassScreen";
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState>  formKey = GlobalKey<FormState>();
   ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.forgetPass),
      ),
      body:Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                    AssetsManager.forgetPic,
                ),
              ),
              const SizedBox(height: 16,),
              CustomTextFormField(
                label: StringManager.email.tr(),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24,),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                    title:StringManager.resetPass.tr() ,
                    onTap: ()async{
                      dilogUtils().showLoadingDialog(context);
                     if(formKey.currentState!.validate()){
                       await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
                         print("successssssss");
                       });
                     }
                     Navigator.pop(context);
                     dilogUtils().showToast("Email sent");
                      Navigator.pop(context);



                    }
                ),
              ),
              const Spacer()
            ]
          ),
        ),
      )

    );
  }
}
