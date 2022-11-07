import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ChangeListeners/ColorList.dart';
import '../ChangeListeners/CurrentValue.dart';
import '../Global.dart';
import '../ChangeListeners/Points.dart';

class BoxRow extends StatelessWidget {
  int rowNum;
  BoxRow(this.rowNum, {super.key});

  bool isCorrectValue(int indexToCheck, BuildContext context) {
    int currNum = Provider.of<CurrentValue>(context, listen: false).currValue;
    int currRow = Provider.of<CurrentValue>(context, listen: false).currRow;

    return (currNum == indexToCheck && currRow == rowNum);
  }

  tapABox(int indexInRow, BuildContext context) {
    if (isCorrectValue(indexInRow, context)) {
      Provider.of<Points>(context, listen: false).increment();
      Provider.of<CurrentValue>(context, listen: false).pickNewValue();

      // Every Multiple of 10 (except 10 so the user can experience the new
      //color changing feature)
      int numPoints = Provider.of<Points>(context, listen: false).value;
      if (numPoints % 10 == 0 && numPoints != 10) {
        Provider.of<CurrentValue>(context, listen: false).incrementNumRows();
      }

      // Every Multiple of 20, the number in the rows increases by 1
      if (numPoints % 20 == 0) {
        Provider.of<CurrentValue>(context, listen: false).incrementSize();
      }

      // At 25 and 50 change the color scheme
      if (Provider.of<Points>(context, listen: false).value == 25) {
        Provider.of<ColorList>(context, listen: false)
            .setNewColorList(Global.colorListMedium);
      } else if (Provider.of<Points>(context, listen: false).value == 50) {
        Provider.of<ColorList>(context, listen: false)
            .setNewColorList(Global.colorListHard);
      }

      // Also worth noting that at 75, the names change
    }
  }

  Color getStableColor(BuildContext context, int index) {
    List<Color> currColorList = Provider.of<ColorList>(context).currColorList;
    int stableIndex = index % currColorList.length;
    return currColorList[stableIndex];
  }

  Color getRandomColor(BuildContext context) {
    List<Color> currColorList = Provider.of<ColorList>(context).currColorList;
    int randIndex = Random().nextInt(currColorList.length);
    return currColorList[randIndex];
  }

  String getRandColorName() {
    int randIndex = Random().nextInt(Global.colorNames.length);
    return Global.colorNames[randIndex];
  }

  @override
  Widget build(BuildContext context) {
    int currValue = Provider.of<CurrentValue>(context, listen: false).currValue;
    int currRow = Provider.of<CurrentValue>(context, listen: false).currRow;
    return SizedBox(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          Provider.of<CurrentValue>(context).size,
          (int indexInRow) {
            return GestureDetector(
              onTap: () => tapABox(indexInRow, context),
              child: Card(
                color: (isCorrectValue(indexInRow, context))
                    ? Colors.red[500]
                    : (Provider.of<Points>(context, listen: false).value <= 10)
                        ? getStableColor(context, indexInRow)
                        : getRandomColor(context),
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: Consumer<CurrentValue>(
                    builder: (context, currValue, child) {
                      int numPoints =
                          Provider.of<Points>(context, listen: false).value;
                      if (numPoints <= 75) {
                        return Text('Row${indexInRow}');
                      } else {
                        return Text(getRandColorName());
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
