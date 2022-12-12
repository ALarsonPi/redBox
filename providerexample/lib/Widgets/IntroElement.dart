import 'package:flutter/material.dart';

class IntroElement extends StatelessWidget {
  IntroElement(this.topText, this.imageAssetAddress, this.bottomText,
      {super.key});

  String topText;
  String imageAssetAddress;
  String bottomText;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleHeader = const TextStyle(fontSize: 28);
    TextStyle textStyle = const TextStyle(fontSize: 20);
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Text(
          topText,
          textAlign: TextAlign.center,
          style: textStyleHeader,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Image.network(imageAssetAddress),
        ),
        Text(
          bottomText,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ],
    );

    // Expanded(
    //   child: ListView(
    //     // mainAxisAlignment: MainAxisAlignment.start,
    //     shrinkWrap: true,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(
    //           top: 8.0,
    //           bottom: 16.0,
    //         ),
    //         child: Text(topText),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(
    //           top: 8.0,
    //           bottom: 16.0,
    //         ),
    //         child: FittedBox(
    //           fit: BoxFit.fill,
    //           // height: 225,
    //           child: Image.asset(
    //               "https://icon-library.com/images/high-score-icon/high-score-icon-24.jpg"),
    //         ),
    //       ),
    //       Text(bottomText),
    //     ],
    //   ),
    // );
  }
}
