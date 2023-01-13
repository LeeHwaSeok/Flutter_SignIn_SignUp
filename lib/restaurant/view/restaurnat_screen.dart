import 'package:dio/dio.dart';
import 'package:firest_dongjun/common/const/data.dart';
import 'package:firest_dongjun/restaurant/Component/restaurant_card.dart';
import 'package:firest_dongjun/restaurant/model/rastaurant_model.dart';
import 'package:firest_dongjun/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestaurnt() async {
    final dio = Dio();

    // .read함수로 데이터를 받아온다
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get('http://$ip/restaurant',
        options: Options(headers: {
          'authorization': 'Bearer $accessToken',
        }));

    // print('resp.mate ${resp.data['meta']}');

    // key[data]이하 데이터만 받아올것
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List>(
              future: paginateRestaurnt(),
              /**
               * AsyncSnapshot<List>로 선언한경우는 결과 값이 List 타입이라는 것을 명시하는 것입니다
               * 그냥 snapshot으로 선언할 수도 있지만, 이 경우에는 타입이 명시되지 않아 타입 정보를 얻기가 힘듭니다.*/
              builder: (context, AsyncSnapshot<List> snapshot) {
                //401 error가 나온다 이럴땐, ACCESS_TOKEN_KEY 값의 유효기간이 지낫기 때문에 null 값을 뱉는다
                print('snapshot data = ${snapshot.data}');
                print('snapshot error = ${snapshot.error}');

                /**
                 * 01/12 FutureBuilder 개념정리
                 * Futuer에 속하는 함수는 future로 선언된 함수만 사용가능하며
                 * builder를 통해 사용가능한데 snapshot은 future함수를 통해 리턴된 값을 의미한다*/
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                //데이터를 feed형식으로 들고올때 사용하는 방법 .separated를 사용하면 세퍼레이터 속성 사용가능
                return ListView.separated(
                    itemBuilder: (_, index) {
                      // index에 맞춰서 스냅샷 데이터 저장
                      final item = snapshot.data![index];

                      // fatory construct를 활용해서 선언부에서 데이터 파싱을 모두 끝낼 수 있다.
                      final pItem = RestaurantModel.fromJson(
                        item,
                      );
                      // 카드 선택시 상세페이지 전환
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) => RestaurantDetailScreen(id: pItem.id)));
                          },
                          // 위젯은 Card return 이하에 구현되어있음
                          child: RestaurantCard.fromModel(model: pItem));
                    },
                    separatorBuilder: (_, index) {
                      return SizedBox(height: 16.0);
                    },
                    itemCount: snapshot.data!.length);
              },
            )),
      ),
    );
  }
}
