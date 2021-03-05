// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditAccountStore on _EditAccountStoreBase, Store {
  Computed<bool> _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_EditAccountStoreBase.nameValid'))
          .value;
  Computed<bool> _$phoneValidComputed;

  @override
  bool get phoneValid =>
      (_$phoneValidComputed ??= Computed<bool>(() => super.phoneValid,
              name: '_EditAccountStoreBase.phoneValid'))
          .value;
  Computed<bool> _$senhaValidComputed;

  @override
  bool get senhaValid =>
      (_$senhaValidComputed ??= Computed<bool>(() => super.senhaValid,
              name: '_EditAccountStoreBase.senhaValid'))
          .value;
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_EditAccountStoreBase.isFormValid'))
          .value;
  Computed<VoidCallback> _$savePressedComputed;

  @override
  VoidCallback get savePressed =>
      (_$savePressedComputed ??= Computed<VoidCallback>(() => super.savePressed,
              name: '_EditAccountStoreBase.savePressed'))
          .value;

  final _$userTypeAtom = Atom(name: '_EditAccountStoreBase.userType');

  @override
  UserType get userType {
    _$userTypeAtom.reportRead();
    return super.userType;
  }

  @override
  set userType(UserType value) {
    _$userTypeAtom.reportWrite(value, super.userType, () {
      super.userType = value;
    });
  }

  final _$nameAtom = Atom(name: '_EditAccountStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$phoneAtom = Atom(name: '_EditAccountStoreBase.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$senha1Atom = Atom(name: '_EditAccountStoreBase.senha1');

  @override
  String get senha1 {
    _$senha1Atom.reportRead();
    return super.senha1;
  }

  @override
  set senha1(String value) {
    _$senha1Atom.reportWrite(value, super.senha1, () {
      super.senha1 = value;
    });
  }

  final _$senha2Atom = Atom(name: '_EditAccountStoreBase.senha2');

  @override
  String get senha2 {
    _$senha2Atom.reportRead();
    return super.senha2;
  }

  @override
  set senha2(String value) {
    _$senha2Atom.reportWrite(value, super.senha2, () {
      super.senha2 = value;
    });
  }

  final _$loadingAtom = Atom(name: '_EditAccountStoreBase.loading');

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

  final _$_saveAsyncAction = AsyncAction('_EditAccountStoreBase._save');

  @override
  Future<void> _save() {
    return _$_saveAsyncAction.run(() => super._save());
  }

  final _$_EditAccountStoreBaseActionController =
      ActionController(name: '_EditAccountStoreBase');

  @override
  void setUserType(int value) {
    final _$actionInfo = _$_EditAccountStoreBaseActionController.startAction(
        name: '_EditAccountStoreBase.setUserType');
    try {
      return super.setUserType(value);
    } finally {
      _$_EditAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo = _$_EditAccountStoreBaseActionController.startAction(
        name: '_EditAccountStoreBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_EditAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo = _$_EditAccountStoreBaseActionController.startAction(
        name: '_EditAccountStoreBase.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_EditAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSenha1(String value) {
    final _$actionInfo = _$_EditAccountStoreBaseActionController.startAction(
        name: '_EditAccountStoreBase.setSenha1');
    try {
      return super.setSenha1(value);
    } finally {
      _$_EditAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSenha2(String value) {
    final _$actionInfo = _$_EditAccountStoreBaseActionController.startAction(
        name: '_EditAccountStoreBase.setSenha2');
    try {
      return super.setSenha2(value);
    } finally {
      _$_EditAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userType: ${userType},
name: ${name},
phone: ${phone},
senha1: ${senha1},
senha2: ${senha2},
loading: ${loading},
nameValid: ${nameValid},
phoneValid: ${phoneValid},
senhaValid: ${senhaValid},
isFormValid: ${isFormValid},
savePressed: ${savePressed}
    ''';
  }
}
