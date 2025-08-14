import 'package:fancy_dio_inspector_personal/src/models/network/http_record.dart';

class HttpScopeViewConfig {
  final bool Function(HttpRecord record)? recordFilter;
  /// The URL to open when the user taps the help button in HttpScopeView.
  /// If null, a sensible default pointing to the repository manual will be used.
  final String? manualUrl;
  const HttpScopeViewConfig({
    this.recordFilter,
    this.manualUrl,
  });
}
