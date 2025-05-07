import 'package:flutter/material.dart';
import 'auto_pop_scope_controller.dart';

/// AutoPopScope 컨트롤러를 앱 전체에 제공하는 Provider
class AutoPopScopeProvider extends InheritedWidget {
  /// AutoPopScope 컨트롤러
  final AutoPopScopeController controller;

  const AutoPopScopeProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  /// 현재 컨텍스트에서 AutoPopScopeProvider를 찾아 반환
  static AutoPopScopeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AutoPopScopeProvider>();
  }

  /// 현재 컨텍스트에서 AutoPopScopeController를 찾아 반환
  static AutoPopScopeController? controllerOf(BuildContext context) {
    return AutoPopScopeProvider.of(context)?.controller;
  }

  @override
  bool updateShouldNotify(AutoPopScopeProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}
