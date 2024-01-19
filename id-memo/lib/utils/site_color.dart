import 'package:flutteridmemo/constants/constants.dart';

class SiteColor {
  String findSiteColor(String site) {
    return site.toLowerCase().contains('youtube')
        ? kColorYoutube
        : site.toLowerCase().contains('유튜브')
            ? kColorYoutube
            : site.toLowerCase().contains('facebook')
                ? kColorFacebook
                : site.toLowerCase().contains('페북')
                    ? kColorFacebook
                    : site.toLowerCase().contains('페이스북')
                        ? kColorFacebook
                        : site.toLowerCase().contains('카카오')
                            ? kColorKakao
                            : site.toLowerCase().contains('kakao')
                                ? kColorKakao
                                : site.toLowerCase().contains('instagram')
                                    ? kColorInstagram
                                    : site.toLowerCase().contains('인스타')
                                        ? kColorInstagram
                                        : site.toLowerCase().contains('naver')
                                            ? kColorNaver
                                            : site.toLowerCase().contains('네이버')
                                                ? kColorNaver
                                                : site
                                                        .toLowerCase()
                                                        .contains('google')
                                                    ? kColorGoogle
                                                    : site
                                                            .toLowerCase()
                                                            .contains('구글')
                                                        ? kColorGoogle
                                                        : site
                                                                .toLowerCase()
                                                                .contains(
                                                                    'daum')
                                                            ? kColorDaum
                                                            : site
                                                                    .toLowerCase()
                                                                    .contains(
                                                                        '다음')
                                                                ? kColorDaum
                                                                : site
                                                                        .toLowerCase()
                                                                        .contains(
                                                                            'disc')
                                                                    ? kColorDiscord
                                                                    : site.toLowerCase().contains(
                                                                            '디스코')
                                                                        ? kColorDiscord
                                                                        : site.toLowerCase().contains('netflix')
                                                                            ? kColorNetflix
                                                                            : site.toLowerCase().contains('넷플')
                                                                                ? kColorNetflix
                                                                                : null;
  }
}
