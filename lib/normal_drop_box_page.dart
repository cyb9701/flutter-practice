import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropBoxPage extends StatefulWidget {
  const CustomDropBoxPage({Key? key}) : super(key: key);

  @override
  State<CustomDropBoxPage> createState() => _CustomDropBoxPageState();
}

class _CustomDropBoxPageState extends State<CustomDropBoxPage> {
  // 드롭박스 리스트.
  static const List<String> _dropBoxList = ['One', 'Two', 'Three', 'Four', 'Five'];

  // 선택값.
  String _dropBoxValue = 'One';

  // 드롭박스.
  OverlayEntry? _overlayEntry; // 이메일 자동 추천 드롭 박스.
  final LayerLink _layerLink = LayerLink();
  static const double _dropBoxWidth = 200;
  static const double _dropBoxHeight = 48;

  // 드롭박스 생성.
  void _createOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _customDropBox();
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  // 드롭박스 해제.
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _overlayEntry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _removeOverlay(),
      child: Scaffold(
        body: Center(
          child: InkWell(
            onTap: () {
              _createOverlay();
            },
            child: CompositedTransformTarget(
              link: _layerLink,
              child: Container(
                width: _dropBoxWidth,
                height: _dropBoxHeight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 선택값.
                    Text(
                      _dropBoxValue,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 22 / 16,
                        color: Colors.black,
                      ),
                    ),

                    // 아이콘.
                    const Icon(
                      Icons.arrow_downward,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 드롭박스.
  OverlayEntry _customDropBox() {
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: _dropBoxWidth,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, _dropBoxHeight),
          child: Material(
            color: Colors.white,
            child: Container(
              height: (22.0 * _dropBoxList.length) + (21 * (_dropBoxList.length - 1)) + 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: _dropBoxList.length,
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    pressedOpacity: 1,
                    minSize: 0,
                    onPressed: () {
                      setState(() {
                        _dropBoxValue = _dropBoxList.elementAt(index);
                      });
                      _removeOverlay();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _dropBoxList.elementAt(index),
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
