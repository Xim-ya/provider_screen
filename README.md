<h1 align="center">Provider Screen</h1>
<p align="center"><img src="https://github.com/Xim-ya/Plotz/assets/75591730/5fa55b54-530d-4e53-ad4b-e85544512ce1"/></p>
<p align="center">
The Provider Screen package is a comprehensive screen module that simplifies the creation of screens in Flutter applications using the Provider state management solution. It provides an easy way to build screens with features like app bars, safe area handling, floating action buttons, and more. One of the notable benefits of this package is improved readability and simplified state management.




</p>

<p align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter"
      alt="Platform" />
  </a>
  <a href="">
    <img src="https://img.shields.io/pub/v/provider_screen"
      alt="Pub Package"/>
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/github/license/aagarwal1012/animated-text-kit?color=red"
      alt="License: MIT" />
  </a>


</p><br>



- [Usage](#usage)
- [Reading Value](#reading-value)
- [BaseViewModel](#baseviewmodel)
- [BaseScreen](#basescreen)
- [BaseView](#baseview--nestedview-)


# Key Features

* 🔑 Simplified screen creation with the BaseScreen class
* 🚀 Boost your productivity
* 📚 Enhance code readability
* 🛠 Easy customization for improved maintainability
* 💡 Convenient usage of context within the view model for better programming experience
* ⚙️ Effective management of the Provider's lifecycle for seamless integration



# Installing

To use the Easy Isolate Mixin package in your Flutter project, follow these steps:

1. Depend on it

Add the following line to your project's pubspec.yaml file under the dependencies section:

your `pubspec.yaml` file:

```yaml
dependencies:
  provider_screen: ^1.0.0
```

2. Install it

Run the following command in your terminal or command prompt:

```
$ flutter pub get
```

3. Import it

Add the following import statement to your Dart code:

```dart
import 'package:provider_screen/provider_screen.dart';
```

# Usage

1. Prepare `BaseViewModel`

```dart
class CustomViewModel with BaseViewModel {
  final String userName = 'James';
}
```

Create a BaseViewModel class that extends `ChangeNotifier`. This class will work as a controller for your screen. It provides methods like `notifyListeners()` to update your widget.

<br/>

2. Extend your screen with the `BaseScreen` class and provide a `BaseViewModel` as the type

```dart
class CustomScreen extends BaseScreen<CustomViewModel> {
  const CustomScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return PlaceHolder();
  }
}
```
Extend your screen widget with the `BaseScreen` class and provide the `BaseViewModel` type as a generic parameter. Override the `buildScreen` method to define the layout of your screen.

<br/>

3. Pass the ViewModel instance to the `createViewModel` method

```dart
class CustomScreen extends BaseScreen<CustomViewModel> {
  const CustomScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return PlaceHolder();
  }

  @override
  CustomViewModel createViewModel(BuildContext context) => CustomViewModel();
}
```

Override the `createViewModel` method and return an instance of your CustomViewModel class. This method is responsible for creating and providing the view model instance to the screen.

> [NOTE] <br/>
> If you are familiar with the `ChangeNotifierProvider` from the provider package, this step is similar to setting up the ChangeNotifierProvider with the specified view model. 




If you are using a `Service Locator` package like `get_it`, you can provide the view model instance as shown in the following code:

```dart
@override
CustomViewModel createViewModel(BuildContext context) => GetIt.I<CustomViewModel>();
```

<br/>

4. Access the ViewModel's properties and methods

You can access the properties and methods of the view model by using the `vm(context`) format as a reference. For example:

```dart
class CustomScreen extends BaseScreen<CustomViewModel> {
  const CustomScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(vm(contedxt).userName), // just call `vm(context).something`
    );
  }

  @override
  CustomViewModel createViewModel(BuildContext context) => CustomViewModel();
}
```

You can use the vm(context) method to access the view model's properties and methods without listening to changes. If you want to listen to changes, you can use `vmW(context)` instead. Additionally, there is a `vmS` method available to listen to only a specific part of the view model's data.

<br/>

5. Customize your screen by overriding the optional methods and properties provided by the BaseScreen class

```dart
class CustomScreen extends BaseScreen<CustomController> {
  const CustomScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    // Custom app bar implementation
    return AppBar(
      title: const Text('Custom Screen'),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    // Custom screen layout
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(vm(contedxt).userName),
    );
  }

  @override
  bool get setBottomSafeArea => false;

  @override
  Color? get screenBackgroundColor => Colors.white;
  
  
  @override
  CustomViewModel createViewModel(BuildContext context) => CustomViewModel();
  // Override other optional methods and properties as needed
}
```

<br/>

# Reading Value

In the Provider package, there are three `BuildContext extensions` for reading a value:

- `context.read<T>()`, which returns `T` without listening to it
- `context.watch<T>()`, which makes the widget listen to changes on `T`
- `context.select<T, R>(R cb(T value))`, which allows a widget to listen to only a small part of `T`.

In the Provider Screen package, there are shortened ways to access these features:

- `T vm(BuildContext context)`, which returns `T` without listening to it
- `T vmW(BuildContext context) ` which makes the widget listen to changes on `T`
- `S vmS<S>(BuildContext context, S Function(T) selector)` which allows a widget to listen to only a small part of `T`

### Example

Here is an example to compare the usage:

```dart
// Access data without listening to it
Text(context.read<CounterViewModel>().userName),
Text(vm(context).userName),

// Widget listens to changes on `T`
Text(context.watch<CounterViewModel>().userName),
Text(vmW(context).userName),

// Widget listens to only a small part of `T`
Text(context.select<CounterViewModel, String>((value) => value.userName)),
Text(vmS(context, (value) => value.userName)),
```
You can use these methods based on your preference and needs.



<br/>
        

# BaseViewModel
The `BaseViewModel` class extends `ChangeNotifier` and provides methods for updating the widget and managing the `lifecycle` of the view model. Here is an example usage:
```dart
class CounterViewModel with BaseViewModel {
  int count = 0;

  void increaseCount() {
    count++;
    notifyListeners();
  }

  // Other methods and properties
}
```
The BaseViewModel class includes a `notifyListeners()` method, which you can use to update your widget when the data changes. It also provides `onInit()` and `onDispose()` methods, which you can override to perform initialization and cleanup tasks respectively.

Here is an example of how you can use the BaseViewModel class:

```dart
class CounterViewModel with BaseViewModel {
  int count = 0;

  void increaseCount() {
    count++;
    notifyListeners();
  }

  @override
  void onInit() {
    super.onInit();
    // Perform initialization tasks here
  }

  @override
  void onDispose() {
    super.onDispose();
    // Perform cleanup tasks here
  }
}
```

In the example above, the `increaseCount()` method updates the count property and notifies the listeners. The `onInit()` method is called when the view model is initialized, and the `onDispose()` method is called when the view model is disposed of.

You can also access the screen's `context` in the view model. **This can make your programming experience much better**, especially when you need to show `dialogs` or `navigate` to other screens:


```dart
class CounterViewModel with BaseViewModel {
  int count = 0;

  void showAlertMessage() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('This is an alert message.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
```

In the example above, the `showAlertMessage()` method shows an alert dialog using the screen's context.

# BaseScreen

### AppBar

You can add an app bar to your screen by overriding the buildAppBar method.
<p align="center"><img width="260px" src="https://github.com/Xim-ya/Plotz/assets/75591730/1f521c23-44ff-48e9-9283-fe9342696837"/></p>

```dart
class CounterScreen extends BaseScreen<CounterViewModel> {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Counter App'),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return const Placeholder();
  }

  @override
  CounterViewModel createViewModel(BuildContext context) => CounterViewModel();
}
```

| Parameter   | Default | Description                   |
|:------------|:-------:|:------------------------------|
| buildAppBar |  null   | customizes the app bar widget |

<br/>

### SafeArea

To control the safe area behavior of your screen, you can override the following properties.

<p align="center"><img width="260px" src="https://github.com/Xim-ya/Plotz/assets/75591730/95017367-6a3a-47d1-be9e-776c2fb3349c"/></p>

```dart
class CounterScreen extends BaseScreen<CounterViewModel> {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  bool get setBottomSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Counter App'),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return const Placeholder();
  }

  @override
  CounterViewModel createViewModel(BuildContext context) => CounterViewModel();
} 
```

| Parameter         | Type | Default | Description                       |
|:------------------|:----:|:-------:|-----------------------------------|
| wrapWithSafeArea  | bool |  true   | wrap screen content with SafeArea |
| setTopSafeArea    | bool |  true   | consider top safe area.           |
| setBottomSafeArea | bool |  true   | consider bottom safe area.        |

<br/>

### Color

You can customize the screen's background color and unsafe area color by overriding the following properties
<p align="center"><img width="260px" src="https://github.com/Xim-ya/Plotz/assets/75591730/e09ee1cb-b57b-4947-9232-88335da0cff3"/></p>

```dart
class CounterScreen extends BaseScreen<CounterViewModel> {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  bool get setBottomSafeArea => false;

  @override
  Color? get screenBackgroundColor => Colors.green;

  @override
  Color? get unSafeAreaColor => Colors.amber;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Counter App'),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return const Placeholder();
  }

  @override
  CounterViewModel createViewModel(BuildContext context) => CounterViewModel();
}
```

To set a default color for `screenBackgroundColor` and `unSafeAreaColor` across your app, you can customize the theme in
your MaterialApp widget:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // customize it
        scaffoldBackgroundColor: Colors.white,
        unselectedWidgetColor: Colors.blue,
      ),
      title: 'Provider Screen',
      initialBinding: CounterBinding(),
      home: const CounterScreen(),
    );
  }
}
```

By modifying the theme's `scaffoldBackgroundColor` and `unselectedWidgetColor`, you can set the default colors for
screenBackgroundColor and unSafeAreaColor respectively.

| Parameter             |  Type  |                  Default                  | Description                             |
|:----------------------|:------:|:-----------------------------------------:|-----------------------------------------|
| screenBackgroundColor | Color? | Theme.of(context).scaffoldBackgroundColor | sets the background color of the screen |
| unSafeAreaColor       | Color? |  Theme.of(context).unselectedWidgetColor  | sets the color of the unsafe area.      |

<br/>

### Floating Action Button

Create the Floating Action Button widget in your screen.
<p align="center"><img width="260px" src="https://github.com/Xim-ya/Plotz/assets/75591730/a42b5dae-360b-462f-85d6-688c65fd2594"/></p>

```dart
class CounterScreen extends BaseScreen<CounterViewModel> {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  bool get setBottomSafeArea => false;

