//// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
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
// 다른 Provider의 state을 observe하고 싶을 때는 위젯에서와 마찬가지로 ref.watch를 사용하면 됩니다.
// 그리고 특별한 액션을 취하고 싶을 때는 ref.listen을 사용하면 됩니다. 그런데 ref.read는 가급적 사용하지마시기 바랍니다.
// ignore: avoid_manual_providers_as_generated_provider_dependency
  final age = ref.watch(counterProvider);
  ref.onDispose(() {
    print('[ageProvider] disposed');
  });
  return 'Hi! I am $age years old.';
}

// 그런데 ageProvider에 경고가 발생했습니다. 경고의 내용을 보겠습니다.
// 경고의 내용은 다음과 같습니다.
// Provider A와 Provider B가 있는데,
// A 코드 제네레이션을 사용하지 않고 만든 Provider고
// B는 코드 제네레이션을 사용해서 만든 Provider입니다.
// 그런데 B는 A의 값에 의존합니다.
// 이런 상황에서 발생하는 경고 입니다.
// 즉, B가 코드 제네레이션을 사용해 만든 Provider고 A에 의존하면
// A도 코드 제네레이션을 사용해서 만든 Provider여야 한다는 내용입니다.
// 그렇지 않으면 Provider depedencies 규칙을 깰 수도 있다는 내용입니다.

// Provider depedencies 규칙은 Provider Scope와도 관계가 있는 다소 복잡한 주제입니다.
// 그렇기 때문에 상세한 내용은 뒤에 riverpod_lint섹션에서 다루겠습니다.

// 지금은 경고를 무시하고 사용해도 되는 케이스 입니다.
// 경고가 표시되는게 보기 싫을 경우에는
//// ignore: avoid_manual_providers_as_generated_provider_dependency (라인)
//// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency (파일 전체)

// StateProvider는 코드 제네레이션이 지원되지 않습니다.
// 반면 Provider는 코드 제네레이션이 지원됩니다.
// 그런데 manual 방식과 코드 제네레이션 방식을 혼용하니까 경고가 발생했습니다.
// 어떻게 하는게 좋을까요?
// 첫번째는 StateProvider대신에 코드 제네레이션이 지원되는
// NotifierProvider를 사용하는 방식입니다.
// 그런데 앞에서도 말씀드린 것 처럼 NotifierProvider를 사용하기 위해서는
// Notifier Subclass를 만들어야하는 오버헤드가 있습니다.
// 저는 별 것 아니라고 생각합니다.

// 두번째는 Provider를 특정 위젯트리에서 scoping하는 경우가 아니라면
// 예제해서했던 것 처럼 경고를 무시하는 방법입니다.
// Provider의 scoping에 대해서는 뒤에서 말씀드리겠습니다.
// 제가 추천드리는 방식은 가급적 StateProvider 대신에
// 코드 제네레이션이 지원되는 NotifierProvider를 사용하는 것 입니다.