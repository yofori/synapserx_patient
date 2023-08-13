// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userprofile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncUserProfileHash() => r'6a590f5c6b59e402b4e2e8cba55b9e362a2a9fef';

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
String _$setFullnameHash() => r'5e22938eef752c39fb0d4ab39b9ec09f72e32d3a';

/// See also [SetFullname].
@ProviderFor(SetFullname)
final setFullnameProvider =
    AutoDisposeNotifierProvider<SetFullname, String>.internal(
  SetFullname.new,
  name: r'setFullnameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$setFullnameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SetFullname = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
