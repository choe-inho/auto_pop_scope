// example/lib/main.dart
import 'package:flutter/material.dart';
import 'package:auto_pop_scope/auto_pop_scope.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoPopScope(
      onWillPop: () {
        print('앱 수준에서 팝 동작이 감지되었습니다!');
      },
      child: MaterialApp(
        title: 'AutoPopScope 예제',
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈 페이지')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const DetailPage()),
            );
          },
          child: const Text('상세 페이지로 이동'),
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _allowPop = false;

  @override
  void initState() {
    super.initState();

    // 페이지 설정 업데이트
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.updateAutoPopScope(
        canPop: () => _allowPop,
        onWillPop: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('뒤로 가기를 허용하려면 스위치를 켜세요')),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상세 페이지')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('뒤로 가기를 허용하려면 스위치를 켜세요'),
            Switch(
              value: _allowPop,
              onChanged: (value) {
                setState(() {
                  _allowPop = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}