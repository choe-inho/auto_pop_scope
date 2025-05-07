import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_pop_scope/auto_pop_scope.dart';

void main() {
  group('AutoPopScopeController 테스트', () {
    test('handleWillPop은 onWillPop 콜백을 호출해야 함', () {
      // 콜백 호출 추적을 위한 플래그
      bool callbackCalled = false;

      // 컨트롤러 생성
      final controller = AutoPopScopeController();

      // onWillPop 콜백 설정
      controller.onWillPop = () {
        callbackCalled = true;
      };

      // handleWillPop 호출
      controller.handleWillPop();

      // 콜백이 호출되었는지 확인
      expect(callbackCalled, isTrue);
    });

    test('canPopValue는 설정된 canPop 콜백의 값을 반환해야 함', () {
      // 컨트롤러 생성
      final controller = AutoPopScopeController();

      // 기본값 확인 (true여야 함)
      expect(controller.canPopValue, isTrue);

      // canPop 콜백 설정
      controller.canPop = () => false;

      // 업데이트된 값 확인
      expect(controller.canPopValue, isFalse);
    });
  });

  testWidgets('AutoPopScopeProvider가 컨트롤러를 올바르게 제공해야 함', (WidgetTester tester) async {
    // 테스트용 컨트롤러
    final controller = AutoPopScopeController();

    // 테스트용 위젯 트리 생성
    await tester.pumpWidget(
      MaterialApp(
        home: AutoPopScopeProvider(
          controller: controller,
          child: Builder(
            builder: (context) {
              // 컨텍스트에서 컨트롤러 검색
              final retrievedController = AutoPopScopeProvider.controllerOf(context);

              // 나중에 테스트에서 검증할 수 있도록 값 저장
              return Text(retrievedController == controller ? 'true' : 'false');
            },
          ),
        ),
      ),
    );

    // 컨트롤러가 올바르게 검색되었는지 확인
    expect(find.text('true'), findsOneWidget);
  });
}