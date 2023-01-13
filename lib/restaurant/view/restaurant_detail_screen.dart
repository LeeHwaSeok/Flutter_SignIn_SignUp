import 'package:dio/dio.dart';
import 'package:firest_dongjun/common/const/data.dart';
import 'package:firest_dongjun/common/layout/default_layout.dart';
import 'package:firest_dongjun/product/component/product_card.dart';
import 'package:firest_dongjun/restaurant/Component/restaurant_card.dart';
import 'package:firest_dongjun/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  // 레스토랑 아이디
  final String id;

  const RestaurantDetailScreen({required this.id, Key? key}) : super(key: key);

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp =
        await dio.get('http://$ip/restaurant/$id', options: Options(headers: {'authorization': 'Bearer $accessToken'}));

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: FutureBuilder<Map<String, dynamic>>(
            future: getRestaurantDetail(),
            builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // 스냅샷 데이터를 item으로 받아옴
              final item = RestaurantDetailModel.fromJson(snapshot.data!);

              return CustomScrollView(
                slivers: [
                  renderTop(
                    model: item,
                  ),
                  rednerLabel(),
                  renderProducts(
                    //팩토리로 생성된 데이터 출력
                    products: item.products,
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
