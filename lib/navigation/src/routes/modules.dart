import 'package:flower/flower.dart';
import 'package:flutter/material.dart';

// import '../../../instance_manager.dart';
import '../router_report.dart';

class Dependencies {
  void lazyPut<S>(InstanceBuilderCallback<S> builder,
      {String? tag, bool fenix = false}) {
    Flower.lazyRegister<S>(builder, tag: tag, fenix: fenix);
  }

  S call<S>() {
    return find<S>();
  }

  void create<S>(InstanceBuilderCallback<S> builder,
          {String? tag, bool permanent = true}) =>
      Flower.create<S>(builder, tag: tag, permanent: permanent);

  S find<S>({String? tag}) => Flower.find<S>(tag: tag);

  S put<S>(S dependency,
          {String? tag,
          bool permanent = false,
          InstanceBuilderCallback<S>? builder}) =>
      Flower.register<S>(dependency, tag: tag, permanent: permanent);

  Future<bool> delete<S>({String? tag, bool force = false}) async =>
      Flower.delete<S>(tag: tag, force: force);

  Future<void> deleteAll({bool force = false}) async =>
      Flower.deleteAll(force: force);

  void reloadAll({bool force = false}) => Flower.reloadAll(force: force);

  void reload<S>({String? tag, String? key, bool force = false}) =>
      Flower.reload<S>(tag: tag, key: key, force: force);

  bool isRegistered<S>({String? tag}) => Flower.isRegistered<S>(tag: tag);

  bool isPrepared<S>({String? tag}) => Flower.isPrepared<S>(tag: tag);

  void replace<P>(P child, {String? tag}) {
    final info = Flower.getInstanceInfo<P>(tag: tag);
    final permanent = (info.isPermanent ?? false);
    delete<P>(tag: tag, force: permanent);
    put(child, tag: tag, permanent: permanent);
  }

  void lazyReplace<P>(InstanceBuilderCallback<P> builder,
      {String? tag, bool? fenix}) {
    final info = Flower.getInstanceInfo<P>(tag: tag);
    final permanent = (info.isPermanent ?? false);
    delete<P>(tag: tag, force: permanent);
    lazyPut(builder, tag: tag, fenix: fenix ?? permanent);
  }
}

abstract class Module extends StatefulWidget {
  Module({Key? key}) : super(key: key);

  Widget view(BuildContext context);

  void dependencies(Dependencies i);

  @override
  _ModuleState createState() => _ModuleState();
}

class _ModuleState extends State<Module> {
  @override
  void initState() {
    RouterReportManager.instance.reportCurrentRoute(this);
    widget.dependencies(Dependencies());
    super.initState();
  }

  @override
  void dispose() {
    RouterReportManager.instance.reportRouteDispose(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.view(context);
  }
}
