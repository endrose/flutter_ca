import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileRemoteDataSourceImplementation extends ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImplementation({
    required this.client,
  });

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    Uri url = Uri.parse("https://reqres.in/api/users?page=$page");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);
      List<dynamic> data = dataBody["data"];

      if (data.isEmpty) throw EmptyException(message: "Error empty data");

      return ProfileModel.fromJsonList(data);
    } else if (response.statusCode == 404) {
      throw StatusCodeException(message: "Data not found!");
    } else {
      throw GeneralException(message: "cannot get data");
    }
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    Uri url = Uri.parse("https://reqres.in/api/users?id=$id");

    var response = await client.get(url);

    if (response.statusCode == 200) {
      //
      Map<String, dynamic> dataBody = jsonDecode(response.body);
      Map<String, dynamic> data = dataBody["data"];
      return ProfileModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw EmptyException(message: "Data not found!");
    } else {
      //
      throw GeneralException(message: "cannot get data");
    }
  }
}
