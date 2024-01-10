import 'package:divido/presentation/widgets/bottom_app_bar.widget.dart';
import 'package:divido/presentation/widgets/floating_action_button.widget.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget? bottomAppBar;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final Widget body;
  const DefaultScaffold({
    super.key,
    this.bottomAppBar = const CustomBottomAppBar(),
    this.floatingActionButton = const CustomFloatingActionButton(),
    this.appBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomAppBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: body,
    );
  }
}
