import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app1/core/DilogUtils.dart';
import 'package:evently_app1/core/reusable_componant/CustomButton.dart';
import 'package:evently_app1/core/reusable_componant/CustomTextButton.dart';
import 'package:evently_app1/core/reusable_componant/CustomTextFF.dart';
import 'package:evently_app1/model/user/user_model.dart';
import 'package:evently_app1/providers/UserProvider.dart';
import 'package:evently_app1/ui/auth/forgetPass/screen/forget_pass_screen.dart';
import 'package:evently_app1/ui/home/screen/home_screen.dart';
import 'package:evently_app1/ui/splash/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/FirestoreHandler.dart';
import '../../../../core/resources/AssetsManager.dart';
import '../../../../core/resources/StringManager.dart';
import '../../../../core/reusable_componant/CustomSwitch.dart';
import '../../register/screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedLanguage = 0 ;



  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState>  formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode == 'en' ? 0 : 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.register),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                //forgetPass
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: CustomTextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, ForgetPassScreen.routeName);
                    },
                    title: StringManager.forgetPass.tr(),
                  ),
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    title: StringManager.login.tr(),
                    onTap: (){
                      if(formKey.currentState!.validate()){
                        signin(emailController , passwordController , context).then((value) {
                          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                        });
        
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        StringManager.dontHaveAcc.tr(),
                        style: Theme.of(context).textTheme.bodySmall
                    ),
                    CustomTextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, RegisterScreen.routeName);
                        },
                        title: StringManager.createAcc.tr(),
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
      ),
    );
  }

}

signin(TextEditingController emailController ,TextEditingController passwordController , BuildContext context)async{
  UserProvider provider = Provider.of<UserProvider>(context , listen: false);
  try {
    dilogUtils().showLoadingDialog(context,);
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
    );
    UserModel? user = await FirestoreHandler().getUser(credential.user!.uid);
    provider.saveUser(user);
    Navigator.pop(context);
    print("id :  ${credential.user?.uid}");
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    if (e.code == 'user-not-found') {
      dilogUtils().showCustomDialog(
          context: context,
          title: "No user found for that email.",
          message: 'No user found for that email.',
          confirmText: 'ok',
          onConfirm: () {  }

      );
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
