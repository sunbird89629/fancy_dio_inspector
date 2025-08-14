import 'package:fancy_dio_inspector_personal/src/models/network/http_record.dart';

class HttpScopeViewConfig {
  final bool Function(HttpRecord record)? recordFilter;
  const HttpScopeViewConfig({
    this.recordFilter,
  });
}
