import 'package:fancy_dio_inspector_personal/src/ui/widgets/title_content_pannel_widget.dart';
import 'package:flutter/material.dart';

class RequestHeaderWidget extends StatelessWidget {
  const RequestHeaderWidget({
    required this.description,
    super.key,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return TitleContentPannelWidget(
      title: 'REQUEST HEADERS',
      content: description,
    );
  }
}
