// lib/src/auto_pop_scope_controller.dart
import 'package:flutter/material.dart';

/// AutoPopScope의 동작을 제어하는 컨트롤러
class AutoPopScopeController {
  /// 현재 팝 동작이 허용되는지 여부를 반환하는 콜백
  VoidCallback? _onWillPopCallback;

  /// 팝 동작이 허용되는지 여부를 결정하는 기본 함수
  bool Function()? _canPop;

  /// 팝 동작이 허용되는지 여부를 결정하는 함수 설정
  set canPop(bool Function() callback) {
    _canPop = callback;
  }

  /// 팝 동작이 허용되는지 여부를 반환
  bool get canPopValue => _canPop?.call() ?? true;

  /// 팝 동작 감지 시 호출될 콜백 설정
  set onWillPop(VoidCallback callback) {
    _onWillPopCallback = callback;
  }

  /// 팝 동작 감지 시 호출될 콜백 실행
  void handleWillPop() {
    print('handleWillPop 호출됨!');
    if (_onWillPopCallback != null) {
      print('onWillPop 콜백 실행!');
      _onWillPopCallback!();
    } else {
      print('onWillPop 콜백이 null입니다.');
    }
  }
}