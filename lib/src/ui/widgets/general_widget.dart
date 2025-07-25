import 'package:fancy_dio_inspector_personal/src/models/models.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/pannel_widget.dart';
import 'package:flutter/material.dart';

class GeneralWidget extends StatelessWidget {
  const GeneralWidget({
    required this.model,
    super.key,
  });

  final NetworkBaseModel model;

  @override
  Widget build(BuildContext context) {
    return PannelWidget(
      title: Text(
        'GENERAL',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.method,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            model.url,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
