// Mocks generated by Mockito 5.1.0 from annotations
// in manga_time/test/unit_test/model/api/komik_api_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:manga_time/models/komik_model/komik_api/komik_api.dart' as _i2;
import 'package:manga_time/models/komik_model/komik_list_model.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [KomikApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockKomikApi extends _i1.Mock implements _i2.GetList {
  MockKomikApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.KomikListModel>> getKomikList({String? endpoint}) =>
      (super.noSuchMethod(
          Invocation.method(#getKomikList, [], {#endpoint: endpoint}),
          returnValue: Future<List<_i4.KomikListModel>>.value(
              <_i4.KomikListModel>[])) as _i3.Future<List<_i4.KomikListModel>>);
}
