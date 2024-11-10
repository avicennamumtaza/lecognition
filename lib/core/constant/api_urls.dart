import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiUrls {
  // if (kIsWeb) {
  //   return 'http://localhost:8000'; // URL untuk Web
  // } else if (Platform.isAndroid) {
  //   return 'http://10.0.2.2:8000'; // URL untuk Emulator Android
  // } else if (Platform.isIOS) {
  //   return 'http://127.0.0.1:8000'; // URL untuk Emulator iOS
  // } else {
  //   return 'http://192.168.x.x:8000'; // Ganti dengan IP komputer untuk perangkat fisik
  // }

  static const myComputerIpAddress = "192.168.x.x";
  static final baseUrl = kIsWeb
      ? "http://localhost:8000/api"
      : Platform.isAndroid
          ? "http://10.0.2.2:8000/api/"
          : Platform.isIOS
              ? "http://127.0.0.1:8000/api"
              : "http://$myComputerIpAddress:8000/api";

  // Auth-related URLs
  static const login = "login";
  static const register = "register";
  static const refreshToken = "token/refresh/";

  // User-related URLs
  static const getUserById = "user"; 
  static const getAllUsers =
      "user/all"; // This will be used for both POST (register) and GET all users

  // Scan-related URLs
  static const getAllScans = "scan";

  // Disease-related URLs
  static const getAllDiseases = "disease";

  // Bookmark-related URLs
  static const bookmarking = "bookmark";
  static const bookmarkByUser = "bookmark/user";
}
