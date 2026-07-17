// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PersonNotifier)
final personProvider = PersonNotifierProvider._();

final class PersonNotifierProvider
    extends $NotifierProvider<PersonNotifier, Person> {
  PersonNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'personProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$personNotifierHash();

  @$internal
  @override
  PersonNotifier create() => PersonNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Person value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Person>(value),
    );
  }
}

String _$personNotifierHash() => r'd757f80794d0327d4d955801790305676a7d5f5d';

abstract class _$PersonNotifier extends $Notifier<Person> {
  Person build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Person, Person>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Person, Person>,
              Person,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
