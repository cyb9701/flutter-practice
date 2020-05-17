import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/database/hive_db.dart';
import 'package:flutteridmemo/pages/add_page.dart';
import 'package:flutteridmemo/pages/sidebar_page.dart';
import 'package:flutteridmemo/utils/admob_service.dart';
import 'package:flutteridmemo/utils/memo_stream.dart';
import 'package:google_fonts/google_fonts.dart';

class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  String logInUsrEmail = 'Loading';

  FirebaseUser logInUsr;
  TextEditingController searchController = TextEditingController();
  String searchValue;
  final usrEmail = HiveDB().getUsrEmail();

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
    FirebaseAdMob.instance.initialize(appId: AdMobService().getAppID());
    searchMemo();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
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
            SideBarPage(),
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
          MemoStream(search: searchValue),
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
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'i ',
                    style: GoogleFonts.jua(
                      textStyle: TextStyle(
                        fontSize: 30.0,
                      ),
                    )),
                TextSpan(
                  text: 'D_M',
                  style: GoogleFonts.jua(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                      color: kColorGreen,
                    ),
                  ),
                ),
                TextSpan(
                  text: ' emo',
                  style: GoogleFonts.jua(
                    textStyle: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
          builder: (BuildContext context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddPage(logInUsr: usrEmail),
            ),
          ),
        );
      },
    );
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
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => searchController.clear());
              FocusScope.of(context).requestFocus(new FocusNode());
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
