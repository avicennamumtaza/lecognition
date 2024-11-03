class ApiUrls {
  static const baseUrl = "http://10.0.2.2:8000/api/";

  // Auth-related URLs
  static const login = "login";
  static const register = "register";

  // User-related URLs
  static const getUserById = "user/"; // You’ll append the user ID when calling
  static const getAllUsers = "user"; // This will be used for both POST (register) and GET all users

  // Scan-related URLs
  static const getScanById = "scan/"; // Append scan ID when calling
  static const getAllScans = "scan";

  // Disease-related URLs
  static const getDiseaseById = "disease/"; // Append disease ID when calling
  static const getAllDiseases = "disease";

  // Bookmark-related URLs
  static const getBookmarkById = "bookmark/"; // Append bookmark ID when calling
  static const getAllBookmarks = "bookmark";
}