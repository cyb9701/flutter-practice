import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/data/provider/my_user_data.dart';
import 'package:flutterinstagramclone/firebase/database.dart';
import 'package:flutterinstagramclone/utils/simple_snack_bar.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  TextEditingController _phoneController;
  TextEditingController _emailController;
  TextEditingController _phonePwController;
  TextEditingController _emailPwController;
  Alignment tabAlign = Alignment.centerLeft;
  bool _currentTabBool = false;
  double _email = 0;
  double _phone = kSize.width;

  void onTap(bool tabLeft) {
    setState(() {
      if (tabLeft) {
        this.tabAlign = Alignment.centerLeft;
        _currentTabBool = false;
        _email = 0;
        _phone = -kSize.width;
      } else {
        this.tabAlign = Alignment.centerRight;
        _currentTabBool = true;
        _email = -kSize.width;
        _phone = 0;
      }
    });
  }

  get _emailRegister async {
    try {
      final AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _emailPwController.text);
      final FirebaseUser user = result.user;

      await database.attemptCreateUser(userKey: user.uid, email: user.email);
      Provider.of<MyUserData>(context, listen: false)
          .setNewUserDataStatus(MyUserDataStatus.progress);
      print(
          '@@@@@@ ${Provider.of<MyUserData>(context, listen: false).getUserDataStatus} @@@@@@');
      Navigator.pop(context);

      print('@@@@@@ Email : ${_emailController.text} @@@@@@');
      print('@@@@@@ EmailPW : ${_emailPwController.text} @@@@@@');
      print('@@@@@@ Succeed Sing Up @@@@@@');
    } catch (e) {
      simpleSnackBar(context, '문제가 발생했습니다. 다시 실행해주세요.');
      print(e);
    }
  }

  @override
  void initState() {
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _phonePwController = TextEditingController();
    _emailPwController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _phonePwController.dispose();
    _emailPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kCommon_l_gap),
        child: ListView(
          children: <Widget>[
            logo(),
            switchBtn(),
            animatedLine(),
            textFormField(),
            phoneInformation(),
          ],
        ),
      ),
    );
  }

  Padding logo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Text(
        '전화번호 또는 이메일 주소 입력',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 23.0),
      ),
    );
  }

  Row switchBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        phoneEmailBtnForm('이메일', true),
        phoneEmailBtnForm('전화번호', false),
      ],
    );
  }

  Expanded phoneEmailBtnForm(String title, bool align) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap(align);
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  AnimatedContainer animatedLine() {
    return AnimatedContainer(
      margin: EdgeInsets.only(top: 10.0, bottom: 30.0),
      alignment: tabAlign,
      height: 1,
      width: kSize.width,
      color: Colors.grey[850],
      duration: Duration(
        milliseconds: 300,
      ),
      child: Container(
        color: Colors.white,
        width: kSize.width * 0.45,
        height: 1.0,
      ),
    );
  }

  Widget textFormField() {
    return Stack(
      children: <Widget>[
        textFieldFrom(
          _phoneFormKey,
          _phone,
          //container location.
          '전화번호',
          //phone text field hint.
          '비밀번호',
          //password text field hint.
          _phoneController,
          _phonePwController,
          (String phone) {
            if (phone.isEmpty) {
              return '전화번호를 입력해주세요.';
            }
            return null;
          },
          (String pw) {
            if (pw.isEmpty) {
              return '비밀번호를 입력해주세요.';
            }
            return null;
          },
          TextInputType.numberWithOptions(),
          () {},
        ),
        textFieldFrom(
          _emailFormKey,
          _email,
          //container location.
          '이메일',
          //text field hint.
          '비밀번호',
          //text field hint.
          _emailController,
          _emailPwController,
          (String email) {
            if (email.isEmpty) {
              return '이메일을 입력해주세요.';
            }
            String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                "\\@" +
                "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                "(" +
                "\\." +
                "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                ")+";
            RegExp regExp = new RegExp(p);
            if (regExp.hasMatch(email)) {
              return null;
            }
            return '이메일을 정확하게 입력해주세요.'; //email format error validator.
          },
          (String pw) {
            if (pw.isEmpty) {
              return '비밀번호를 입력해주세요.';
            } else if (pw.length < 6) {
              return '비밀번호는 6자리 이상으로 입력해주세요.';
            }
            return null;
          },
          TextInputType.emailAddress,
          () {
            if (_emailFormKey.currentState.validate()) {
              _emailRegister;
            }
          },
        ),
      ],
    );
  }

  AnimatedContainer textFieldFrom(
    Key key,
    double location,
    String idTitle,
    String pwTitle,
    TextEditingController idController,
    TextEditingController pwController,
    FormFieldValidator<String> idValidator,
    FormFieldValidator<String> pwValidator,
    TextInputType type,
    Function onTap,
  ) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 1,
      ),
      transform: Matrix4.translationValues(location, 0, 0),
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: idController,
              decoration: kTextFieldDecoration.copyWith(
                labelText: idTitle,
              ),
              keyboardType: type,
              validator: idValidator,
            ),
            SizedBox(height: 15.0),
            TextFormField(
              obscureText: true,
              controller: pwController,
              decoration: kTextFieldDecoration.copyWith(
                labelText: pwTitle,
              ),
              keyboardType: type,
              validator: pwValidator,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(kBtnRadius),
                ),
                child: Text(
                  '가입',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Visibility phoneInformation() {
    return Visibility(
      visible: _currentTabBool,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Text(
          'Instagram의 얻베이트 내용을 SMS로 수신할 수 있으며, 언제든지 수신을 취소할 수 있습니다.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 13.0),
        ),
      ),
    );
  }
}
