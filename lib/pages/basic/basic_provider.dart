import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basic_provider.g.dart';

final counterProvider = StateProvider<int>((ref) {
  ref.onDispose(() {
    print('[counterProvider] disposed');
  });
  return 0;
});

// Provider내에서 다른 Provider를 watch하고 있을 때,
// watch하고있는 Provider의 state가 변하면 Provider자체가 rebuild되기 때문입니다.
// ref.listen: 특별한 액션을 취하고 싶을 경우 사용하면됩니다.
@Riverpod(keepAlive: true)
String age(AgeRef ref) {
  // ignore: avoid_manual_providers_as_generated_provider_dependency
  final age = ref.watch(counterProvider);
  ref.onDispose(() {
    print('[ageProvider] disposed');
  });
  return 'Hi! I am $age years old.';
}