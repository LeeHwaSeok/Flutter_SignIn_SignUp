import 'package:firest_dongjun/common/utils/data_utils.dart';
import 'package:firest_dongjun/restaurant/model/rastaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_detail_model.g.dart';

/**
 * 01/12 오늘의 핵심인데 만약 중복되는 Response를 포함한 데이터가 있다면 API를 어떻게 구상할것인가?
 * 구서에 따라 중복되는 코드를 구현 => 수정 삭제에 어려움을 겪을 수 있는데,
 * 이 해답은 놀랍게도 상속으로 해결할 수 있습니다.
 * //중복된 클래스를 사용할때는 extends로 상속받아오면 개이득
    자신꺼 : this.
    부모꺼 : super. 로 변경
 * Swagger를 통해 중복된 결과를 받아온다는 것을 알았을 때 사용하면 좋습니다.*/
@JsonSerializable()
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

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) => _$RestaurantDetailModelFromJson(json);
}

// json 속 리스트는 이런식으로 하나하나 type을 지정해서 사용할 수도 있습니다.
// 01/13 상위 class에서 선언된 클래스도 Json화 시켜줘야함
@JsonSerializable()
class RestaurantProductModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: Datautils.pathToUrl,
  )
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

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) => _$RestaurantProductModelFromJson(json);
}
