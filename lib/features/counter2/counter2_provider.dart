import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter2_provider.g.dart';

@riverpod
class Counter2 extends _$Counter2 {
  @override
  int build() => 100; // estado inicial distinto, para notar diferencia

  void decrement() => state--;
}
