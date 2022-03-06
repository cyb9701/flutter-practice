import 'package:custom_drop_box/custom_email_drop_box.dart';
import 'package:flutter/material.dart';

class CustomTextFieldDropBoxPage extends StatefulWidget {
  const CustomTextFieldDropBoxPage({Key? key}) : super(key: key);

  @override
  State<CustomTextFieldDropBoxPage> createState() => _CustomTextFieldDropBoxPageState();
}

class _CustomTextFieldDropBoxPageState extends State<CustomTextFieldDropBoxPage> {
  // 이메일.
  late TextEditingController _emailController;
  late FocusNode _emailFocusNode;
  OverlayEntry? _overlayEntry; // 이메일 자동 추천 드롭 박스.
  final LayerLink _layerLink = LayerLink();

  // 이메일 드롭박스 해제.
  void _removeEmailOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode()
      ..addListener(() {
        if (!_emailFocusNode.hasFocus) {
          _removeEmailOverlay();
        }
      });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _overlayEntry?.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final _currentFocus = FocusScope.of(context);
        if (!_currentFocus.hasPrimaryFocus) {
          _currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Center(
          child: _emailTextField(),
        ),
      ),
    );
  }

  // 이메일 입력창.
  Widget _emailTextField() {
    // 테두리 스타일.
    final _border = OutlineInputBorder(
      borderSide: BorderSide(
        color: (_emailFocusNode.hasFocus) ? Colors.black : Colors.grey,
      ),
      borderRadius: BorderRadius.circular(5),
    );

    // 이메일 자동 입력 드롭박스 출력.
    void _showEmailOverlay() {
      // 이메일 자동 입력 드롭박스.
      if (_emailFocusNode.hasFocus) {
        if (_emailController.text.isNotEmpty) {
          final _email = _emailController.text;

          // 이메일 자동 입력 드롭박스 출력.
          if (!_email.contains('@')) {
            if (_overlayEntry == null) {
              _overlayEntry = _emailListOverlayEntry();
              Overlay.of(context)?.insert(_overlayEntry!);
            }
          }

          // 이메일 자동 입력 드롭박스 해제.
          else {
            _removeEmailOverlay();
          }
        } else {
          _removeEmailOverlay();
        }
      }
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 48,
          child: TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(fontSize: 16),
            onChanged: (_) => _showEmailOverlay(),
            decoration: InputDecoration(
              // 여백.
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),

              // 테두리.
              border: _border,
              disabledBorder: _border,
              enabledBorder: _border,
              errorBorder: _border,
              focusedBorder: _border,
              focusedErrorBorder: _border,

              // 카운터.
              counter: null,
              counterText: '',

              // 힌트 메세지.
              hintText: 'abc@email.com',
              hintStyle: const TextStyle(
                fontSize: 16,
                height: 22 / 16,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 이메일 자동 입력창.
  OverlayEntry _emailListOverlayEntry() {
    return customDropBox.emailRecommendation(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      layerLink: _layerLink,
      controller: _emailController,
      onPressed: () {
        setState(() {
          _emailFocusNode.unfocus();
          _removeEmailOverlay();
        });
      },
    );
  }
}
