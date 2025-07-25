import 'package:fancy_dio_inspector_personal/src/models/models.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/general_widget.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/request_header_widget.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/response_header_widget.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/title_content_pannel_widget.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/widgets.dart';
import 'package:fancy_dio_inspector_personal/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef FancyItemCustomButtonBuilder = FancyElevatedButton Function(
  BuildContext context,
);

class HttpItemWiget<T extends NetworkBaseModel> extends StatelessWidget {
  final T component;
  final FancyDioInspectorTileOptions tileOptions;
  final FancyDioInspectorL10nOptions l10nOptions;

  final FancyItemCustomButtonBuilder? customButtonBuilder;

  const HttpItemWiget({
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
      spacing: 8,
      children: [
        GeneralWidget(
          model: component,
        ),
        RequestHeaderWidget(
          description: component.requestBody,
        ),
        ResponseHeaderWidget(
          description: component.headers,
        ),
        buildContentWidget(),
        if (tileOptions.showButtons) ...[
          _buildItemButtons(context),
        ],
      ],
    );
  }

  Widget buildContentWidget() {
    if (component is NetworkResponseModel) {
      // return FancyResponseNetworkTile<NetworkResponseModel>(
      //   component: component as NetworkResponseModel,
      //   options: tileOptions,
      //   responseTitleText: l10nOptions.responseTitleText,
      //   errorTitleText: l10nOptions.errorTitleText,
      // );
      final model = component as NetworkResponseModel;
      return TitleContentPannelWidget(
        title: 'RESPONSE BODY (${model.statusCode})',
        content: model.responseBody,
      );
    } else if (component is NetworkErrorModel) {
      final model = component as NetworkErrorModel;
      return TitleContentPannelWidget(
        title: 'ERROR BODY',
        content: model.errorBody,
      );
    } else {
      return const SizedBox.shrink();
    }
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
