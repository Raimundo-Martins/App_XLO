// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_adverts_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyAdvertsStore on _MyAdvertsStoreBase, Store {
  Computed<List<Adverts>> _$activeAdvertsComputed;

  @override
  List<Adverts> get activeAdverts => (_$activeAdvertsComputed ??=
          Computed<List<Adverts>>(() => super.activeAdverts,
              name: '_MyAdvertsStoreBase.activeAdverts'))
      .value;

  final _$allAdvertsAtom = Atom(name: '_MyAdvertsStoreBase.allAdverts');

  @override
  List<Adverts> get allAdverts {
    _$allAdvertsAtom.reportRead();
    return super.allAdverts;
  }

  @override
  set allAdverts(List<Adverts> value) {
    _$allAdvertsAtom.reportWrite(value, super.allAdverts, () {
      super.allAdverts = value;
    });
  }

  final _$loadingAtom = Atom(name: '_MyAdvertsStoreBase.loading');

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

  final _$soldAdvertAsyncAction = AsyncAction('_MyAdvertsStoreBase.soldAdvert');

  @override
  Future<void> soldAdvert(Adverts adverts) {
    return _$soldAdvertAsyncAction.run(() => super.soldAdvert(adverts));
  }

  final _$deleteAdvertAsyncAction =
      AsyncAction('_MyAdvertsStoreBase.deleteAdvert');

  @override
  Future<void> deleteAdvert(Adverts adverts) {
    return _$deleteAdvertAsyncAction.run(() => super.deleteAdvert(adverts));
  }

  @override
  String toString() {
    return '''
allAdverts: ${allAdverts},
loading: ${loading},
activeAdverts: ${activeAdverts}
    ''';
  }
}
