import 'package:flutter/material.dart';
import 'auto_pop_scope_controller.dart';
import 'auto_pop_scope_provider.dart';

/// 앱 전체에 자동으로 PopScope를 적용하는 위젯
class AutoPopScope extends StatefulWidget {
  /// 자식 위젯
  final Widget child;

  /// 팝 동작이 허용되는지 여부를 결정하는 함수
  final bool Function()? canPop;

  /// 팝 동작이 감지되었을 때 호출될 콜백
  final VoidCallback? onWillPop;

  const AutoPopScope({
    super.key,
    required this.child,
    this.canPop,
    this.onWillPop,
  });

  @override
  State<AutoPopScope> createState() => _AutoPopScopeState();
}

class _AutoPopScopeState extends State<AutoPopScope> {
  late final AutoPopScopeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AutoPopScopeController();

    if (widget.canPop != null) {
      _controller.canPop = widget.canPop!;
    }

    if (widget.onWillPop != null) {
      _controller.onWillPop = widget.onWillPop!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoPopScopeProvider(
      controller: _controller,
      child: _AutoPopScopeListener(child: widget.child),
    );
  }
}

/// 하위 위젯 트리에서 Navigator 변경을 감지하고 자동으로 PopScope를 적용하는 위젯
class _AutoPopScopeListener extends StatefulWidget {
  final Widget child;

  const _AutoPopScopeListener({required this.child});

  @override
  State<_AutoPopScopeListener> createState() => _AutoPopScopeListenerState();
}

class _AutoPopScopeListenerState extends State<_AutoPopScopeListener>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // _AutoPopScopeListener 클래스의 build 메서드 수정
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // 여기서 PopScope를 사용하여 앱 전체에 적용
        return PopScope(
          canPop: AutoPopScopeProvider.controllerOf(context)?.canPopValue ?? true,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              print('팝 동작 감지됨: onPopInvokedWithResult 호출됨!');
              final controller = AutoPopScopeProvider.controllerOf(context);
              if (controller != null) {
                controller.handleWillPop();
              }
            }
          },
          child: widget.child,
        );
      },
    );
  }
}

/// 개별 페이지에서 AutoPopScope 설정을 사용하기 위한 확장 메서드
extension AutoPopScopeExtension on BuildContext {
  /// 현재 컨텍스트에서 AutoPopScopeController 가져오기
  AutoPopScopeController? get autoPopScopeController =>
      AutoPopScopeProvider.controllerOf(this);

  /// PopScope 설정 업데이트하기
  void updateAutoPopScope({bool Function()? canPop, VoidCallback? onWillPop}) {
    final controller = autoPopScopeController;
    if (controller != null) {
      if (canPop != null) {
        controller.canPop = canPop;
      }
      if (onWillPop != null) {
        controller.onWillPop = onWillPop;
      }
    }
  }
}
