import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class ReuseButton {
  Widget buildTextWithIconWithMinState(onPressed, state) {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
            text: "Send",
            icon: Icon(Icons.send, color: Colors.white),
            color: ReColors().appMainColor),
        ButtonState.loading:
            IconedButton(text: "Loading", color: ReColors().appMainColor),
        ButtonState.fail: IconedButton(
            text: "Failed",
            icon: Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade300),
        ButtonState.success: IconedButton(
            icon: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Colors.green.shade400)
      },
      onPressed: onPressed,
      state: state,
      minWidthStates: [ButtonState.loading, ButtonState.success],
    );
  }
}
