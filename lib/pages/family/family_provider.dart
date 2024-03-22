import 'package:flutter_riverpod/flutter_riverpod.dart';

final familyCounterProvider = StateProvider.family<int, int>((ref, initialValue) {
  ref.onDispose(() {
    print('[familyCounterProvider($initialValue)] disposed');
  });
  return initialValue;
});

// StateProvider에 family modifier를 적용하면 initial value가 다른 Counter를
// 여러 개 생성할 필요가 있을 때와 같은 경우에 유용합니다.