import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base_view_model.dart';

// Abstract base class for screen modules
abstract class BaseScreen<T extends BaseViewModel> extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  // Optional: Define a callback for the system back button press
  @protected
  bool Function()? get onWillPopCallback => null;

  // Optional: Color of the unsafe area (area behind system UI)
  @protected
  Color? get unSafeAreaColor => null;

  // Whether to resize the screen to avoid the bottom system inset (e.g., keyboard)
  @protected
  bool get resizeToAvoidBottomInset => true;

  // Optional: Build the floating action button
  @protected
  Widget? buildFloatingActionButton(BuildContext context) => null;

  // Optional: Define the floating action button location
  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  // Whether to extend the body behind the app bar
  @protected
  bool get extendBodyBehindAppBar => false;

  // Optional: Color of the screen background
  @protected
  Color? get screenBackgroundColor => null;

  // Optional: Build the bottom navigation bar
  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  // Build the screen content
  @protected
  Widget buildScreen(BuildContext context);

  // Optional: Build the app bar
  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  // Whether to wrap the screen with a SafeArea widget
  @protected
  bool get wrapWithSafeArea => true;

  // Whether to set the bottom area as a safe area
  @protected
  bool get setBottomSafeArea => true;

  // Whether to set the top area as a safe area
  @protected
  bool get setTopSafeArea => true;

  // Determines whether to lazily initialize the view model
  @protected
  bool get setLazyInit => false;

  // Access the view model instance using the vm() getter
  @protected
  T vm(BuildContext context) => Provider.of<T>(context, listen: false);

  // Access the view model instance using the vmW() getter for listening to changes
  @protected
  T vmW(BuildContext context) => context.watch<T>();

  // Access a specific part of the view model's data using the vmS() method
  @protected
  S vmS<S>(BuildContext context, S Function(T) selector) {
    return context.select((T value) => selector(value));
  }

  // Access the view model instance using the vmR() getter for reading without listening
  @protected
  T vmR(BuildContext context) => context.read<T>();

  // Create and return an instance of the view model
  @protected
  T createViewModel(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // Create a ChangeNotifierProvider with the specified view model
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
              return onWillPopCallback!();
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

  // Build the main scaffold widget
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
}
