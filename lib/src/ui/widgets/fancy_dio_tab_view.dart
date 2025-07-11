import 'package:fancy_dio_inspector_personal/src/models/models.dart';
import 'package:fancy_dio_inspector_personal/src/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FancyDioTabView<T extends NetworkBaseModel> extends StatefulWidget {
  final FancyDioInspectorTileOptions tileOptions;
  final FancyDioInspectorL10nOptions l10nOptions;
  final List<T> components;
  final FancyItemCustomButtonBuilder? customButtonBuilder;

  const FancyDioTabView({
    required this.tileOptions,
    required this.l10nOptions,
    required this.components,
    super.key,
    this.customButtonBuilder,
  });

  @override
  State<FancyDioTabView<T>> createState() => _FancyDioTabViewState<T>();
}

class _FancyDioTabViewState<T extends NetworkBaseModel>
    extends State<FancyDioTabView<T>> {
  String searchText = '';

  List<T> get filteredComponents {
    if (searchText.isEmpty) {
      return widget.components;
    }

    return widget.components
        .where((component) => component.contains(searchText))
        .toList();
  }

  void _onSearchChanged(String newValue) {
    setState(() {
      searchText = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.tileOptions.showSearch) ...[
          Padding(
            padding: const EdgeInsets.all(16),
            child: FancySearchField(
              hintText: widget.l10nOptions.searchHintText,
              onChanged: _onSearchChanged,
            ),
          ),
          const Divider(height: 1),
        ],
        Expanded(
          child: ListView.separated(
            itemCount: filteredComponents.length,
            separatorBuilder: (context, index) => const Divider(height: 8),
            itemBuilder: (context, index) {
              final filteredComponent = filteredComponents[index];

              return Padding(
                padding: const EdgeInsets.all(16),
                child: FancyDioTabViewItem(
                  component: filteredComponent,
                  l10nOptions: widget.l10nOptions,
                  tileOptions: widget.tileOptions,
                  customButtonBuilder: widget.customButtonBuilder,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
