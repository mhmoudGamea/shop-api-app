import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/data_provider.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_button_widget.dart';
import '../../widgets/text_form_field_widget.dart';
import 'signup_screen.dart';

class LogInScreen extends StatelessWidget {
  static const String rn = '/login_screen';

  LogInScreen({Key? key}) : super(key: key);

  String? email;
  String? password;
  final _form = GlobalKey<FormState>();

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
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log in',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 20),
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
                    builder: (context, data, _) {
                      if (data.getLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        );
                      }
                      return ButtonWidget(
                        firstGradient: primaryColor,
                        secondGradient: secondaryColor,
                        radius: 15,
                        text: 'Log in',
                        textSize: 16,
                        textColor: Colors.black,
                        function: () {
                          data.userLogin(context: context, email: email, password: password);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(fontSize: 11),
                      ),
                      const SizedBox(width: 5),
                      TextButtonWidget(
                        function: () {
                          Navigator.of(context).pushNamed(SignUpScreen.rn);
                        },
                        text: 'Sign up',
                        textColor: primaryColor,
                        textSize: 14,
                        letterSpace: -1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
