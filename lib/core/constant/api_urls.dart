import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiUrls {
  static const myComputerIpAddress = "192.168.245.61";
  static final baseUrl = kIsWeb
      ? "http://localhost:8000/api"
      : Platform.isAndroid
          ? "http://10.0.2.2:8000/api/"
          : Platform.isIOS
              ? "http://127.0.0.1:8000/api"
              : "http://$myComputerIpAddress:8000/api";
  static final baseUrlWithoutApi = kIsWeb
      ? "http://localhost:8000"
      : Platform.isAndroid
          ? "http://10.0.2.2:8000/"
          : Platform.isIOS
              ? "http://127.0.0.1:8000"
              : "http://$myComputerIpAddress:8000";

  // static final baseUrlWithoutApi = "http://192.168.245.61:8000/";
  // static final baseUrl = "http://192.168.245.61:8000/api/";

  // Auth-related URLs
  static const login = "login";
  static const register = "register";
  static const refreshToken = "token/refresh/";

  // User-related URLs
  static const getUserById = "user";
  static const getAllUsers =
      "user/all"; // This will be used for both POST (register) and GET all users

  // Scan-related URLs
  static const scan = "scan";
  static const scanByUser = "scan/user";

  // Disease-related URLs
  static const getAllDiseases = "disease";

  // Bookmark-related URLs
  static const bookmarking = "bookmark";
  static const bookmarkByUser = "bookmark/user";

  // Tree-related URLs
  static const tree = "tree";
  static const scanByTree = "scan/tree";

  // Media-related URLs
  // static const media = "";
}
