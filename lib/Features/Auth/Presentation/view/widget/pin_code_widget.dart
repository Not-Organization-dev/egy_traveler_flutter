import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({
    super.key,
    required this.otpController,
  });

  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4, // Change the length as needed
      onChanged: (value) {
        // Handle OTP input
        // print(value);
      },
      cursorColor: Theme.of(context).iconTheme.color,
      cursorWidth: 1,
      controller: otpController,

      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 56,
        fieldWidth: 56,
        activeFillColor: Colors.white,
        inactiveColor: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
