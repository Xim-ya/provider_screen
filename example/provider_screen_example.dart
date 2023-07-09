import 'package:flutter/material.dart';
import 'package:provider_screen/provider_screen.dart';

// BaseScreen
class CounterScreen extends BaseScreen<CounterViewModel> {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Count'),
          CounterIndicator(),
        ],
      ),
    );
  }

  @override
  bool get setBottomSafeArea => false;

  @override
  Color? get screenBackgroundColor => Colors.green;

  @override
  Color? get unSafeAreaColor => Colors.amber;

  @override
  Widget? buildFloatingActionButton(BuildContext context) =>
      FloatingActionButton(
        onPressed: vm(context).increaseCount,
        child: const Icon(Icons.add),
      );

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.startFloat;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Counter App'),
    );
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(
        label: 'home',
        icon: Icon(Icons.home),
      ),
      BottomNavigationBarItem(
        label: 'user',
        icon: Icon(Icons.account_circle),
      )
    ]);
  }

  @override
  CounterViewModel createViewModel(BuildContext context) => CounterViewModel();
}

// BaseView
class CounterIndicator extends BaseView<CounterViewModel> {
  const CounterIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${vmW(context).count}',
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}

// BaseViewModel
class CounterViewModel extends BaseViewModel {
  int count = 0;

  void increaseCount() {
    count++;
    notifyListeners();
  }

  @override
  void onInit() {
    super.onInit();
    print("CounterViewModel Initialized");
  }

  @override
  void onDispose() {
    super.onDispose();
    print("CounterViewModel Disposed");
  }
}
