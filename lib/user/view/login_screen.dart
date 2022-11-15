import 'package:firest_dongjun/common/component/custom_text_form_field.dart';
import 'package:firest_dongjun/common/const/colors.dart';
import 'package:firest_dongjun/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

/*
* 모든 View는 Layout으로 한번 감싸주길 추천
*/
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        //화면을 스크롤할 수 있게 만들어버림
        child: SingleChildScrollView(
      //drag하면 지워짐
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Title(),
              const SizedBox(height: 16.0),
              _SubTitle(),
              Image.asset(
                'asset/img/misc/logo.png',
                width: MediaQuery.of(context).size.width / 3 * 2,
              ),
              CustomTextFormField(
                hintText: '이메일을 입력해주세요',
                onChanged: (String value) {},
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                hintText: '비밀번호를 입력해주세요',
                onChanged: (String value) {},
                obscureText: true,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: Text('로그인')),
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: Text('회원가입'))
            ],
          ),
        ),
      ),
    ));
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요! \n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
