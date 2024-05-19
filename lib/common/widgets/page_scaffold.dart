import 'package:flutter/material.dart';

class CommonPageScaffold extends StatelessWidget {
  const CommonPageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.automaticallyImplyLeading = true,
    this.centerTitle = false,
    this.withPadding = true,
    this.bottomNavigationBar,
    this.actions,
    this.leading,
  });

  final String title;
  final Widget child;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final bool withPadding;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: centerTitle,
        actions: actions,
        leading: leading,
      ),
      body: withPadding
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: child,
            )
          : child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
