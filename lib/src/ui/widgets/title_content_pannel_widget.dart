import 'package:fancy_dio_inspector_personal/src/theme/theme.dart';
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
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
