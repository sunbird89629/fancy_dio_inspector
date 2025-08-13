import 'package:fancy_dio_inspector_personal/src/models/network/http_record.dart';
import 'package:fancy_dio_inspector_personal/src/theme/fancy_colors.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/curl_widget.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/error_body_widget.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/overview_widget.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/request_header_widget.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/response_body_widget.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/response_header_widget.dart';
import 'package:fancy_dio_inspector_personal/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class HttpDetailPage extends StatelessWidget {
  const HttpDetailPage({
    required this.model,
    super.key,
    this.themeData,
  });
  final ThemeData? themeData;

  final HttpRecord model;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData ?? context.currentTheme,
      child: Scaffold(
        backgroundColor: FancyColors.grey,
        appBar: AppBar(
          backgroundColor: model.statusColor,
          centerTitle: true,
          title: Text(model.requestOptions.uri.pathSegments.last),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: ColoredBox(
            color: const Color.fromARGB(255, 238, 235, 239),
            child: Column(
              spacing: 8,
              children: [
                OverviewWidget(model: model),
                _buildResultWidget(),
                CurlWidget(model: model),
                RequestHeaderWidget(model: model),
                ResponseHeaderWidget(model: model),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultWidget() {
    if (model.response != null) {
      return ResponseBodyWidget(model: model);
    } else if (model.dioException != null) {
      return ErrorBodyWidget(model: model);
    } else {
      return const SizedBox.shrink();
    }
  }
}
