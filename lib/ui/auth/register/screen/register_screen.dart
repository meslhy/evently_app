import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app1/core/reusable_componant/CustomButton.dart';
import 'package:evently_app1/core/reusable_componant/CustomTextFF.dart';
import 'package:evently_app1/ui/auth/login/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/AssetsManager.dart';
import '../../../../core/resources/StringManager.dart';
import '../../../../core/reusable_componant/CustomSwitch.dart';
import '../../../../core/reusable_componant/CustomTextButton.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "RegisterScreen";

   RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int selectedLanguage = 0 ;


  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState>  formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode == 'en' ? 0 : 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.register),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24,),
              Image.asset(
                AssetsManager.logo,
              ),
              const SizedBox(height: 24,),
              //name
              CustomTextFormField(
                  label: StringManager.name.tr(),
                  controller: nameController,
                  keyboardType: TextInputType.name,
                validator: (value) {
                    if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                prefixIcon: Icon(Icons.person),

              ),
              //email
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
              //pass
              const SizedBox(height: 16,),
              CustomTextFormField(
                label: StringManager.pass.tr(),
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icon(Icons.lock),
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              //repass
              const SizedBox(height: 16,),
              CustomTextFormField(
                label: StringManager.rePass.tr(),
                controller: rePasswordController,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icon(Icons.lock),
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                }
              ),
              const SizedBox(height: 16,),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                    title: StringManager.createAccount.tr(),
                    onTap: (){
                      if(formKey.currentState!.validate()){
                        signup(emailController , passwordController);
                        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                        print("ffffffffffffffffffffffffffffffffffffffffffffffffff");
                      }
                    },
                ),
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringManager.haveAcc.tr(),
                    style: Theme.of(context).textTheme.bodySmall
                  ),
                  CustomTextButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },
                    title: StringManager.login.tr(),
                  )
                ],
              ),
              const SizedBox(height: 5,),
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
        ),
      ),
    );
  }
}


signup(emailController , passwordController )async{
  try{
    UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
    );

    print("ffffffffffffffffffffffffffffffffffffffffffffffffff");
  }catch(e){
    print(e);
  }


}
