import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomDropdown customDropdown = CustomDropdown();

class CustomDropdown {
  // 이메일 자동 입력창.
  OverlayEntry emailRecommendation({
    required double width,
    required EdgeInsets margin,
    required LayerLink layerLink,
    required TextEditingController controller,
    required Function onPressed,
  }) {
    const List<String> _emailList = [
      '@gmail.com',
      '@hotmail.com',
      '@naver.com',
      '@kakao.com',
      '@daum.net',
    ];
    final _emailListLength = _emailList.length;

    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 48),
          child: Material(
            color: Colors.white,
            child: Container(
              height: (22.0 * _emailListLength) + (21 * (_emailListLength - 1)) + 20,
              margin: margin,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: _emailList.length,
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    pressedOpacity: 1,
                    minSize: 0,
                    onPressed: () {
                      // 이메일 입력값 변경.
                      controller.text += _emailList.elementAt(index);

                      onPressed();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${controller.text}${_emailList.elementAt(index)}',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 22 / 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
