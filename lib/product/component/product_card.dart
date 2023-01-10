import 'package:firest_dongjun/common/const/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //IntrinsicHeight는 구성요소 중에 최대 크기에 맞춰서 각 구간의 크기를 맞춰줌
    return IntrinsicHeight(
      child: Row(children: [
        //이미지
        ClipRRect(borderRadius: BorderRadius.circular(8.0),
        child: Image.asset('asset/img/food/ddeok_bok_gi.jpg',
          width: 110,height: 110,fit: BoxFit.cover,),),

        const SizedBox(width: 16.0),

        //설명
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //구간을 동일하게 맞춤
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('떡볶이',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
            Text('전통 떡볶이의 정석 ! \n맛있습니다.',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.0, color: BODY_TEXT_COLOR)),
            Text('￦10,000',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: PRIMARY_COLOR),)

          ],
        ))
        

      ],),
    );
  }
}
