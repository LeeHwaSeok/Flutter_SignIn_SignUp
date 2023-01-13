import 'package:dio/dio.dart' hide Headers;
import 'package:firest_dongjun/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

/** 01/13 retrofit
 * RestApi 어노테이션을 통해서 .g.dart 파일을 생성할 수 있습니다.
 * RestApi는 retrofit의 지원하는 기능 중 하나*/
@RestApi()
abstract class RestaurantRepository {
  /** 추상 클래스는 기본적으로 인스턴스화를 진행할 수 없습니다.
   * 그래서 factory 함수를 이용하여
   * */
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) = _RestaurantRepository;

  // http://$ip/restaurant/
  // @GET('/')
  // paginate();

  // http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
