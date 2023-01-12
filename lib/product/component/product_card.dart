import 'package:firest_dongjun/common/const/colors.dart';
import 'package:firest_dongjun/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard({required this.image, required this.detail, required this.price, required this.name, Key? key})
      : super(key: key);

  factory ProductCard.fromModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    //IntrinsicHeight는 구성요소 중에 최대 크기에 맞춰서 각 구간의 크기를 맞춰줌
    return IntrinsicHeight(
      child: Row(
        children: [
          //이미지
          ClipRRect(borderRadius: BorderRadius.circular(8.0), child: image),

          const SizedBox(width: 16.0),

          //설명
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //구간을 동일하게 맞춤
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              Text(detail, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.0, color: BODY_TEXT_COLOR)),
              Text(
                '￦${price}',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: PRIMARY_COLOR),
              )
            ],
          ))
        ],
      ),
    );
  }
}
