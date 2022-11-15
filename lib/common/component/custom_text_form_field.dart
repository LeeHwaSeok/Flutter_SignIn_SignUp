import 'package:firest_dongjun/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofoucs;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField(
      {
      //required를 사용하면 공백허용 x
      required this.onChanged,
      this.hintText,
      this.errorText,
      this.obscureText = false,
      this.autofoucs = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      //비밀번호 입력할 때,
      obscureText: obscureText,
      autofocus: autofoucs,
      //값이 바뀔때마다 callback
      onChanged: onChanged,
      decoration: InputDecoration(
        //text field 패딩 줄 때,
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
        fillColor: INPUT_BG_COLOR,
        filled: true,
        //모든 Input 상태의 기본 스타일 세팅
        border: baseBorder,
        enabledBorder: baseBorder,
        //copyWith 모든 특성 그대로 유지 + 변경할 것 넣으면 됨
        focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(color: PRIMARY_COLOR)),
      ),
    );
  }
}
