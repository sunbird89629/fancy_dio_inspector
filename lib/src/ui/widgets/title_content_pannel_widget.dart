import 'package:fancy_dio_inspector_personal/src/ui/widgets/pannel_widget.dart';
import 'package:flutter/material.dart';

class TitleContentPannelWidget extends StatelessWidget {
  const TitleContentPannelWidget({
    required this.title,
    required this.content,
    super.key,
  });
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return PannelWidget(
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
