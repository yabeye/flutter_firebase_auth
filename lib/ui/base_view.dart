import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/locator.dart';
import 'package:flutter_firebase_auth/model/base.model.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;

  const BaseView({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      // builder: (context) => model,
      // child: Consumer<T>(builder: widget.builder),
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
      // notifier: model,
    );
  }
}
