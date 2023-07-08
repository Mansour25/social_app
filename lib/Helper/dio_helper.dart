// import 'package:dio/dio.dart';
//
// class DioHelper {
//   static Dio? dio;
//
//   static void init() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: 'https://student.valuxapps.com/api/',
//         receiveDataWhenStatusError: true,
//         // لانه سيتم اضافته في الاسفل
//         // headers: {'Content-Type': 'application/json'},
//       ),
//     );
//   }
//
//   static Future<Response> postDate({
//     required String url,
//     required Map<String, dynamic> query,
//     required Map<String, dynamic> data,
//     String lang = 'ar',
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': token ?? '',
//     };
//
//     return await dio!.post(
//       url,
//       queryParameters: query,
//       data: data,
//     );
//   }
//
//   static Future<Response> getData({
//     required String url,
//     Map<String, dynamic>? query,
//     String? token,
//     String lang = 'ar',
//   }) async {
//     dio!.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': token ?? '',
//     };
//
//     return await dio!.get(
//       url,
//       queryParameters: query,
//     );
//   }
// }
