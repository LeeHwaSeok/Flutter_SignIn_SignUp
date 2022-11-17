import 'package:firest_dongjun/common/const/colors.dart';
import 'package:firest_dongjun/common/const/data.dart';
import 'package:firest_dongjun/common/layout/default_layout.dart';
import 'package:firest_dongjun/common/view/root_tab.dart';
import 'package:firest_dongjun/user/view/login_screen.dart';
import 'package:flutter/material.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();

    // DeleteToken();
    CheckToken();

    //여기선 await 불가능
  }

  void DeleteToken() async {
    // 저장소 초기화
    await storage.deleteAll();
  }

  /*
   * CheckToken으로 현재 로그인이 되었는지 안되었는지 확인하느 ㄴ기능
   * */
  void CheckToken() async {
    // write로 저장했던 데이터를 불러옵니다.
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    // 데이터가 둘다 비어있다면 ? Login : Root으로
    if (refreshToken == null || accessToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => RootTab()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(
                height: 16.0,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
