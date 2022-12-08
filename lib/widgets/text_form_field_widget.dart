import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/services/shared_preferences.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hint;
  final String prefix;
  final String suffixEye;
  final String suffixSlashEye;
  bool isObscure;
  final TextInputType type;
  final Function(String value)? onChange;
  final String? Function(String? validate) onValidate;

  TextFormFieldWidget({
    Key? key,
    required this.hint,
    this.type = TextInputType.text,
    this.onChange,
    required this.onValidate,
    required this.prefix,
    this.suffixEye = 'assets/images/eye.svg',
    this.suffixSlashEye = 'assets/images/eye_slash.svg',
    this.isObscure = false,
  }) : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    bool? darkMode = SharedPreferences.getData(isDark);
    return Container(
      height: 54,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.3,
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        obscureText: widget.isObscure,
        onChanged: (value) {
          widget.onChange!(value);
        },
        validator: (value) => widget.onValidate(value),
        cursorColor: darkMode != null ? (darkMode == true ? Colors.white : Colors.black) : Colors.black,
        keyboardType: widget.type,
        decoration: InputDecoration(
          prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(widget.prefix, width: 23, height: 23, color: primaryColor)),
          suffixIcon: widget.type != TextInputType.visiblePassword ? null : InkWell(
            onTap: () {
              setState(() {
                widget.isObscure = !widget.isObscure;
              });
            },
            child: SvgPicture.asset(widget.isObscure ? widget.suffixEye : widget.suffixSlashEye, width: 24, height: 24, color: primaryColor),
          ),
          prefixIconConstraints: const BoxConstraints(),
          suffixIconConstraints: const BoxConstraints(),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 5),
          hintText: widget.hint,
          hintStyle: Theme.of(context).textTheme.bodyText1,
        ),
        style: TextStyle(color: darkMode != null ? (darkMode == true ? Colors.white : Colors.black) : Colors.black, letterSpacing: 1, fontSize: 12),
      ),
    );
  }
}
