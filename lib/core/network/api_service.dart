import 'package:dio/dio.dart';
import 'package:state_management_test/feature/home/model/todo.dart';
import 'package:retrofit/retrofit.dart';
import 'api_constants.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService
{
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  @GET(ApiConstants.getTodo)
  Future<Todo> fetchTodo();
}


