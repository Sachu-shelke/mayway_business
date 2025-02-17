import 'package:mayway_business/constants/enum.dart';

class MirrorHubEnvironment {
  MirrorHubEnvironment(this.environmentType);
  final EnvironmentType environmentType;

  EnvironmentVariables setupEnvironmentVariables() {
    switch (environmentType) {
      case EnvironmentType.development:
        return EnvironmentVariables(
          isProd: false,
          appVersion: '1.0',
          cmsBaseUrl: '',
          forceUpdateURL: '',
          sslCheckURL: "",
          authorizationToken: '',
          cmsAPIToken: '',
          graphQlEndPoint: 'https://sock8.hasura.app/v1/graphql',
          baseUrl:
              'https://api.mayway.in/api/',
          shoppingBaseUrl: 'https://mirrorhub.in/api/',
          giftCardEndPoint: '',
          dtOneEndPoint: '',
          bucketUrl:
              "https://api.mayway.in/",
          travelPurchaseEndPoint: '',
          offersPartnersEndPoint: '',
        );
      case EnvironmentType.production:
        return EnvironmentVariables(
          isProd: true,
          appVersion: '1.0.0',
          cmsBaseUrl: '',
          forceUpdateURL: '',
          sslCheckURL: "",
          authorizationToken: '',
          cmsAPIToken: '',
          bucketUrl:
              "https://api.mayway.in/",
          graphQlEndPoint: 'https://sock8.hasura.app/v1/graphql',
          baseUrl:
              'https://api.mayway.in/api/',
          shoppingBaseUrl: 'https://mirrorhub.in/api/',
          giftCardEndPoint: '',
          dtOneEndPoint: '',
          travelPurchaseEndPoint: '',
          offersPartnersEndPoint: '',
        );
    }
  }
}

class EnvironmentVariables {
  final String appVersion;
  final String graphQlEndPoint;
  final String authorizationToken;
  final String giftCardEndPoint;
  final String forceUpdateURL;
  final String cmsAPIToken;
  final String cmsBaseUrl;
  final String baseUrl;
  final String shoppingBaseUrl;
  final String dtOneEndPoint;
  final String travelPurchaseEndPoint;
  final String offersPartnersEndPoint;
  final bool isProd;
  final String sslCheckURL;
  final String bucketUrl;

  EnvironmentVariables({
    required this.appVersion,
    required this.authorizationToken,
    required this.graphQlEndPoint,
    required this.giftCardEndPoint,
    required this.forceUpdateURL,
    required this.cmsAPIToken,
    required this.cmsBaseUrl,
    required this.baseUrl,
    required this.shoppingBaseUrl,
    required this.bucketUrl,
    required this.dtOneEndPoint,
    required this.travelPurchaseEndPoint,
    required this.offersPartnersEndPoint,
    required this.isProd,
    required this.sslCheckURL,
  });
}