  @override
  Color? get screenBackgroundColor => Colors.green;

  @override
  Color? get unSafeAreaColor => Colors.amber;

  @override
  Widget? get buildFloatingActionButton =>
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          );

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation => FloatingActionButtonLocation.startFloat;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Counter App'),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return const Placeholder();
  }

  @override
  CounterViewModel createViewModel(BuildContext context) => CounterViewModel();
}
```

| Parameter                    |  Type   | Default | Description                                      |
|:-----------------------------|:-------:|:-------:|--------------------------------------------------|
| buildFloatingActionButton    | Widget? |  null   | customizes the floating action button widget     |
| floatingActionButtonLocation | Widget? |  null   | sets the position of the floating action button. |

<br/>

### Connect ViewModel Resources to View(BaseScreen)

You can access the properties and methods of the controller by using `vm(context)` format as a reference. In this
case, `vm` stands
for "view model," which is an abbreviation commonly used to refer to the associated view model `ChangeNotifier`

<p align="center"><img width="260px" src="https://github.com/Xim-ya/Plotz/assets/75591730/a7c17b16-6050-4495-b506-3097c79175fb"/></p>

```dart
class CounterViewModel extends BaseViewModel {
  int count = 0;

  void increaseCount() {
    count++;
    notifyListeners();
  }
}


