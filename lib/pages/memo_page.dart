import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/pages/add_page.dart';
import 'package:flutteridmemo/pages/sidebar_page.dart';
import 'package:flutteridmemo/utils/admob_service.dart';
import 'package:flutteridmemo/utils/memo_stream.dart';

class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser logInUsr;
  String logInUsrEmail = 'Loading...';
  TextEditingController searchController = TextEditingController();
  String searchValue;

  void getCurrentUsr() async {
    try {
      final currentUsr = await _auth.currentUser();
      if (currentUsr != null) {
        setState(() {
          logInUsr = currentUsr;
          logInUsrEmail = logInUsr.email;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void searchMemo() {
    searchController.addListener(() {
      setState(() {
        searchValue = searchController.text;
      });
      print('@@@@@@ Search String: $searchValue @@@@@@');
    });
  }

  @override
  void initState() {
    getCurrentUsr();
    FirebaseAdMob.instance.initialize(appId: AdMobService().getAppID());
    searchMemo();
    super.initState();
  }

  @override
  void dispose() {
    getCurrentUsr();
    FirebaseAdMob.instance.initialize(appId: AdMobService().getAppID());
    searchMemo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    kSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kColorBlack,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildMainPage(context),
            SideBarPage(
              logInUsr: logInUsrEmail,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMainPage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Column(
        children: <Widget>[
          buildContainerAppBar(),
          buildSearchBar(),
          MemoStream(logInUsrEmail: logInUsrEmail, search: searchValue),
        ],
      ),
    );
  }

  Widget buildContainerAppBar() {
    return Container(
      height: 70.0,
      padding: EdgeInsets.fromLTRB(70.0, 0, 40.0, 0),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'i ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: kColorBlue)),
            TextSpan(
                text: 'D__M',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45.0,
                )),
            TextSpan(
                text: ' emo',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: kColorBlue)),
          ])),
          SizedBox(
            width: 20.0,
          ),
          CircleAvatar(
            radius: 20.0,
            backgroundColor: kColorGreen,
            child: buildAddBtn(),
          ),
        ],
      ),
    );
  }

  InkWell buildAddBtn() {
    return InkWell(
        child: Icon(
          Icons.add,
          size: 30.0,
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddPage(logInUsr: logInUsrEmail),
              ),
            ),
          );
        });
  }

  Widget buildSearchBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(70, 10, 10, 10),
      child: TextField(
        autofocus: false,
        decoration: kTextFieldDecoration.copyWith(
          labelText: '검색',
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          suffixIcon: InkWell(
            onTap: () {
              searchController.clear();
            },
            child: Icon(
              Icons.cancel,
              color: kColorGreen,
            ),
          ),
        ),
        controller: searchController,
      ),
    );
  }
}
