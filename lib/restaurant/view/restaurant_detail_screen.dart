import 'package:dio/dio.dart';
import 'package:firest_dongjun/common/const/data.dart';
import 'package:firest_dongjun/common/dio/dio.dart';
import 'package:firest_dongjun/common/layout/default_layout.dart';
import 'package:firest_dongjun/product/component/product_card.dart';
import 'package:firest_dongjun/restaurant/Component/restaurant_card.dart';
import 'package:firest_dongjun/restaurant/model/restaurant_detail_model.dart';
import 'package:firest_dongjun/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  // 레스토랑 아이디
  final String id;

  const RestaurantDetailScreen({required this.id, Key? key}) : super(key: key);

  //01/13 Future의 <형태>를 바꾼건 받아오는 데이터중에 레포지토리 데이터의 형태에 따라서 변환해줘야하는데
  // 현재 레포지토리는 추상화 클래스라서 .g.dart의 클래스 유형을 따라서 변경해줘야함 /builder, snapshot 에서도 변경해줘야함
  Future<RestaurantDetailModel> getRestaurantDetail() async {
    final dio = Dio();

    dio.interceptors.add(
      CustomInterceptor(
        storage: storage,
      ),
    );

    //01/13 retrofit으로 통신
    final repository = RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

    return repository.getRestaurantDetail(id: id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: FutureBuilder<RestaurantDetailModel>(
            future: getRestaurantDetail(),
            builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CustomScrollView(
                slivers: [
                  renderTop(
                    model: snapshot.data!,
                  ),
                  rednerLabel(),
                  renderProducts(
                    //팩토리로 생성된 데이터 출력
                    products: snapshot.data!.products,
                  ),
                ],
              );
            }));
  }

  SliverPadding rednerLabel() {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  renderProducts({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          final model = products[index];
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ProductCard.fromModel(model: model),
          );
        },
        childCount: products.length,
      )),
    );
  }

  SliverToBoxAdapter renderTop({required RestaurantDetailModel model}) {
    return SliverToBoxAdapter(child: RestaurantCard.fromModel(model: model, isDetail: true));
  }
}
