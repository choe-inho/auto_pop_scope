# auto_pop_scope

Flutter 앱에서 모든 페이지에 자동으로 PopScope를 적용하여 iOS 팝 제스처를 인식할 수 있게 해주는 패키지입니다.

## 기능

- 앱 최상위에 단 한 번만 `AutoPopScope`를 추가하면 모든 하위 페이지에서 iOS 팝 제스처가 작동합니다.
- 페이지별로 팝 동작을 제어할 수 있는 API를 제공합니다.
- `canPop` 및 `onWillPop` 콜백 기능을 지원합니다.

## 설치

```yaml
dependencies:
  auto_pop_scope: ^0.1.0
```

## 사용 방법

### 기본 사용법

앱의 최상위 위젯(일반적으로 MaterialApp)을 `AutoPopScope`로 감싸기만 하면 됩니다:

```dart
void main() {
  runApp(
    AutoPopScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
```

### 기본 동작 제어하기

앱 전체의 팝 동작을 제어하려면 콜백을 제공할 수 있습니다:

```dart
AutoPopScope(
  canPop: () => shouldAllowPop,
  onWillPop: () {
    // 팝 동작이 차단되었을 때 실행할 코드
    print('팝 동작이 감지되었습니다!');
  },
  child: MyApp(),
)
```

### 특정 페이지에서 설정 변경하기

특정 페이지에서 팝 동작을 제어하려면 확장 메서드를 사용합니다:

```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 현재 페이지에 대한 팝 동작 설정
    context.updateAutoPopScope(
      canPop: () => _canPopThisPage,
      onWillPop: () {
        // 뒤로 가기를 처리하는 코드
        print('이 페이지에서 뒤로 가기가 감지되었습니다.');
      },
    );
    
    return Scaffold(
      appBar: AppBar(title: Text('내 페이지')),
      body: Center(
        child: Text('이 페이지는 AutoPopScope의 영향을 받습니다.'),
      ),
    );
  }
}
```

## 주의사항

- Flutter 3.16.0 이상에서 작동합니다.
- 이 패키지는 새로운 `PopScope` 위젯을 사용하므로, 이전 버전의 Flutter에서는 작동하지 않을 수 있습니다.

## 라이센스

MIT