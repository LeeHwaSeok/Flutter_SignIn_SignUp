import 'package:firest_dongjun/common/const/data.dart';
import 'package:firest_dongjun/restaurant/model/rastaurant_model.dart';

/**
 * 01/12 오늘의 핵심인데 만약 중복되는 Response를 포함한 데이터가 있다면 API를 어떻게 구상할것인가?
 * 구서에 따라 중복되는 코드를 구현 => 수정 삭제에 어려움을 겪을 수 있는데,
 * 이 해답은 놀랍게도 상속으로 해결할 수 있습니다.
 * //중복된 클래스를 사용할때는 extends로 상속받아오면 개이득
    자신꺼 : this.
    부모꺼 : super. 로 변경
 * Swagger를 통해 중복된 결과를 받아온다는 것을 알았을 때 사용하면 좋습니다.*/
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  //클래스의 인스턴스를 배열로 받아옴
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.deliveryFee,
    required super.deliveryTime,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.tags,
    required super.thumbUrl,
    required this.detail,
    required this.products,
  });

  /**
   * 팩토리 함수는 클래스의 인스턴스를 만들때, 반환값을 다르게 만들 수 있다.
   * 팩토리를 생성할때는 해당 클래스.팩토리명 형식으로 생성하면 되고, 반환값을 아래와같이 지정해서 출력할 수 있다.*/
  factory RestaurantDetailModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantDetailModel(
        id: json['id'],
        name: json['name'],
        deliveryFee: json['deliveryFee'],
        deliveryTime: json['deliveryTime'],
        priceRange: RestaurantPriceRange.values.firstWhere((element) => element.name == json['priceRange']),
        ratings: json['ratings'],
        ratingsCount: json['ratingsCount'],
        tags: List<String>.from(json['tags']),
        thumbUrl: 'http://${ip}${json['thumbUrl']}',
        detail: json['detail'],
        /** 01/12
         * products는 api에서 받아온 리스트형식인데 아래와같이 [[ .map<상속함수> ((x) => 상속함수().toList()); ]]로 정리를 해주지 않으면
         * App_Build 할 때, products의 구조를 <dynamic, dynamic>으로 결정하기 때문에, 아래와 같이 정리해주는게 좋습니다.*/
        products: json['products']
            .map<RestaurantProductModel>(
              (x) => RestaurantProductModel.fromJson(
                json: x,
              ),
            )
            .toList());
  }
}

// json 속 리스트는 이런식으로 하나하나 type을 지정해서 사용할 수도 있습니다.
class RestaurantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory RestaurantProductModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantProductModel(
        id: json['id'],
        name: json['name'],
        imgUrl: 'http://$ip${json['imgUrl']}',
        detail: json['detail'],
        price: json['price']);
  }
}
