import 'package:flutter/material.dart';

const appName = 'AI Assistant';
const appLogo = 'assets/images/AI_LOGO.png';

// const apiKey = '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';

//New ChatGPT Api Key
const apiKey = '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';
// const bgRemoverApiKey = "EtqVVQrwY1Z5UQ5phtYhfokB";

//Priyasnhsu BG API KEY
const bgRemoverApiKey = "tfTsbYpXfYLh2QHeTbXLt2d2";

late Size mq;

//Custom Button For Image Picking...
Widget customButton(VoidCallback onTap, IconData icon, String label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Semantics(
        button: true,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 26,
              backgroundColor: Colors.blue,
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

// Widget appLogo(double width, double height) {
//   return Image.asset(
//     'assets/images/AI_LOGO.png',
//     width: width,
//     height: height,
//   );
// }
