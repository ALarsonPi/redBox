import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:providerexample/Widgets/IntroElement.dart';

class InstructionsWidget extends StatefulWidget {
  InstructionsWidget(this.startCountdownInParent, {super.key});
  Function startCountdownInParent;

  @override
  State<StatefulWidget> createState() {
    return _InstructionsWidget();
  }
}

class _InstructionsWidget extends State<InstructionsWidget> {
  CarouselController buttonCarouselController = CarouselController();

  next() {
    if (currIndex == numElements) {
      return null;
    } else {
      setState(() {
        currIndex++;
      });
      buttonCarouselController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  previous() {
    if (currIndex == 0) {
      return null;
    } else {
      setState(() {
        currIndex++;
      });
      buttonCarouselController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  int currIndex = 0;
  int numElements = 4;

  @override
  Widget build(BuildContext context) {
    List<String> imageAddresses = List.empty(growable: true);
    List<String> topText = List.empty(growable: true);
    List<String> bottomText = List.empty(growable: true);

    // Book Icon
    imageAddresses.add("https://cdn-icons-png.flaticon.com/512/831/831700.png");
    topText.add("Instructions");
    bottomText.add("Tap or slide to see more, or press start to begin");

    // Red search
    imageAddresses.add("https://cdn-icons-png.flaticon.com/512/174/174315.png");
    topText.add("Goal");
    bottomText.add("Find the RED box");

    // Tap Icon
    imageAddresses.add("https://cdn-icons-png.flaticon.com/512/119/119953.png");
    topText.add("Points");
    bottomText.add("Tap the RED box to get points");

    // Trophy Icon
    imageAddresses
        .add("https://cdn-icons-png.flaticon.com/512/5721/5721278.png");
    topText.add("Get the highest score you can to win!");
    bottomText.add("Press start to begin!");

    List<IntroElement> element = List.empty(growable: true);
    for (int i = 0; i < imageAddresses.length; i++) {
      element.add(IntroElement(topText.elementAt(i),
          imageAddresses.elementAt(i), bottomText.elementAt(i)));
    }

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: ElevatedButton(
            onPressed: () => widget.startCountdownInParent(context),
            child: const Text('Start'),
          ),
        ),
        CarouselSlider(
          items: element,
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.65,
            onPageChanged: (index, reason) {
              setState(() {
                currIndex = index;
              });
            },
            autoPlay: false,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            viewportFraction: 0.9,
            aspectRatio: 2.0,
            initialPage: currIndex,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.05),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: ElevatedButton(
                    onPressed: (currIndex == 0) ? null : () => previous(),
                    child: const Text(
                      '←',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: ElevatedButton(
                  onPressed:
                      (currIndex == (numElements - 1)) ? null : () => next(),
                  child: const Text(
                    '→',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
