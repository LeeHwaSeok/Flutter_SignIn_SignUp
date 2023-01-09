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

    print('resp.mate ${resp.data['meta']}');

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
              builder: (context, AsyncSnapshot<List> snapshot) {
                //401 error가 나온다 이럴땐, ACCESS_TOKEN_KEY 값의 유효기간이 지낫기 때문에 null 값을 뱉는다
                print('snapshot data = ${snapshot.data}');
                print('snapshot error = ${snapshot.error}');

                if (!snapshot.hasData) {
                  return Container();
                }

                //데이터를 feed형식으로 들고올때 사용하는 방법 .separated를 사용하면 세퍼레이터 속성 사용가능
                return ListView.separated(
                    itemBuilder: (_, index) {
                      // index에 맞춰서 스냅샷 데이터 저장
                      final item = snapshot.data![index];

                      // fatory construct를 활용해서 선언부에서 데이터 파싱을 모두 끝낼 수 있다.
                      final pItem = RestaurantModel.fromJson(
                        json: item,
                      );
                      // 로직을 모두 construct안에 집어넣어서 코드가 간결해질 수 있었음
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => RestaurantDetailScreen()));
                          },
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
