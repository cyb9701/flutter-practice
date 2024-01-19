//import 'package:firebase_admob/firebase_admob.dart';
//
//class AdMobService {
//  static String _appID = '';
//  static String _interstitialID = '';
//
//  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//    keywords: <String>['id_memo', 'memo', 'security_memo', 'note', 'id_note'],
//    contentUrl: 'https://flutter.io',
//    childDirected: false,
//    testDevices: <String>[], // Android emulators are considered test devices
//  );
//
//  InterstitialAd myInterstitialAd = InterstitialAd(
//    adUnitId: _interstitialID,
//    targetingInfo: targetingInfo,
//    listener: (MobileAdEvent event) {
//      print("InterstitialAd event is $event");
//    },
//  );
//
//  String getAppID() {
//    return _appID;
//  }
//}
