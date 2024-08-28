import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:palnt_app/Constant/colors.dart';
import 'package:palnt_app/Services/Responsive.dart';
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/View/Auth/Login/Controller/LoginController.dart';
import 'package:palnt_app/View/Auth/Login/LoginPage.dart';
import 'package:palnt_app/View/Auth/Signup/Controller/SignupController.dart';
import 'package:palnt_app/View/Auth/Widgets/CustomTextField.dart';
import 'package:provider/provider.dart';

final formkey = GlobalKey<FormState>();

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupController>(
      builder: (context, controller, child) => Scaffold(
        body: SafeArea(
          child: Form(
            key: formkey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "إنشاء حساب",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    Gap(5),
                    Divider(
                      color: kSecendryColor,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Logo.png',
                      width: Responsive.getWidth(context) * .5,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "مرحباً",
                        style: TextStyle(
                          color: kSecendryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "أنشئ حساب للمتابعة",
                        style: TextStyle(
                          color: kSecendryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFieled(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "يرجى إدخال اسم المستخدم";
                    }
                    return null;
                  },
                  controller: controller.usernamecontroller,
                  txt: "اسم المستخدم",
                  icon: Icon(
                    Icons.person_outline_outlined,
                    color: kSecendryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFieled(
                  txt: "البريد الالكتروني",
                  maxline: 1,
                  validator: (p0) {
                    RegExp regExp = RegExp(
                        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');
                    if (p0!.isEmpty) {
                      return "يرجى إدخال البريد الالكتروني";
                    } else if (!regExp.hasMatch(p0)) {
                      return "يرجى إدخال بريد الكتروني صالح";
                    }
                    return null;
                  },
                  controller: controller.emailcontroller,
                  icon: Icon(
                    Icons.email_outlined,
                    color: kSecendryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFieled(
                  maxline: 1,
                  validator: (p0) {
                    if (p0!.length < 6) {
                      return "يرجى إدخال كلمة مرور من 6 أحرف على الأقل";
                    }
                    return null;
                  },
                  controller: controller.passwordcontroller,
                  txt: "كلمة المرور",
                  icon: Icon(
                    Icons.lock_outlined,
                    color: kSecendryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFieled(
                  validator: (p0) {
                    if (controller.confirmpasswordcontroller.text !=
                        controller.passwordcontroller.text) {
                      return "كلمات المرور غير متطابقة";
                    }
                    return null;
                  },
                  controller: controller.confirmpasswordcontroller,
                  txt: "تأكيد كلمة المرور",
                  icon: Icon(
                    Icons.lock_outlined,
                    color: kSecendryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        controller.Signup(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kSecendryColor,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40)))),
                    child: Text("إنشاء حساب")),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        indent: 1,
                        color: Colors.black,
                      )),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("أو")),
                      Expanded(
                          child: Divider(
                        indent: 1,
                        color: Colors.black,
                      ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "هل لديك حساب؟",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () => CustomRoute.RouteReplacementTo(
                        context,
                        ChangeNotifierProvider(
                          create: (context) => LoginController(),
                          builder: (context, child) => LoginPage(),
                        ),
                      ),
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(color: kSecendryColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
