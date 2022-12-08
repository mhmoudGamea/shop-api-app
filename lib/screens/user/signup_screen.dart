import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/providers/data_provider.dart';

import '../../widgets/text_form_field_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_button_widget.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const String rn = '/signup_screen';

  SignUpScreen({Key? key}) : super(key: key);

  String? name;
  String? email;
  String? phone;
  String? password;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign up',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  hint: 'Name',
                  prefix: 'assets/images/person.svg',
                  onChange: (nameValue) {
                    name = nameValue;
                  },
                  onValidate: (validator) {
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  hint: 'Email',
                  prefix: 'assets/images/message.svg',
                  type: TextInputType.emailAddress,
                  onChange: (emailValue) {
                    email = emailValue;
                  },
                  onValidate: (validator) {
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  hint: 'Phone',
                  prefix: 'assets/images/mobile.svg',
                  type: TextInputType.phone,
                  onChange: (phoneValue) {
                    phone = phoneValue;
                  },
                  onValidate: (validator) {
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  hint: 'Password',
                  prefix: 'assets/images/lock.svg',
                  type: TextInputType.visiblePassword,
                  onChange: (passwordValue) {
                    password = passwordValue;
                  },
                  onValidate: (validator) {
                    return null;
                  },
                  isObscure: true,
                ),
                const SizedBox(height: 30),
                Consumer<DataProvider>(
                  builder: (context, data, _) => ButtonWidget(
                    firstGradient: primaryColor,
                    secondGradient: secondaryColor,
                    radius: 15,
                    text: 'Sign up',
                    textSize: 16,
                    textColor: Colors.black,
                    function: (){
                        data.userRegister(context: context, name: name, email: email, phone: phone, password: password);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ', style: TextStyle(fontSize: 11),),
                    const SizedBox(width: 5),
                    TextButtonWidget(function: (){
                      Navigator.of(context).pushNamed(LogInScreen.rn);
                    }, text: 'Log in', textColor: primaryColor, textSize: 14, letterSpace: -1,),
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
