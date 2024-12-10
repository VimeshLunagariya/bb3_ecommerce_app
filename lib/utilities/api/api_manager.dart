// ignore_for_file: lines_longer_than_80_chars, public_member_api_docs

part of 'api.dart';

typedef JSON = Map<String, dynamic>;

/// enum of apiTypes available to use.
enum APIType {
  tPost,
  tGet,
  tPut,
  tDelete,
  tPatch,
}

/// Base Class of the application to handle all APIS.
class API {
  /// base function of APIs.
  static Future<Either<dynamic, Exception>> callAPI(
    BuildContext context, {
    required String url,
    required APIType type,
    Map<String, dynamic>? body,
    Map<String, String>? header,
    Map<String, dynamic>? parameters,
  }) async {
    List<String>? listKeys = [];
    List<String>? listValues = [];

    if (parameters != null) {
      parameters.forEach((key, value) {
        listKeys.add(key);
        listValues.add(value);
      });
    }

    String? paramString = '';
    for (int i = 0; i < listKeys.length; i++) {
      if (i == 0) {
        paramString = '${paramString!}?';
      }
      paramString = '${paramString!}${listKeys[i]}=${listValues[i]}';

      if (i != listKeys.length - 1) {
        paramString = '$paramString&';
      }
    }
    List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        http.Response apiResponse;
        dynamic apiBody = body;

        /// Static Token pass into the Header
        /// Change While Implementing the Auth Flow
        Map<String, String> appHeader = {
          'access_token':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtNGdqbThkdDA2ejdtbGkwM2loanZvcG0iLCJmaXJzdE5hbWUiOiJWaW1lc2giLCJtaWRkbGVOYW1lIjpudWxsLCJsYXN0TmFtZSI6Ikx1bmFnYXJpeWEiLCJlbWFpbCI6InZpbWVzaGx1bmFnYXJpeWEwN0BnbWFpbC5jb20iLCJwaG9uZSI6Ijk5OTg1NTIwNTgiLCJwcm92aWRlciI6ImxvY2FsIiwicHJvdmlkZXJJZCI6bnVsbCwiYXZhdGFyVXJsIjpudWxsLCJtZXRhZGF0YSI6bnVsbCwiY3JlYXRlZEF0IjoiMjAyNC0xMi0wOVQwNDozOTowOC4yNzNaIiwidXBkYXRlZEF0IjoiMjAyNC0xMi0wOVQwNDozOTowOC4yNzNaIiwiYmFubmVkQXQiOm51bGwsImJhbm5lZEJ5SWQiOm51bGwsImJhbm5lZFJlYXNvbiI6bnVsbCwidmVyaWZpZWRBdCI6bnVsbCwiaWF0IjoxNzMzNzE5MTU1LCJleHAiOjE3MzQzMjM5NTV9.NykgCoP2XX6NoLLL9ApaE9-Y7B2FMNxJ6AJLu_TZdMw',
          'refresh_token':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbTRnam04ZHQwNno3bWxpMDNpaGp2b3BtIiwiZW1haWwiOiJ2aW1lc2hsdW5hZ2FyaXlhMDdAZ21haWwuY29tIiwiZmlyc3ROYW1lIjoiVmltZXNoIiwibGFzdE5hbWUiOiJMdW5hZ2FyaXlhIiwiaWF0IjoxNzMzNzE5MTU1LCJleHAiOjE3MzYzMTExNTV9.iEWVTxyhOQHIiG3yz04pjQNZLtavHzILp2Fl_00-nVI',
        };

        if (header != null) {
          appHeader.addAll(header);
        }

        /// [POST CALL]
        if (type == APIType.tPost) {
          assert(body != null);
          appHeader.addAll({'Content-type': 'application/json'});

          apiResponse = await http.post(Uri.parse(url), body: jsonEncode(apiBody), headers: appHeader);
        }

        /// [GET CALL]
        else if (type == APIType.tGet) {
          apiResponse = await http.get(Uri.parse(url + (paramString ?? '')), headers: appHeader);
        }

        /// [PUT CALL]
        else if (type == APIType.tPut) {
          apiResponse = await http.put(Uri.parse(url), body: apiBody, headers: appHeader, encoding: Encoding.getByName('utf-8'));
        } else if (type == APIType.tPatch) {
          apiResponse = await http.patch(Uri.parse(url), body: apiBody, headers: appHeader, encoding: Encoding.getByName('utf-8'));
        }

        /// [DELETE CALL]
        else {
          apiResponse = await http.delete(Uri.parse(url), body: apiBody, headers: appHeader);
        }

        late Map<String, dynamic> response;
        if (apiResponse.headers['content-type'] == 'application/pdf') {
          response = {'status': 200};
        } else {
          response = jsonDecode(apiResponse.body);
        }

        customDebugPrintWidget('-----------------------------------------');
        customDebugPrintWidget('URL --> $url${paramString ?? ''}');
        customDebugPrintWidget('TYPE --> $type');
        customDebugPrintWidget('APP HEADER --> $appHeader');
        customDebugPrintWidget('STATUS CODE ---> ${apiResponse.statusCode.toString()}');
        customDebugPrintWidget('BODY ---> $body');
        customDebugPrintWidget('PARAMETER ---> $parameters');
        customDebugPrintWidget('RESPONSE ---> ${jsonDecode(apiResponse.body)}');
        customDebugPrintWidget('-----------------------------------------');
        switch (apiResponse.statusCode) {
          case 200:
            return Left(response);

          case 500:
            SnackbarWidget.showSnackbar(context: context, snackBarType: SnackBarType.error, message: 'Something went wrong!');
            return Right(ServerException());

          case 404:
            SnackbarWidget.showSnackbar(context: context, snackBarType: SnackBarType.error, message: 'Something went wrong!');
            return Right(PageNotFoundException());
          case 400: // bad request !
            SnackbarWidget.showSnackbar(context: context, snackBarType: SnackBarType.error, message: jsonDecode(apiResponse.body)['message'][0]);

            return Right(BadRequestException());

          case 401:
            await VariableUtilities.preferences.setBool(LocalCacheKey.applicationLoginState, false);
            SnackbarWidget.showSnackbar(context: context, snackBarType: SnackBarType.error, message: jsonDecode(apiResponse.body)['message']);

            return Right(AuthorizationException());
          default:
            SnackbarWidget.showSnackbar(context: context, snackBarType: SnackBarType.error, message: 'Something went wrong!');
            return Right(GeneralAPIException());
        }
      } catch (e) {
        customDebugPrintWidget('showSnackbar --> $e');
        SnackbarWidget.showSnackbar(context: context, snackBarType: SnackBarType.error, message: 'Something went wrong!');

        return Right(
          APIException(
            message: e.toString(),
          ),
        );
      }
    } else {
      NoInternetException();
      return Right(
        NoInternetException(),
      );
    }
  }
}
