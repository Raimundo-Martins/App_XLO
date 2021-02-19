// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpStore on _SignUpStoreBase, Store {
  Computed<bool> _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_SignUpStoreBase.nameValid'))
          .value;
  Computed<bool> _$emailValidComputed;

  @override
  bool get emailValid =>
      (_$emailValidComputed ??= Computed<bool>(() => super.emailValid,
              name: '_SignUpStoreBase.emailValid'))
          .value;
  Computed<bool> _$phoneValidComputed;

  @override
  bool get phoneValid =>
      (_$phoneValidComputed ??= Computed<bool>(() => super.phoneValid,
              name: '_SignUpStoreBase.phoneValid'))
          .value;
  Computed<bool> _$senha1ValidComputed;

  @override
  bool get senha1Valid =>
      (_$senha1ValidComputed ??= Computed<bool>(() => super.senha1Valid,
              name: '_SignUpStoreBase.senha1Valid'))
          .value;
  Computed<bool> _$senha2ValidComputed;

  @override
  bool get senha2Valid =>
      (_$senha2ValidComputed ??= Computed<bool>(() => super.senha2Valid,
              name: '_SignUpStoreBase.senha2Valid'))
          .value;
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_SignUpStoreBase.isFormValid'))
          .value;
  Computed<Function> _$signUpPressedComputed;

  @override
  Function get signUpPressed =>
      (_$signUpPressedComputed ??= Computed<Function>(() => super.signUpPressed,
              name: '_SignUpStoreBase.signUpPressed'))
          .value;

  final _$nameAtom = Atom(name: '_SignUpStoreBase.name');

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

  final _$emailAtom = Atom(name: '_SignUpStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$phoneAtom = Atom(name: '_SignUpStoreBase.phone');

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

  final _$senha1Atom = Atom(name: '_SignUpStoreBase.senha1');

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

  final _$senha2Atom = Atom(name: '_SignUpStoreBase.senha2');

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

  final _$loadingAtom = Atom(name: '_SignUpStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_SignUpStoreBase.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$_signUpAsyncAction = AsyncAction('_SignUpStoreBase._signUp');

  @override
  Future<void> _signUp() {
    return _$_signUpAsyncAction.run(() => super._signUp());
  }

  final _$_SignUpStoreBaseActionController =
      ActionController(name: '_SignUpStoreBase');

  @override
  void setNome(String value) {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.setNome');
    try {
      return super.setNome(value);
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSenha1(String value) {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.setSenha1');
    try {
      return super.setSenha1(value);
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSenha2(String value) {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.setSenha2');
    try {
      return super.setSenha2(value);
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
phone: ${phone},
senha1: ${senha1},
senha2: ${senha2},
loading: ${loading},
error: ${error},
nameValid: ${nameValid},
emailValid: ${emailValid},
phoneValid: ${phoneValid},
senha1Valid: ${senha1Valid},
senha2Valid: ${senha2Valid},
isFormValid: ${isFormValid},
signUpPressed: ${signUpPressed}
    ''';
  }
}
