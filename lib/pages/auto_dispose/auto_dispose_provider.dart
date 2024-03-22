import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_dispose_provider.g.dart';

final autoDisposeCounterProvider = StateProvider.autoDispose<int>((ref) {
  ref.onDispose(() {
    print('[autoDisposeCounterProvider] disposed');
  });
  return 0;
});

@Riverpod(keepAlive: false)
String autoDisposeAge(AutoDisposeAgeRef ref) {
// ignore: avoid_manual_providers_as_generated_provider_dependency
  final age = ref.watch(autoDisposeCounterProvider);
  ref.onDispose(() {
    print('[autoDisposeAgeProvider] disposed');
  });
  return 'Hi! I am $age years old.';
}

// 이런 에러가 발생한 이유는 autoDisposeCounterProvider는
// autoDispose modifier가 적용된 Provider인데
// autoDisposeAgeProvider는 keepAlive가 true인 Provider
// 즉, autoDispose가 적용되지 않은 Provider이기 때문입니다.
// 이렇게 하면 autoDisposeCounterProvider는 의도와는 달리 절대 dispose되지 않을 수도 있기 때문입니다.
// 두 Provider 모두에 autoDispose modifier가 적용되었을 때는 에러가 발생하지 않습니다.
// autoDisposeAgeProvider에 autoDispose modifier를 적용해보겠습니다.
// 그렇게 하려면 어노테이션을 lower case r riverpod로 수정하거나
// upper case r Riverpod에 keepAlive argument를 false로 주면됩니다.
// keepAlive에 true 대신 false로 주겠습니다.
// 그랬더니 에러가 사라졌습니다.
// 반대로 autoDisposeCounterProvider에서 autoDispose modifier를 삭제하는 경우는
// 에러가 발생하지 않았습니다.
// 다시 autoDispose를 적용하겠습니다.

// 여러 개의 Provider들이 상호 의존적인 관계에 있을 때,
// autoDispose modifier를 잘못사용하면 원하지 않는 결과를 얻을 수 있기 때문에 주의를 해야합니다.