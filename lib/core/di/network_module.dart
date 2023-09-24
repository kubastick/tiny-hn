import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  ChopperClient get chopperClient => ChopperClient(
        interceptors: [HttpLoggingInterceptor()],
        converter: const JsonConverter(),
      );
}
