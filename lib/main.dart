import 'package:firest_dongjun/common/component/custom_text_form_field.dart';
import 'package:firest_dongjun/user/view/login_screen.dart';
import 'package:flutter/material.dart';
/* 
* runApp에 _App으로 함수를 실행 할 때, 반환 값은 MaterialApp으로 해줘야한다.
* 이유는 Goroute를 사용할 때 BuildContext context를 사용해야할 수 있기 때문
*
* 중요하게 배워야할 것
* 1. 로그인이 어떻게 구성이 되는지
* Access token과 refresh token을 발급받아 사용 / 대부분 이렇게 사용
* */
void main() {
  runApp(
    _App(),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home : LoginScreen(),

    );
  }
}
