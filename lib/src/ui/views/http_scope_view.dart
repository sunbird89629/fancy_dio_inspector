import 'package:fancy_dio_inspector_personal/src/loggers/fancy_dio_logger.dart';
import 'package:fancy_dio_inspector_personal/src/providers/main_data_provider.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/http_record_item_widget.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/title_bar_action_widget.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/widgets.dart';
import 'package:fancy_dio_inspector_personal/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

final mainDataProvider = MainDataProvider(
  httpRecords: FancyDioLogger.instance.records,
);

class HttpScopeView extends StatelessWidget {
  /// The options for the dio tiles.
  /// If this is `null`, the default options will be used.
  // final FancyDioInspectorTileOptions tileOptions;

  /// The options for the UI localization.
  /// If any of the value is `null`, the default value will be used.
  // final FancyDioInspectorL10nOptions l10nOptions;

  /// [leading] is used to place a widget before the title.
  final Widget? leading;

  /// [actions] are used to place widgets after the title.
  final List<Widget>? actions;

  /// The theme data for the view. If this is `null`, `FancyThemeData` will be
  /// used.
  final ThemeData? themeData;

  final FancyItemCustomButtonBuilder? customButtonBuilder;

  const HttpScopeView({
    this.leading,
    this.actions,
    this.themeData,
    super.key,
    this.customButtonBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData ?? context.currentTheme,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ListenableBuilder(
            listenable: mainDataProvider,
            builder: (context, child) {
              return Text(
                'HttpRecords( ${mainDataProvider.httpRecords.length} )',
              );
            },
          ),
          // bottom: TabBar(tabs: tabs),
          leading: leading,
          actions: [
            TitleBarActionWidget(
              iconData: Icons.tune,
              onPressed: () {},
            ),
            TitleBarActionWidget(
              iconData: Icons.clear_all,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('请长按以清空历史记录'),
                    duration: Duration(seconds: 3),
                  ),
                );
                // ScaffoldMessenger.of(context).showMaterialBanner(
                //   const MaterialBanner(
                //     content: Text('为防止误触，请长按以删除历史记录'),
                //     actions: [
                //       SizedBox.shrink(),
                //     ],
                //   ),
                // );
              },
              onLongPress: () {
                FancyDioLogger.instance.records.clear();
                mainDataProvider.httpRecords = FancyDioLogger.instance.records;
              },
            ),
          ],
        ),
        // body: TabBarView(children: tabBarViews),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ListenableBuilder(
      listenable: mainDataProvider,
      builder: (context, child) {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            height: 3,
            thickness: 1,
            color: Color.fromARGB(255, 238, 235, 239),
            indent: 30,
            endIndent: 20,
          ),
          itemCount: mainDataProvider.httpRecords.length,
          itemBuilder: (context, index) {
            final model = mainDataProvider.httpRecords[index];
            return HttpRecordItemWidget(model: model);
          },
        );
      },
    );
    // return ValueListenableBuilder<List<HttpRecord>>(
    //   valueListenable: httpRecords,
    //   builder: (
    //     context,
    //     value,
    //     child,
    //   ) {
    //     return ListView.separated(
    //       separatorBuilder: (context, index) => const Divider(
    //         height: 3,
    //         thickness: 1,
    //         color: Color.fromARGB(255, 238, 235, 239),
    //         indent: 20,
    //         endIndent: 12,
    //       ),
    //       itemCount: value.length,
    //       itemBuilder: (context, index) {
    //         final model = value[index];
    //         return HttpRecordItemWidget(model: model);
    //       },
    //     );
    //   },
    // );
  }
}
