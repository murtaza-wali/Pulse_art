import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';

class ReuseButton extends StatelessWidget {
  //declare Required Vairables
  final String buttonText;
  final VoidCallback onPressed;


  //constructor
  ReuseButton({this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
      height: 50.0,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ReColors().appTextWhiteColor,
                  ReColors().appTextWhiteColor
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 0.05 * deviceWidth),
            constraints: BoxConstraints(maxWidth: deviceWidth, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(color: ReColors().appMainColor, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}

class ReuseTwoButton extends StatelessWidget {
  //declare Required Vairables
  final String firstbuttonText;
  final String secondbuttonText;
  final VoidCallback firstonPressed;
  final VoidCallback secondonPressed;

  //constructor
  ReuseTwoButton(
      {this.firstbuttonText,
      this.secondbuttonText,
      this.firstonPressed,
      this.secondonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 50.0,
          margin: EdgeInsets.all(10),
          child: RaisedButton(
            onPressed: firstonPressed,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ReColors().appTextBlackColor,
                      ReColors().appMainColor
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                constraints: BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: Text(
                  firstbuttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 0.0,
        ),
        Container(
          height: 50.0,
          margin: EdgeInsets.all(10),

          child: RaisedButton(
            onPressed: secondonPressed,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ReColors().appTextBlackColor,
                      ReColors().appMainColor
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                constraints: BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: Text(
                  secondbuttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
