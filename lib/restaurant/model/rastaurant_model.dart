// 상수값을 자료형의로 정리 = enum
import 'package:firest_dongjun/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

// 파트이름은 파일명과 동일해야합니다. 함수와는 상관없는듯
part 'rastaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

// get으로 받은 데이터를 모델링하기 위해 선언
@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  /** 01/13 .g로 생성된 파일은 빌드할 때마다 새로 생성되서 .g를 수정하는 건 의미가 없다
   * 대신 JsonKey를 이용해서 특정 인스턴스를 변환시킬 수 있다
   * pathTourl에 매개변수를 지정하지 않아도 된다, 어노테이션(Annotation) 바로 아래 함수 or 변수에 직접 꽂히기 때문
   * ,,, tmi python에서는 데코레이터(Decorator)라고 부름*/
  @JsonKey(
    fromJson: Datautils.pathToUrl,
  )
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

  // 01/13 JsonSerializable을 사용해서 팩토리 생성하기
  factory RestaurantModel.fromJson(Map<String, dynamic> json) => _$RestaurantModelFromJson(json);

  // <dynamic, dynamic>을 => <String, dynamic>으로 자동변환해주기
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  /** 01/13 JsonSerializable을 사용하기위해서 주석처리
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
  }*/
}
