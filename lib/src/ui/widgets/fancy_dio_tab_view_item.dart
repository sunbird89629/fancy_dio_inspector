import 'package:fancy_dio_inspector/src/models/models.dart';
import 'package:fancy_dio_inspector/src/ui/widgets/widgets.dart';
import 'package:fancy_dio_inspector/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef FancyItemCustomButtonBuilder = FancyElevatedButton Function(
  BuildContext context,
);

class FancyDioTabViewItem<T extends NetworkBaseModel> extends StatelessWidget {
  final T component;
  final FancyDioInspectorTileOptions tileOptions;
  final FancyDioInspectorL10nOptions l10nOptions;

  final FancyItemCustomButtonBuilder? customButtonBuilder;

  const FancyDioTabViewItem({
    required this.component,
    required this.tileOptions,
    required this.l10nOptions,
    super.key,
    this.customButtonBuilder,
  });

  String get time {
    final innerTime = component.time.toFormattedString();

    if (component is NetworkResponseModel) {
      final model = component as NetworkResponseModel;

      return model.getFormattedTime();
    } else if (component is NetworkErrorModel) {
      final model = component as NetworkErrorModel;

      return model.getFormattedTime();
    } else {
      return innerTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (tileOptions.showButtons) ...[
          _buildItemButtons(context),
        ],
        FancyDioTile(
          title: '${l10nOptions.urlTitleText} (${component.method})',
          description: component.url,
          options: tileOptions,
        ),
        if (component.method != 'GET') ...[
          const FancyGap.medium(),
          FancyDioTile(
            title: l10nOptions.requestTitleText,
            description: component.requestBody,
            options: tileOptions,
          ),
        ],
        FancyResponseNetworkTile(
          component: component,
          options: tileOptions,
          responseTitleText: l10nOptions.responseTitleText,
          errorTitleText: l10nOptions.errorTitleText,
        ),
        const FancyGap.medium(),
        FancyDioTile(
          title: l10nOptions.headersTitleText,
          description: component.headers,
          options: tileOptions,
        ),
        const FancyGap.medium(),
        FancyDioTile(
          description: time,
          options: tileOptions,
        ),
      ],
    );
  }

  Row _buildItemButtons(BuildContext context) {
    final buttons = <Widget>[
      Expanded(
        child: FancyElevatedButton.cURL(
          text: l10nOptions.cURLText,
          onPressed: () {
            context
              ..showSnackBar(l10nOptions.cURLCopiedText)
              ..copyToClipboard(component.cURL);
          },
        ),
      ),
      Expanded(
        child: FancyElevatedButton.copy(
          text: l10nOptions.copyText,
          onPressed: () {
            context
              ..showSnackBar(l10nOptions.copiedText)
              ..copyToClipboard(component.toClipboardText());
          },
        ),
      ),
    ];
    if (customButtonBuilder != null) {
      buttons.add(customButtonBuilder!(context));
    }
    return Row(
      spacing: 20,
      children: buttons,
    );
  }
}
