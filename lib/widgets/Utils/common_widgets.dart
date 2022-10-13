import 'package:flutter/material.dart';
import 'package:ocyclient/widgets/Utils/snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget getIconButton(
    {required String title, required Function func, required IconData icon}) {
  return GestureDetector(
    onTap: () {
      func();
    },
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: getIconButtonBody(
        title,
        icon,
      ),
    ),
  );
}

Widget getIconButtonBody(String title, IconData icon) {
  return Row(
    children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: 30,
          height: 30,
          child: getIconForButton(icon),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      getTextForButton(title)
    ],
  );
}

Widget getTextForButton(String label, {Color? color}) {
  return Text(
    label,
    style: TextStyle(
      color: color ?? Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 19,
      fontFamily: "PublicSans",
    ),
  );
}

Widget getIconForButton(IconData icon) {
  return Icon(
    icon,
    color: const Color(0xff0f254e),
    size: 15,
  );
}


Widget getFooterSocialButton(IconData icon, {String? link}) {
  return GestureDetector(
    onTap: () {
      if (link == null) {
        showToast("Coming soon");
      } else {
        launchUrlString(link);
      }
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 30,
        height: 30,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: getIconForButton(icon),
        ),
      ),
    ),
  );
}
