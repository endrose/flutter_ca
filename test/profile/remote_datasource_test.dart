import 'dart:convert';

import 'package:flutter_ca_1/features/profile/data/datasources/remote_datasource.dart';
import 'package:flutter_ca_1/features/profile/data/models/profile_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'remote_datasource_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<ProfileRemoteDataSource>(), MockSpec<http.Client>()])

// Real class

void main() async {
  var remoteDataSource = MockProfileRemoteDataSource(); // fake class
  var remoteDataSourceImplementation =
      ProfileRemoteDataSourceImplementation(client: MockClient());
  MockClient mockClient = MockClient();

  const int userId = 1;
  const int page = 1;

  Uri urlGetAllUser = Uri.parse("https://reqres.in/api/users?page=$page");
  Uri urlGetUser = Uri.parse("https://reqres.in/api/users?id=$userId");

  Map<String, dynamic> fakeDataJson = {
    "id": userId,
    "email": "george.bluth@reqres.in",
    "first_name": "George",
    "last_name": "Bluth",
    "avatar": "https://reqres.in/#support-heading",
  };

  ProfileModel fakeProfileModel = ProfileModel.fromJson(fakeDataJson);

  group('Profile Remote Data Source', () {
    //

    group(
      "getUser()",
      () {
        test("BERHASIL", () async {
          when(remoteDataSource.getUser(userId))
              .thenAnswer((_) async => fakeProfileModel);

          try {
            // BERHASIL
            var response = await remoteDataSource.getUser(userId);
            print(response.toJson());
            expect(response, fakeProfileModel);
          } catch (e) {
            // GAGAL
            fail("TIDAK MUNGKIN TERJADI ERROR");
          }
        });

        test('GAGAL', () async {
          //
// Stub -> kondisi untuk malsukan
          // proses stubbing
          when(remoteDataSource.getUser(userId)).thenThrow(Exception());
          try {
            var response = await remoteDataSource.getUser(userId);
            // BERHASIL

            fail("TIDAK MUNGKIN TERJADI ERROR");
          } catch (e) {
            // GAGAL
            expect(e, isException);
          }
        });
      },
    );
  });

  group('Profile Remote Data Source', () {
    //
    group(
      "getAllUser()",
      () {
        test(
          "BERHASIL",
          () async {
            when(remoteDataSource.getAllUser(page))
                .thenAnswer((_) async => [fakeProfileModel]);

            try {
              var response = await remoteDataSource.getAllUser(page);
              // print(response.toList());

              expect(response, [fakeProfileModel]);
              // KEBERHASILAN
            } catch (e) {
              fail("TIDAK MUNGKIN TERJADI ERROR");
            }
          },
        );

        test(
          "GAGAL",
          () async {
            when(remoteDataSource.getAllUser(page))
                .thenAnswer((_) async => [fakeProfileModel]);

            try {
              var response = await remoteDataSource.getAllUser(page);

              fail("TIDAK MUNGKIN TERJADI");
            } catch (e) {
              expect(e, isException);
            }
          },
        );
      },
    );
  });

  //

  group(
    "Profile Remote Data Source Implementation",
    () {
      group("getUser()", () {
        test(
          "BERHASIL",
          () async {
            when(mockClient.get(urlGetUser)).thenAnswer(
              (_) async => http.Response(
                jsonEncode({
                  "data": fakeDataJson,
                }),
                200,
              ),
            );

            try {
              var response =
                  await remoteDataSourceImplementation.getUser(userId);

              expect(response, fakeProfileModel);
              // KEBERHASILAN
            } catch (e) {
              fail("TIDAK MUNGKIN TERJADI ERROR");
            }
          },
        );
      });
    },
  );
}
