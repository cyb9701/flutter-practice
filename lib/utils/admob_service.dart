import 'package:firebase_admob/firebase_admob.dart';

class AdMobService {
  static String _appID = 'ca-app-pub-2777113368726909~1063834613';
  static String _interstitialID = 'ca-app-pub-2777113368726909/6124589606';

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['id_memo', 'memo', 'security_memo', 'note', 'id_note'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  InterstitialAd myInterstitialAd = InterstitialAd(
    adUnitId: _interstitialID,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  String getAppID() {
    return _appID;
  }
}
