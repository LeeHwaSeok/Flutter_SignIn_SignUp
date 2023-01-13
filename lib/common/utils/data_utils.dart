import 'package:firest_dongjun/common/const/data.dart';

class Datautils {
  // .g파일에 정의된 변수를 변경하려고 하는데 무조건 static으로 선언해야합니다. /static이 아니면 변경되지 않음
  static pathToUrl(String value) {
    return 'http://${ip}${value}';
  }
}
