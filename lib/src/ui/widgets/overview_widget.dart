import 'package:fancy_dio_inspector_personal/src/models/network/http_record.dart';
import 'package:fancy_dio_inspector_personal/src/theme/theme.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/pannel_widget.dart';
import 'package:flutter/material.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({
    required this.model,
    super.key,
  });

  final HttpRecord model;

  @override
  Widget build(BuildContext context) {
    return PannelWidget(
      title: Row(
        children: [
          Container(
            width: 4,
            color: FancyColors.turquoise,
            height: 20,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            'Overview',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.requestOptions.method,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            model.requestOptions.uri.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            model.requestOptions.contentType ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
