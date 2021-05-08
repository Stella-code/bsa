import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key key,
    this.label = "Enter Text",
    this.hint = "Enter Text",
    this.obscure = false,
    this.prefixIcon,
    this.size,
    Function(dynamic) onChanged,
  }) : super(key: key);

  final String label;
  final String hint;
  final bool obscure;
  final IconData prefixIcon;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width,
      child: Column(
        children: <Widget>[
          TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            obscureText: obscure,
            decoration: InputDecoration(
                icon: Icon(
                  prefixIcon,
                  color: Colors.white,
                ),
                hintText: hint,
                labelText: label,
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                fillColor: Colors.blue,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 3.0),
                ),
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.5),
                    borderRadius: BorderRadius.circular(5.0))),
          ),
          Divider(
            color: Colors.white,
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}
