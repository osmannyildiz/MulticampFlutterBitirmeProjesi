// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$queryAtom = Atom(name: '_HomeViewModelBase.query');

  @override
  String get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(String value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  final _$itemsAtom = Atom(name: '_HomeViewModelBase.items');

  @override
  List<RssItem> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(List<RssItem> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  final _$loadingAtom = Atom(name: '_HomeViewModelBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$filterAppliedAtom = Atom(name: '_HomeViewModelBase.filterApplied');

  @override
  bool get filterApplied {
    _$filterAppliedAtom.reportRead();
    return super.filterApplied;
  }

  @override
  set filterApplied(bool value) {
    _$filterAppliedAtom.reportWrite(value, super.filterApplied, () {
      super.filterApplied = value;
    });
  }

  final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase');

  @override
  void applyFilter() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.applyFilter');
    try {
      return super.applyFilter();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFilter() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.clearFilter');
    try {
      return super.clearFilter();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
query: ${query},
items: ${items},
loading: ${loading},
filterApplied: ${filterApplied}
    ''';
  }
}
