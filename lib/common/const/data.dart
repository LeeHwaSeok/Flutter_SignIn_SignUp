import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

//에뮬레이터는 네트워크가 다르다 '10.0.2.2' == local host 127.0.0.1
final emulatorIp = '10.0.2.2:3000';
// final simulatorIp = '127.0.0.1:3000';
// 실사 기기의 Ip는 wifi를 공유해서 Mac을 통해 주소를 확인 후, 변경해줘야한다.
final simulatorIp = '192.168.0.77:3000';

// runtime에 디바이스를 체크하게 해준다. Platform
final ip = Platform.isIOS ? simulatorIp : emulatorIp;

final storage = FlutterSecureStorage();
