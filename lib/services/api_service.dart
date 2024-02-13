abstract class AbstractApiService {
  Future<String?>? post();
}

class ApiService implements AbstractApiService {
  @override
  Future<String?>? post() {
    // TODO: implement post
    throw UnimplementedError();
  }
}
