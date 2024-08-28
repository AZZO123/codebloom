import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:palnt_app/Constant/colors.dart';
import 'package:palnt_app/Services/Responsive.dart';
import 'package:palnt_app/View/Auth/Login/Controller/LoginController.dart';
import 'package:palnt_app/View/Auth/Widgets/CustomTextField.dart';
import 'package:provider/provider.dart';

final formkey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<LoginController>(
        builder: (context, controller, child) => Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("تسجيل الدخول",
                      style: TextStyle(
                        color: Colors.black54,
                      )),
                  Gap(5),
                  Divider(
                    color: Colors.green.shade200,
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
              Column(
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
                    "الرجاء التسجيل للمتابعة",
                    style: TextStyle(
                      color: kSecendryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              Gap(20),
              CustomTextFieled(
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
                txt: "البريد الالكتروني",
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
              Gap(10),
              ElevatedButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    await controller.Login(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSecendryColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                child: Text("تسجيل الدخول"),
              ),
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
                    "هل ترغب في إنشاء حساب؟",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () => controller.toSignUpPage(context),
                    child: Text(
                      "تسجيل",
                      style: TextStyle(color: kSecendryColor),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
