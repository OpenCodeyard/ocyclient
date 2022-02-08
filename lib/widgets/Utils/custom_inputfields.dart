import 'package:flutter/material.dart';
import 'package:gosclient/configs/config.dart';
import 'package:universal_io/io.dart';

buildInputFieldThemColor(
  String label,
  IconData icon,
  TextInputType type,
  TextEditingController controller,
  BuildContext context,
  bool isLast,
  FocusNode node,
  FocusNode? nextNode,
  bool isEnabled,
  String? Function(String?)? validator,
) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      TextFormField(
        controller: controller,
        textInputAction: (Platform.isIOS || Platform.isMacOS)
            ? TextInputAction.none
            : isLast
                ? TextInputAction.done
                : TextInputAction.next,
        focusNode: node,
        enabled: isEnabled,
        onFieldSubmitted: (s) {
          if (nextNode != null) {
            nextNode.requestFocus();
          } else if (isLast) {
            FocusScope.of(context).unfocus();
          } else {
            FocusScope.of(context).nextFocus();
          }
        },
        validator: validator,
        autofocus: false,
        style: const TextStyle(
          color: Colors.black,
        ),
        keyboardType: type,
        cursorColor: Config.themeColor,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(
            icon,
            size: 18,
            color: Colors.black,
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.black,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              width: 2,
              color: Config.themeColor,
              style: BorderStyle.solid,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.blueGrey,
              style: BorderStyle.solid,
            ),
          ),
        ),
      )
    ],
  );
}

buildDescInputFieldThemColor(
  String label,
  IconData icon,
  TextInputType type,
  TextEditingController controller,
  BuildContext context,
  FocusNode node,
  FocusNode? nextNode,
  bool isEnabled,
  bool isLast,
) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      TextFormField(
        controller: controller,
        autocorrect: true,
        keyboardType: type,
        minLines: 5,
        autofocus: false,
        maxLines: null,
        style: const TextStyle(
          color: Colors.black,
        ),
        textInputAction: (Platform.isIOS || Platform.isMacOS)
            ? TextInputAction.none
            : TextInputAction.next,
        onFieldSubmitted: (s) {
          if (nextNode != null) {
            FocusScope.of(context).requestFocus(nextNode);
          } else if (isLast) {
            FocusScope.of(context).unfocus();
          } else {
            FocusScope.of(context).nextFocus();
          }
        },
        focusNode: node,
        enabled: isEnabled,
        cursorColor: Config.themeColor,
        maxLength: 300,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(
            icon,
            size: 18,
            color: Colors.black,
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.black,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              width: 2,
              color: Config.themeColor,
              style: BorderStyle.solid,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.blueGrey,
              style: BorderStyle.solid,
            ),
          ),
        ),
      )
    ],
  );
}
