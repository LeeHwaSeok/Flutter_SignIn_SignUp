import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firest_dongjun/common/component/custom_text_form_field.dart';
import 'package:firest_dongjun/common/const/colors.dart';
import 'package:firest_dongjun/common/const/data.dart';
import 'package:firest_dongjun/common/layout/default_layout.dart';
import 'package:firest_dongjun/common/view/root_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore_for_file: prefer_const_constructors

/*
* 모든 View는 Layout으로 한번 감싸주길 추천
*/
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    //디오 패키지 불러옴
    final dio = Dio();

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
                onChanged: (String value) {
                  username = value;
                },
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                hintText: '비밀번호를 입력해주세요',
                onChanged: (String value) {
                  password = value;
                },
                obscureText: true,
              ),
              ElevatedButton(
                  onPressed: () async {
                    // ID:비밀번호
                    final rawString = '$username:$password';
                    print('rawString === $rawString');

                    //base64로 인코딩 *외우기
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    // ID:비밀번호를 base64로 인코딩 후, token으로 반환
                    String token = stringToBase64.encode(rawString);
                    print('token === $token');

                    //실행 안됨
                    final resp = await dio.post('http://$ip/auth/login',
                        options: Options(
                          headers: {
                            'Authorization': 'Basic $token',
                          },
                        ));
                    print(resp.data);

                    final refreshToekn = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];

                    //flutter security storage에 데이터 key : value 형식으로 넣기
                    await storage.write(
                        key: REFRESH_TOKEN_KEY, value: refreshToekn);
                    await storage.write(
                        key: ACCESS_TOKEN_KEY, value: accessToken);

                    //flutter 코드에는 없는데 / Http status Error가 나오면 다음으로 진행이 안되고 return을 반환하는듯
                    //그래서 id/pass가 맞지않으면 Navigator..push로 넘어가진 않음.
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => RootTab(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: Text('로그인')),
              //회원 가입 진행 중
              TextButton(
                  onPressed: () async {

                  },
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
