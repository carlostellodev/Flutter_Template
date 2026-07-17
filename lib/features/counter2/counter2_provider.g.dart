// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter2_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Counter2)
final counter2Provider = Counter2Provider._();

final class Counter2Provider extends $NotifierProvider<Counter2, int> {
  Counter2Provider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'counter2Provider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$counter2Hash();

  @$internal
  @override
  Counter2 create() => Counter2();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$counter2Hash() => r'04a08e7284f4ff2eaec15a66c0bf74865b0d8bc4';

abstract class _$Counter2 extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
