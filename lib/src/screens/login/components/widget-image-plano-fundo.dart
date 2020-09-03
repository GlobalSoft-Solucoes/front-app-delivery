import 'package:flutter/material.dart';

class ImagePlanoFundo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height / 2.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            90,
          ),
        ),
        image: DecorationImage(
          image: AssetImage(
            'assets/Logo.png',
          ),
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30, bottom: 10),
            // child: Text(
            //   'Login',
            //   style: TextStyle(
            //     color: Colors.green,
            //     fontSize: 30,
            //     fontStyle: FontStyle.italic,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
