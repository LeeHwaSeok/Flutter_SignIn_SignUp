import 'package:firest_dongjun/common/const/colors.dart';
import 'package:firest_dongjun/common/layout/default_layout.dart';
import 'package:firest_dongjun/restaurant/view/restaurnat_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  //나중에 데이터를 할당할 것을 약속합니다
  // null을 사용하면 삼황연산을 사용해야해서 귀찮음
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    /*
     *
        1. 생성된 위젯 인스턴스의 BuildContext에 의존적인 것들의 데이터 초기화
        2. 동일 위젯트리내에 부모위젯에 의존하는 속성 초기화
        3. Stream 구독, 알림변경, 또는 위젯의 데이터를 변경할 수 있는 다른 객체 핸들링.
     */
    super.initState();

    //vsync은 현재 위치가 어딘지 물어보는 함수인데,
    // 이걸 사용하려면 with SingleTicker...Mixin이 필요하다
    controller = TabController(length: 4, vsync: this);
    //addListener => 값이 변경될 때마다 특정 변수를 실행해라
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    //addListner이 사용되면 이제 removeListner로 지워라
    controller.removeListener(tabListener);

    //dispost()는 State객체가 영구히 제거 된다.
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '동준 딜리버리',
      child: TabBarView(
        //좌우 스크롤 기능을 막아버림
        physics: NeverScrollableScrollPhysics(),
        //init안에서 TabController vsync :this 값을 받아서 현재 인덱스를 반환하고 있음
        controller: controller,
        children: [
          RestaurantScreen(),
          Center(
            child: Container(
              child: Text('음식'),
            ),
          ),
          Center(
            child: Container(
              child: Text('주문'),
            ),
          ),
          Center(
            child: Container(
              child: Text('프로필'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        selectedFontSize: 10,
        unselectedItemColor: BODY_TEXT_COLOR,
        unselectedFontSize: 10,
        //shifting 선택된 탭이 조금 크게 표현
        type: BottomNavigationBarType.shifting,

        onTap: (int index) {
          //tab 변경하려면 setState안에 데이터 넣어야함
          // setState(() {
          //   this.index = index;
          // });

          controller.animateTo(index);
        },
        //현재 선택된 Tab
        currentIndex: index,

        //icon 정보
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined), label: '음식'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: '주문'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined), label: '프로필'),
        ],
      ),
    );
  }
}
