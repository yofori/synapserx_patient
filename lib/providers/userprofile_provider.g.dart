// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userprofile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncUserProfileHash() => r'16e4ca6706551e3dca1bca5d8a741e5f7badf03d';

/// See also [AsyncUserProfile].
@ProviderFor(AsyncUserProfile)
final asyncUserProfileProvider =
    AutoDisposeAsyncNotifierProvider<AsyncUserProfile, UserProfile>.internal(
  AsyncUserProfile.new,
  name: r'asyncUserProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncUserProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncUserProfile = AutoDisposeAsyncNotifier<UserProfile>;
String _$isSaveButtonEnabledHash() =>
    r'4c0291fd90f68a41e6b26a26a012120bff237969';

/// See also [IsSaveButtonEnabled].
@ProviderFor(IsSaveButtonEnabled)
final isSaveButtonEnabledProvider =
    AutoDisposeNotifierProvider<IsSaveButtonEnabled, bool>.internal(
  IsSaveButtonEnabled.new,
  name: r'isSaveButtonEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isSaveButtonEnabledHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsSaveButtonEnabled = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
