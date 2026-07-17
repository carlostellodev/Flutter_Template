import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_provider.g.dart';

// Provider = "caja" que guarda estado y se puede escuchar/modificar desde cualquier widget.
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
}
