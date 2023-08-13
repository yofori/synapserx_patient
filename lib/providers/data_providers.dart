import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dio_client.dart';

// Provider for DioClient
final dioClientProvider = Provider<DioClient>((ref) => DioClient());
