// 상수값을 자료형의로 정리 = enum
import 'package:firest_dongjun/common/const/data.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

// get으로 받은 데이터를 모델링하기 위해 선언
class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.tags,
    required this.thumbUrl,
  });

  //fromJson이라는 이름으로 construct를 만들어준거임
  factory RestaurantModel.fromJson({
    //Map<String, dynamic>은  문자열 키를  동적  값과 매핑합니다. 키 는 항상 문자열 이고 값 은 모든 유형 이 될 수 있으므로 동적 으로 유지되어 더 안전합니다.
    required Map<String, dynamic> json,
  }) {
    return RestaurantModel(
        id: json['id'],
        name: json['name'],
        deliveryFee: json['deliveryFee'],
        deliveryTime: json['deliveryTime'],
        // .firstWhere(e) => e.name == json[]
        // firstWhere는 요소를 반복하고 조건에 맞는 요소 반환
        priceRange: RestaurantPriceRange.values.firstWhere((element) => element.name == json['priceRange']),
        ratings: json['ratings'],
        ratingsCount: json['ratingsCount'],
        tags: List<String>.from(json['tags']),
        thumbUrl: 'http://${ip}${json['thumbUrl']}');
  }
}
