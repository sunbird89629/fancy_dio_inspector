import 'package:fancy_dio_inspector_personal/fancy_dio_inspector_personal.dart';
import 'package:fancy_dio_inspector_personal/src/models/network/network_base_model.dart';
import 'package:fancy_dio_inspector_personal/src/ui/ui.dart';
import 'package:fancy_dio_inspector_personal/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class HttpDetailPage extends StatelessWidget {
  const HttpDetailPage({
    required this.model,
    this.tileOptions = const FancyDioInspectorTileOptions(),
    this.l10nOptions = const FancyDioInspectorL10nOptions(),
    super.key,
    this.themeData,
  });
  final FancyDioInspectorTileOptions tileOptions;
  final FancyDioInspectorL10nOptions l10nOptions;
  final ThemeData? themeData;

  final NetworkBaseModel model;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData ?? context.currentTheme,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(l10nOptions.appBarText),
          // leading: leading,
          // actions: actions,
        ),
        body: HttpScopeItemWidget(model: model),
      ),
    );
  }
}

class HttpScopeItemWidget extends StatelessWidget {
  const HttpScopeItemWidget({
    required this.model,
    super.key,
  });

  final NetworkBaseModel model;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FancyDioTabViewItem(
        tileOptions: const FancyDioInspectorTileOptions(),
        l10nOptions: const FancyDioInspectorL10nOptions(),
        component: model,
      ),
    );
  }
}
