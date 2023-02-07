import 'dart:async';

import 'package:flower/flower.dart';
import 'package:flower/state_manager/src/controller/flower_state.dart';
// import 'package:fatima/state_manager/src/controller/fatima_state.dart';
import 'package:flutter/material.dart';

typedef ControllerBuilder<T extends LifeCycleMixin> = Widget Function(
    T controller);

typedef InitBuilder<T> = T Function();

class Updater<T extends Controller> extends StatelessWidget {
  final ControllerBuilder<T> builder;
  final bool global;
  final Object? id;
  final String? tag;
  final bool autoRemove;
  final bool assignId;
  final Object Function(T value)? filter;
  final void Function(BindElement<T> state)? initState,
      dispose,
      didChangeDependencies;
  final void Function(Binder<T> oldWidget, BindElement<T> state)?
      didUpdateWidget;
  final T? init;

  const Updater({
    Key? key,
    this.init,
    this.global = true,
    required this.builder,
    this.autoRemove = true,
    this.assignId = false,
    this.initState,
    this.filter,
    this.tag,
    this.dispose,
    this.id,
    this.didChangeDependencies,
    this.didUpdateWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Binder(
      init: init == null ? null : () => init!,
      global: global,
      autoRemove: autoRemove,
      assignId: assignId,
      initState: initState,
      filter: filter,
      tag: tag,
      dispose: dispose,
      id: id,
      lazy: false,
      didChangeDependencies: didChangeDependencies,
      didUpdateWidget: didUpdateWidget,
      child: Builder(builder: (context) {
        final controller = Bind.of<T>(context, rebuild: true);
        return builder(controller);
      }),
    );
    // return widget.builder(controller!);
  }
}

// // abstract class Bind<T> extends StatelessWidget {
// //   const Bind({
// //     Key? key,
// //     required this.child,
// //     this.init,
// //     this.global = true,
// //     this.autoRemove = true,
// //     this.assignId = false,
// //     this.initState,
// //     this.filter,
// //     this.tag,
// //     this.dispose,
// //     this.id,
// //     this.didChangeDependencies,
// //     this.didUpdateWidget,
// //   }) : super(key: key);

// //   final InitBuilder<T>? init;

// //   final bool global;
// //   final Object? id;
// //   final String? tag;
// //   final bool autoRemove;
// //   final bool assignId;
// //   final Object Function(T value)? filter;
// //   final void Function(BindElement<T> state)? initState,
// //       dispose,
// //       didChangeDependencies;
// //   final void Function(Binder<T> oldWidget, BindElement<T> state)?
// //       didUpdateWidget;

// //   final Widget? child;

// //   static Bind register<S>(
// //     S dependency, {
// //     String? tag,
// //     bool permanent = false,
// //   }) {
// //     Fatima.register<S>(dependency, tag: tag, permanent: permanent);
// //     return _FactoryBind<S>(
// //       autoRemove: permanent,
// //       assignId: true,
// //       tag: tag,
// //     );
// //   }

// //   static Bind lazyPut<S>(
// //     InstanceBuilderCallback<S> builder, {
// //     String? tag,
// //     bool fenix = true,
// //     // VoidCallback? onInit,
// //     VoidCallback? onClose,
// //   }) {
// //     Fatima.lazyPut<S>(builder, tag: tag, fenix: fenix);
// //     return _FactoryBind<S>(
// //       tag: tag,
// //       // initState: (_) {
// //       //   onInit?.call();
// //       // },
// //       dispose: (_) {
// //         onClose?.call();
// //       },
// //     );
// //   }

// //   static Bind create<S>(InstanceCreateBuilderCallback<S> builder,
// //       {String? tag, bool permanent = true}) {
// //     return _FactoryBind<S>(
// //       create: builder,
// //       tag: tag,
// //       global: false,
// //     );
// //   }

// //   static S find<S>({String? tag}) => Fatima.find<S>(tag: tag);

// //   static Future<bool> delete<S>({String? tag, bool force = false}) async =>
// //       Fatima.delete<S>(tag: tag, force: force);

// //   static Future<void> deleteAll({bool force = false}) async =>
// //       Fatima.deleteAll(force: force);

// //   static void reloadAll({bool force = false}) => Fatima.reloadAll(force: force);

// //   static void reload<S>({String? tag, String? key, bool force = false}) =>
// //       Fatima.reload<S>(tag: tag, key: key, force: force);

// //   static bool isRegistered<S>({String? tag}) =>
// //       Fatima.isRegistered<S>(tag: tag);

// //   static bool isPrepared<S>({String? tag}) => Fatima.isPrepared<S>(tag: tag);

// //   static void replace<P>(P child, {String? tag}) {
// //     final info = Fatima.getInstanceInfo<P>(tag: tag);
// //     final permanent = (info.isPermanent ?? false);
// //     delete<P>(tag: tag, force: permanent);
// //     Fatima.register(child, tag: tag, permanent: permanent);
// //   }

// //   static void lazyReplace<P>(InstanceBuilderCallback<P> builder,
// //       {String? tag, bool? fenix}) {
// //     final info = Fatima.getInstanceInfo<P>(tag: tag);
// //     final permanent = (info.isPermanent ?? false);
// //     delete<P>(tag: tag, force: permanent);
// //     Fatima.lazyPut(builder, tag: tag, fenix: fenix ?? permanent);
// //   }

// //   factory Bind.builder({
// //     Widget? child,
// //     InitBuilder<T>? init,
// //     InstanceCreateBuilderCallback<T>? create,
// //     bool global = true,
// //     bool autoRemove = true,
// //     bool assignId = false,
// //     Object Function(T value)? filter,
// //     String? tag,
// //     Object? id,
// //     void Function(BindElement<T> state)? initState,
// //     void Function(BindElement<T> state)? dispose,
// //     void Function(BindElement<T> state)? didChangeDependencies,
// //     void Function(Binder<T> oldWidget, BindElement<T> state)? didUpdateWidget,
// //   }) =>
// //       _FactoryBind<T>(
// //         // key: key,
// //         init: init,
// //         create: create,
// //         global: global,
// //         autoRemove: autoRemove,
// //         assignId: assignId,
// //         initState: initState,
// //         filter: filter,
// //         tag: tag,
// //         dispose: dispose,
// //         id: id,
// //         didChangeDependencies: didChangeDependencies,
// //         didUpdateWidget: didUpdateWidget,
// //         child: child,
// //       );

// //   static T of<T>(
// //     BuildContext context, {
// //     bool rebuild = false,
// //     // Object Function(T value)? filter,
// //   }) {
// //     final inheritedElement =
// //         context.getElementForInheritedWidgetOfExactType<Binder<T>>()
// //             as BindElement<T>?;

// //     if (inheritedElement == null) {
// //       throw BindError(controller: '$T', tag: null);
// //     }

// //     if (rebuild) {
// //       // var newFilter = filter?.call(inheritedElement.controller!);
// //       // if (newFilter != null) {
// //       //  context.dependOnInheritedElement(inheritedElement, aspect: newFilter);
// //       // } else {
// //       context.dependOnInheritedElement(inheritedElement);
// //       // }
// //     }

// //     final controller = inheritedElement.controller;

// //     return controller;
// //   }

// //   @factory
// //   Bind<T> _copyWithChild(Widget child);
// // }

// // class Binder<T> extends InheritedWidget {
// //   /// Create an inherited widget that updates its dependents when [controller]
// //   /// sends notifications.
// //   ///
// //   /// The [child] argument is required
// //   const Binder({
// //     Key? key,
// //     required Widget child,
// //     this.init,
// //     this.global = true,
// //     this.autoRemove = true,
// //     this.assignId = false,
// //     this.lazy = true,
// //     this.initState,
// //     this.filter,
// //     this.tag,
// //     this.dispose,
// //     this.id,
// //     this.didChangeDependencies,
// //     this.didUpdateWidget,
// //     this.create,
// //   }) : super(key: key, child: child);

// //   final InitBuilder<T>? init;
// //   final InstanceCreateBuilderCallback? create;
// //   final bool global;
// //   final Object? id;
// //   final String? tag;
// //   final bool lazy;
// //   final bool autoRemove;
// //   final bool assignId;
// //   final Object Function(T value)? filter;
// //   final void Function(BindElement<T> state)? initState,
// //       dispose,
// //       didChangeDependencies;
// //   final void Function(Binder<T> oldWidget, BindElement<T> state)?
// //       didUpdateWidget;

// //   @override
// //   bool updateShouldNotify(Binder<T> oldWidget) {
// //     return oldWidget.id != id ||
// //         oldWidget.global != global ||
// //         oldWidget.autoRemove != autoRemove ||
// //         oldWidget.assignId != assignId;
// //   }

// //   @override
// //   InheritedElement createElement() => BindElement<T>(this);
// // }

// // class BindElement<T> extends InheritedElement {
//   BindElement(Binder<T> widget) : super(widget) {
//     initState();
//   }

//   final disposers = <Disposer>[];

//   InitBuilder<T>? _controllerBuilder;

//   T? _controller;

//   T get controller {
//     if (_controller == null) {
//       _controller = _controllerBuilder?.call();
//       _subscribeToController();
//       if (_controller == null) {
//         throw BindError(controller: T, tag: widget.tag);
//       }
//       return _controller!;
//     } else {
//       return _controller!;
//     }
//   }

//   bool? _isCreator = false;
//   bool? _needStart = false;
//   bool _wasStarted = false;
//   VoidCallback? _remove;
//   Object? _filter;

//   void initState() {
//     widget.initState?.call(this);

//     var isRegistered = Fatima.isRegistered<T>(tag: widget.tag);

//     if (widget.global) {
//       if (isRegistered) {
//         if (Fatima.isPrepared<T>(tag: widget.tag)) {
//           _isCreator = true;
//         } else {
//           _isCreator = false;
//         }

//         _controllerBuilder = () => Fatima.find<T>(tag: widget.tag);
//       } else {
//         _controllerBuilder =
//             () => (widget.create?.call(this) ?? widget.init?.call());
//         _isCreator = true;
//         if (widget.lazy) {
//           Fatima.lazyPut<T>(_controllerBuilder!, tag: widget.tag);
//         } else {
//           Fatima.register<T>(_controllerBuilder!(), tag: widget.tag);
//         }
//       }
//     } else {
//       _controllerBuilder =
//           (widget.create != null ? () => widget.create!.call(this) : null) ??
//               widget.init;
//       _isCreator = true;
//       _needStart = true;
//     }
//   }

//   /// Register to listen Controller's events.
//   /// It gets a reference to the remove() callback, to delete the
//   /// setState "link" from the Controller.
//   void _subscribeToController() {
//     if (widget.filter != null) {
//       _filter = widget.filter!(_controller!);
//     }
//     final filter = _filter != null ? _filterUpdate : getUpdate;
//     final localController = _controller;

//     if (_needStart == true && localController is LifeCycleMixin) {
//       localController.onStart();
//       _needStart = false;
//       _wasStarted = true;
//     }

//     if (localController is Controller) {
//       _remove?.call();
//       _remove = (widget.id == null)
//           ? localController.addListener(filter)
//           : localController.addListenerId(widget.id, filter);
//     } else if (localController is Listenable) {
//       _remove?.call();
//       localController.addListener(filter);
//       _remove = () => localController.removeListener(filter);
//     } else if (localController is StreamController) {
//       _remove?.call();
//       final stream = localController.stream.listen((_) => filter());
//       _remove = () => stream.cancel();
//     }
//   }

//   void _filterUpdate() {
//     var newFilter = widget.filter!(_controller!);
//     if (newFilter != _filter) {
//       _filter = newFilter;
//       getUpdate();
//     }
//   }

//   void dispose() {
//     widget.dispose?.call(this);
//     if (_isCreator! || widget.assignId) {
//       if (widget.autoRemove && Fatima.isRegistered<T>(tag: widget.tag)) {
//         Fatima.delete<T>(tag: widget.tag);
//       }
//     }

//     for (final disposer in disposers) {
//       disposer();
//     }

//     disposers.clear();

//     _remove?.call();
//     _controller = null;
//     _isCreator = null;
//     _remove = null;
//     _filter = null;
//     _needStart = null;
//     _controllerBuilder = null;
//     _controller = null;
//   }

//   @override
//   Binder<T> get widget => super.widget as Binder<T>;

//   var _dirty = false;

//   @override
//   void update(Binder<T> newWidget) {
//     final oldNotifier = widget.id;
//     final newNotifier = newWidget.id;
//     if (oldNotifier != newNotifier && _wasStarted) {
//       _subscribeToController();
//     }
//     widget.didUpdateWidget?.call(widget, this);
//     super.update(newWidget);
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     widget.didChangeDependencies?.call(this);
//   }

//   @override
//   Widget build() {
//     if (_dirty) {
//       notifyClients(widget);
//     }
//     // return Notifier.instance.notifyAppend(
//     //   NotifyData(
//     //       disposers: disposers, updater: getUpdate, throwException: false),
//     return super.build();
//     //);
//   }

//   void getUpdate() {
//     _dirty = true;
//     markNeedsBuild();
//   }

//   @override
//   void notifyClients(Binder<T> oldWidget) {
//     super.notifyClients(oldWidget);
//     _dirty = false;
//   }

//   @override
//   void unmount() {
//     dispose();
//     super.unmount();
//   }
// }

// // class BindError<T> extends Error {
//   /// The type of the class the user tried to retrieve
//   final T controller;
//   final String? tag;

//   /// Creates a [BindError]
//   BindError({required this.controller, required this.tag});

//   @override
//   String toString() {
//     if (controller == 'dynamic') {
//       return '''Error: please specify type [<T>] when calling context.listen<T>() or context.find<T>() method.''';
//     }

//     return '''Error: No Bind<$controller>  ancestor found. To fix this, please add a Bind<$controller> widget ancestor to the current context.
//       ''';
//   }
// }

// // class _FactoryBind<T> extends Bind<T> {
//   @override
//   final InitBuilder<T>? init;

//   final InstanceCreateBuilderCallback<T>? create;

//   @override
//   final bool global;
//   @override
//   final Object? id;
//   @override
//   final String? tag;
//   @override
//   final bool autoRemove;
//   @override
//   final bool assignId;
//   @override
//   final Object Function(T value)? filter;

//   @override
//   final void Function(BindElement<T> state)? initState,
//       dispose,
//       didChangeDependencies;
//   @override
//   final void Function(Binder<T> oldWidget, BindElement<T> state)?
//       didUpdateWidget;

//   @override
//   final Widget? child;

//   const _FactoryBind({
//     Key? key,
//     this.child,
//     this.init,
//     this.create,
//     this.global = true,
//     this.autoRemove = true,
//     this.assignId = false,
//     this.initState,
//     this.filter,
//     this.tag,
//     this.dispose,
//     this.id,
//     this.didChangeDependencies,
//     this.didUpdateWidget,
//   }) : super(key: key, child: child);

//   @override
//   Bind<T> _copyWithChild(Widget child) {
//     return Bind<T>.builder(
//       init: init,
//       create: create,
//       global: global,
//       autoRemove: autoRemove,
//       assignId: assignId,
//       initState: initState,
//       filter: filter,
//       tag: tag,
//       dispose: dispose,
//       id: id,
//       didChangeDependencies: didChangeDependencies,
//       didUpdateWidget: didUpdateWidget,
//       child: child,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Binder<T>(
//       create: create,
//       global: global,
//       autoRemove: autoRemove,
//       assignId: assignId,
//       initState: initState,
//       filter: filter,
//       tag: tag,
//       dispose: dispose,
//       id: id,
//       didChangeDependencies: didChangeDependencies,
//       didUpdateWidget: didUpdateWidget,
//       child: child!,
//     );
//   }
// }
