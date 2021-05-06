import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart'
    show StatelessWidget, BuildContext, Widget;

class ProviderData<T> extends ChangeNotifier {
  ProviderData(this._data);

  T _data;

  T get value => _data;
}

class MutableProviderData<T> extends ProviderData<T> {
  MutableProviderData(data) : super(data);

  set value(T t) {
    _data = t;
    notifyListeners();
  }
}

typedef ProviderWidgetBuilder<T> = Widget Function(
    BuildContext context, T data);

typedef ProvidersWidgetBuilder<T, R> = Widget Function(
    BuildContext context, T dataT, R dataR);

class ProviderWidget<T> extends StatelessWidget {
  final ProviderData<T> _data;
  final ProviderWidgetBuilder<T> _builder;

  ProviderWidget(
      {required ProviderData<T> data, required ProviderWidgetBuilder<T> builder})
      : _data = data,
        _builder = builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderData<T>>.value(
      value: _data,
      child:
      Consumer<ProviderData<T>>(
          builder: (context, data, child) => _builder(context, data.value)),
    );
  }
}