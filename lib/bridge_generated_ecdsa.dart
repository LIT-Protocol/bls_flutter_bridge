// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.82.3.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

import 'dart:ffi' as ffi;

abstract class Ecdsa {
  Future<String> combineSignature(
      {required List<String> inShares, required int keyType, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCombineSignatureConstMeta;

  Future<String> computePublicKey(
      {required String id, required List<String> publicKeys, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kComputePublicKeyConstMeta;
}

class EcdsaImpl implements Ecdsa {
  final EcdsaPlatform _platform;
  factory EcdsaImpl(ExternalLibrary dylib) =>
      EcdsaImpl.raw(EcdsaPlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory EcdsaImpl.wasm(FutureOr<WasmModule> module) =>
      EcdsaImpl(module as ExternalLibrary);
  EcdsaImpl.raw(this._platform);
  Future<String> combineSignature(
      {required List<String> inShares, required int keyType, dynamic hint}) {
    var arg0 = _platform.api2wire_StringList(inShares);
    var arg1 = api2wire_u8(keyType);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_combine_signature(port_, arg0, arg1),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_String,
      constMeta: kCombineSignatureConstMeta,
      argValues: [inShares, keyType],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCombineSignatureConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "combine_signature",
        argNames: ["inShares", "keyType"],
      );

  Future<String> computePublicKey(
      {required String id, required List<String> publicKeys, dynamic hint}) {
    var arg0 = _platform.api2wire_String(id);
    var arg1 = _platform.api2wire_StringList(publicKeys);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_compute_public_key(port_, arg0, arg1),
      parseSuccessData: _wire2api_String,
      parseErrorData: null,
      constMeta: kComputePublicKeyConstMeta,
      argValues: [id, publicKeys],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kComputePublicKeyConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "compute_public_key",
        argNames: ["id", "publicKeys"],
      );

  void dispose() {
    _platform.dispose();
  }
// Section: wire2api

  String _wire2api_String(dynamic raw) {
    return raw as String;
  }

  int _wire2api_u8(dynamic raw) {
    return raw as int;
  }

  Uint8List _wire2api_uint_8_list(dynamic raw) {
    return raw as Uint8List;
  }
}

// Section: api2wire

@protected
int api2wire_u8(int raw) {
  return raw;
}

// Section: finalizer

class EcdsaPlatform extends FlutterRustBridgeBase<EcdsaWire> {
  EcdsaPlatform(ffi.DynamicLibrary dylib) : super(EcdsaWire(dylib));

// Section: api2wire

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<wire_StringList> api2wire_StringList(List<String> raw) {
    final ans = inner.new_StringList_0(raw.length);
    for (var i = 0; i < raw.length; i++) {
      ans.ref.ptr[i] = api2wire_String(raw[i]);
    }
    return ans;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }
// Section: finalizer

// Section: api_fill_to_wire
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint

/// generated by flutter_rust_bridge
class EcdsaWire implements FlutterRustBridgeWireBase {
  @internal
  late final dartApi = DartApiDl(init_frb_dart_api_dl);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  EcdsaWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  EcdsaWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();

  Object get_dart_object(
    int ptr,
  ) {
    return _get_dart_object(
      ptr,
    );
  }

  late final _get_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Handle Function(ffi.UintPtr)>>(
          'get_dart_object');
  late final _get_dart_object =
      _get_dart_objectPtr.asFunction<Object Function(int)>();

  void drop_dart_object(
    int ptr,
  ) {
    return _drop_dart_object(
      ptr,
    );
  }

  late final _drop_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.UintPtr)>>(
          'drop_dart_object');
  late final _drop_dart_object =
      _drop_dart_objectPtr.asFunction<void Function(int)>();

  int new_dart_opaque(
    Object handle,
  ) {
    return _new_dart_opaque(
      handle,
    );
  }

  late final _new_dart_opaquePtr =
      _lookup<ffi.NativeFunction<ffi.UintPtr Function(ffi.Handle)>>(
          'new_dart_opaque');
  late final _new_dart_opaque =
      _new_dart_opaquePtr.asFunction<int Function(Object)>();

  int init_frb_dart_api_dl(
    ffi.Pointer<ffi.Void> obj,
  ) {
    return _init_frb_dart_api_dl(
      obj,
    );
  }

  late final _init_frb_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>(
          'init_frb_dart_api_dl');
  late final _init_frb_dart_api_dl = _init_frb_dart_api_dlPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  void wire_combine_signature(
    int port_,
    ffi.Pointer<wire_StringList> in_shares,
    int key_type,
  ) {
    return _wire_combine_signature(
      port_,
      in_shares,
      key_type,
    );
  }

  late final _wire_combine_signaturePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_StringList>,
              ffi.Uint8)>>('wire_combine_signature');
  late final _wire_combine_signature = _wire_combine_signaturePtr
      .asFunction<void Function(int, ffi.Pointer<wire_StringList>, int)>();

  void wire_compute_public_key(
    int port_,
    ffi.Pointer<wire_uint_8_list> id,
    ffi.Pointer<wire_StringList> public_keys,
  ) {
    return _wire_compute_public_key(
      port_,
      id,
      public_keys,
    );
  }

  late final _wire_compute_public_keyPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_StringList>)>>('wire_compute_public_key');
  late final _wire_compute_public_key = _wire_compute_public_keyPtr.asFunction<
      void Function(
          int, ffi.Pointer<wire_uint_8_list>, ffi.Pointer<wire_StringList>)>();

  ffi.Pointer<wire_StringList> new_StringList_0(
    int len,
  ) {
    return _new_StringList_0(
      len,
    );
  }

  late final _new_StringList_0Ptr = _lookup<
          ffi.NativeFunction<ffi.Pointer<wire_StringList> Function(ffi.Int32)>>(
      'new_StringList_0');
  late final _new_StringList_0 = _new_StringList_0Ptr
      .asFunction<ffi.Pointer<wire_StringList> Function(int)>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
          ffi
          .NativeFunction<ffi.Pointer<wire_uint_8_list> Function(ffi.Int32)>>(
      'new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void free_WireSyncReturn(
    WireSyncReturn ptr,
  ) {
    return _free_WireSyncReturn(
      ptr,
    );
  }

  late final _free_WireSyncReturnPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturn)>>(
          'free_WireSyncReturn');
  late final _free_WireSyncReturn =
      _free_WireSyncReturnPtr.asFunction<void Function(WireSyncReturn)>();

  void wire_platform(
    int port_,
  ) {
    return _wire_platform(
      port_,
    );
  }

  late final _wire_platformPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_platform');
  late final _wire_platform =
      _wire_platformPtr.asFunction<void Function(int)>();

  void wire_rust_release_mode(
    int port_,
  ) {
    return _wire_rust_release_mode(
      port_,
    );
  }

  late final _wire_rust_release_modePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_rust_release_mode');
  late final _wire_rust_release_mode =
      _wire_rust_release_modePtr.asFunction<void Function(int)>();
}

final class _Dart_Handle extends ffi.Opaque {}

final class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_StringList extends ffi.Struct {
  external ffi.Pointer<ffi.Pointer<wire_uint_8_list>> ptr;

  @ffi.Int32()
  external int len;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<
        ffi.Bool Function(DartPort port_id, ffi.Pointer<ffi.Void> message)>>;
typedef DartPort = ffi.Int64;