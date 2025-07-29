import 'package:fancy_dio_inspector_personal/src/models/network/http_record.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/title_content_pannel_widget.dart';
import 'package:flutter/material.dart';

class ResponseHeaderWidget extends StatelessWidget {
  const ResponseHeaderWidget({
    required this.model,
    super.key,
  });

  final HttpRecord model;
  @override
  Widget build(BuildContext context) {
    return TitleContentPannelWidget(
      title: 'Response Headers',
      content: model.responseHeadersString,
    );
  }
}