class CounterScreen extends BaseScreen<CounterViewModel> {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return Center(
      child: Text(
        '${vmW(context).count}',
        style: Theme
                .of(context)
                .textTheme
                .headlineLarge,
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
  Widget? get buildFloatingActionButton =>
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
  CounterViewModel createViewModel(BuildContext context) => CounterViewModel();
}
```

<br/>

### Bottom Navigation Bar

Customize the bottom navigation bar widget in your screen.

<p align="center"><img width="260px" src="https://github.com/Xim-ya/Plotz/assets/75591730/779b5ebe-3e5f-449d-a763-9e0a7daeec04"/></p>

```dart
class CounterScreen extends BaseScreen<CounterViewModel> {
  const CounterScreen({Key? key}) : super(key: key);

  // Skipping previous code...

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
  Widget buildScreen(BuildContext context) {
    return Center(
      child: Text(
        '${vmW(context).count}',
        style: Theme
                .of(context)
                .textTheme
                .headlineLarge,
      ),
    );
  }
}
``` 

| Parameter                |  Type   | Default | Description                                  |
|:-------------------------|:-------:|:-------:|----------------------------------------------|
| buildBottomNavigationBar | Widget? |  null   | customizes the bottom navigation bar widget. |

<br/>

### Other Options

Additionally, there are other available options that can be overridden in your screen class

| Parameter                |       Type       | Default | Description                                             |
|:-------------------------|:----------------:|:-------:|---------------------------------------------------------|
| onWillPopCallback        | bool Function()? |  null   | handles the back button press or pop action             |
| resizeToAvoidBottomInset |       bool       |  true   | enables or disables screen resizing to avoid the bottom |
| extendBodyBehindAppBar   |       bool       |  false  | extends the body behind the app bar.                    |

<br/>

# BaseView (NestedView)

If you want to build a simple widget without creating a complete app screen based on `Scaffold` and separate the controller and screen layout, you can use `BaseView`. However, note that the BaseView widget needs to be nested within `BaseScreen`. You don't need to override the `createViewModel` method and pass a view model instance.

Here's an example usage:

```dart
class CounterScreen extends BaseScreen<CounterViewModel> {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return const Center(
      child: CounterIndicator(),
    );
  }

// Skipping previous code...
}


// Seperated class witch extends BaseView. 
class CounterIndicator extends BaseView<CounterViewModel> {
  const CounterIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${vmW(context).count}',
      style: Theme
          .of(context)
          .textTheme
          .headlineLarge,
    );
  }
}
```

The CustomIndicator widget extends BaseView<CustomViewModel> and overrides the buildView method to define the layout of the widget. Inside the buildView method, you can access the view model properties and methods using the vmW(context) format.






### If you are a Getx User ..
If you prefer using the GetX state management library, you can check out the <a href="https://pub.dev/packages/getx_screen">getx_screen</a> package. This package offers similar benefits to the `provider_screen` package but is designed specifically for GetX users.