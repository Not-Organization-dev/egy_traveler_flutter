import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomButtonOtpCode extends StatelessWidget {
  const CustomButtonOtpCode({required this.otpController, super.key});

  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 28,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.black.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: TextFormField(
          controller: otpController,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value!.isEmpty) {
              return '';
            }
            return null;
          },
          textAlign: TextAlign.center,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                width: 0,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Colors.transparent,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                width: 0,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}