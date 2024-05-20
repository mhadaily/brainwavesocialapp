import 'package:flutter/material.dart';

class CommonPageScaffold extends StatelessWidget {
  const CommonPageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.automaticallyImplyLeading = true,
    this.centerTitle = true,
    this.withPadding = true,
    this.bottomNavigationBar,
    this.actions,
    this.leading,
  });

  final String title;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final bool withPadding;
  final Widget child;
  final Widget? leading;
  final List<Widget>? actions;
  final BottomNavigationBar? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        leading: leading,
        centerTitle: centerTitle,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: Text(title),
        actions: actions,
      ),
      body: SafeArea(
        child: withPadding
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: child,
              )
            : child,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
