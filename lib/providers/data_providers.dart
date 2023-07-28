import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dio_client.dart';

//* Repository
final _profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => DioClient(),
);
