import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base_view_model.dart';

abstract class BaseScreen<T extends BaseViewModel> extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) {
        final vm = createViewModel(context);
        vm.initContext(context);
        return vm;
      },
      lazy: setLazyInit,
      builder: (BuildContext context, Widget? child) {
        // Wrap the screen with a WillPopScope widget if a back button callback is defined
        if (onWillPopCallback != null) {
          return WillPopScope(
            onWillPop: () async {
              if (onWillPopCallback != null) {
                return onWillPopCallback!();
              } else {
                return false;
              }
            },
            child: Container(
              color: unSafeAreaColor ?? Theme.of(context).unselectedWidgetColor,
              child: wrapWithSafeArea
                  ? SafeArea(
                      top: setTopSafeArea,
                      bottom: setBottomSafeArea,
                      child: _buildScaffold(context),
                    )
                  : _buildScaffold(context),
            ),
          );
        } else {
          return Container(
            color: unSafeAreaColor ?? Theme.of(context).unselectedWidgetColor,
            child: wrapWithSafeArea
                ? SafeArea(
                    top: setTopSafeArea,
                    bottom: setBottomSafeArea,
                    child: _buildScaffold(context),
                  )
                : _buildScaffold(context),
          );
        }
      },
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      extendBody: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: buildScreen(context),
      backgroundColor:
          screenBackgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  @protected
  bool Function()? get onWillPopCallback => null;

  @protected
  Color? get unSafeAreaColor => null;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  Widget? buildFloatingActionButton(BuildContext context) => null;

  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  @protected
  bool get extendBodyBehindAppBar => false;

  @protected
  bool get preventSwipeBack => false;

  @protected
  Color? get screenBackgroundColor => null;

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  @protected
  Widget buildScreen(BuildContext context);

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @protected
  bool get wrapWithSafeArea => true;

  @protected
  bool get setLazyInit => false;

  @protected
  bool get setBottomSafeArea => true;

  @protected
  bool get setTopSafeArea => true;

  @protected
  T vm(BuildContext context) => Provider.of<T>(context, listen: false);

  @protected
  T vmR(BuildContext context) => context.read<T>();

  @protected
  T vmW(BuildContext context) => context.watch<T>();

  @protected
  S vmS<S>(BuildContext context, S Function(T) selector) {
    return context.select((T value) => selector(value));
  }

  @protected
  T createViewModel(BuildContext context);
}
