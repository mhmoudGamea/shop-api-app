import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/profile_provider.dart';

import '../../constants.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_form_field_widget.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  String? name;
  String? email;
  String? phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){Navigator.of(context).pop();},
          icon: const Icon(Icons.keyboard_backspace_rounded, color: primaryColor, size: 30),
        ),
        title: const Text(
          'Update Profile',
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
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
              Consumer<ProfileProvider>(
                builder: (context, data, _) {
                  return data.getIsLoading ? const Center(child: CircularProgressIndicator(color: primaryColor,),) : ButtonWidget(
                    firstGradient: primaryColor,
                    secondGradient: secondaryColor,
                    radius: 15,
                    text: 'Update',
                    textSize: 16,
                    textColor: Colors.black,
                    function: (){
                      data.updateProfile(context: context, name: name, phone: phone, email: email);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
