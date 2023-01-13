import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

/**
 * 01/13 generic을 사용하려면 아래와 같이 true로 변경해주고
 * <Type>로 받아오면된다.
 * Type을 받아오는 이유는 APi 통신에서 받아오는 데이터가 어떤 유형인지 모르기 때문에 받아오는 데이터를 기준으로 Type을 생성한다고 보면 된다.
 * 중요한건 factory에서 T Function(Object? json) fromJsonT 라고 선언을 해주어야 받아오는 타입으로 인스턴스를 정의할 수 있다.*/
@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({required this.meta, required this.data});
  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

//meta
@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) => _$CursorPaginationMetaFromJson(json);
}
