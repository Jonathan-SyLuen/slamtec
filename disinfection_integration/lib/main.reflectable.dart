// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
// @dart = 2.12

import 'dart:core';
import 'package:dart_json_mapper/src/model/annotations.dart' as prefix0;
import 'package:disinfection_integration/dataRep.dart' as prefix1;

// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const
// ignore_for_file: implementation_imports

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.JsonSerializable(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'KnownArea',
            r'.KnownArea',
            7,
            0,
            const prefix0.JsonSerializable(),
            const <int>[0, 1, 2, 3, 4, 5, 35],
            const <int>[
              36,
              37,
              38,
              39,
              40,
              23,
              24,
              25,
              26,
              27,
              28,
              29,
              30,
              31,
              32,
              33,
              34
            ],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (bool b) => (maxX, maxY, minX, minY) =>
                  b ? prefix1.KnownArea(maxX, maxY, minX, minY) : null
            },
            -1,
            0,
            const <int>[],
            const <Object>[
              prefix0.jsonSerializable,
              const prefix0.Json(name: 'result')
            ],
            null),
        r.NonGenericClassMirrorImpl(
            r'MapData',
            r'.MapData',
            7,
            1,
            const prefix0.JsonSerializable(),
            const <int>[6, 7, 8, 9, 10, 11, 12, 13, 14, 59],
            const <int>[
              36,
              37,
              38,
              39,
              40,
              41,
              42,
              43,
              44,
              45,
              46,
              47,
              48,
              49,
              50,
              51,
              52,
              53,
              54,
              55,
              56,
              57,
              58
            ],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (bool b) => (dimensionX, dimensionY, mapData, realX, realY,
                      resolution, size, timestamp, type) =>
                  b
                      ? prefix1.MapData(dimensionX, dimensionY, mapData, realX,
                          realY, resolution, size, timestamp, type)
                      : null
            },
            -1,
            1,
            const <int>[],
            const <Object>[
              prefix0.jsonSerializable,
              const prefix0.Json(name: 'result/')
            ],
            null),
        r.NonGenericClassMirrorImpl(
            r'VirtualWall',
            r'.VirtualWall',
            7,
            2,
            const prefix0.JsonSerializable(),
            const <int>[15, 16, 17, 66],
            const <int>[36, 37, 38, 39, 40, 60, 61, 62, 63, 64, 65],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (bool b) => (code, lines, timestamp) =>
                  b ? prefix1.VirtualWall(code, lines, timestamp) : null
            },
            -1,
            2,
            const <int>[],
            const <Object>[
              prefix0.jsonSerializable,
              const prefix0.Json(name: 'result')
            ],
            null),
        r.NonGenericClassMirrorImpl(
            r'RobotPose',
            r'.RobotPose',
            7,
            3,
            const prefix0.JsonSerializable(),
            const <int>[18, 19, 20, 73],
            const <int>[36, 37, 38, 39, 40, 67, 68, 69, 70, 71, 72],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (bool b) =>
                  (x, y, yaw) => b ? prefix1.RobotPose(x, y, yaw) : null
            },
            -1,
            3,
            const <int>[],
            const <Object>[
              prefix0.jsonSerializable,
              const prefix0.Json(name: 'result')
            ],
            null),
        r.NonGenericClassMirrorImpl(
            r'ActionStatus',
            r'.ActionStatus',
            7,
            4,
            const prefix0.JsonSerializable(),
            const <int>[21, 76],
            const <int>[36, 37, 38, 39, 40, 74, 75],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (bool b) =>
                  (status) => b ? prefix1.ActionStatus(status) : null
            },
            -1,
            4,
            const <int>[],
            const <Object>[
              prefix0.jsonSerializable,
              const prefix0.Json(name: 'result')
            ],
            null),
        r.NonGenericClassMirrorImpl(
            r'ActionID',
            r'.ActionID',
            7,
            5,
            const prefix0.JsonSerializable(),
            const <int>[22, 79],
            const <int>[36, 37, 38, 39, 40, 77, 78],
            const <int>[],
            -1,
            {},
            {},
            {r'': (bool b) => (id) => b ? prefix1.ActionID(id) : null},
            -1,
            5,
            const <int>[],
            const <Object>[
              prefix0.jsonSerializable,
              const prefix0.Json(name: 'result')
            ],
            null)
      ],
      <m.DeclarationMirror>[
        r.VariableMirrorImpl(
            r'maxX',
            32773,
            0,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'max_x')]),
        r.VariableMirrorImpl(
            r'maxY',
            32773,
            0,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'max_y')]),
        r.VariableMirrorImpl(
            r'minX',
            32773,
            0,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'min_x')]),
        r.VariableMirrorImpl(
            r'minY',
            32773,
            0,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'min_y')]),
        r.VariableMirrorImpl(
            r'height',
            33797,
            0,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6, const <int>[], const []),
        r.VariableMirrorImpl(
            r'width',
            33797,
            0,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6, const <int>[], const []),
        r.VariableMirrorImpl(
            r'dimensionX',
            32773,
            1,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'dimension_x')]),
        r.VariableMirrorImpl(
            r'dimensionY',
            32773,
            1,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'dimension_y')]),
        r.VariableMirrorImpl(
            r'mapData',
            32773,
            1,
            const prefix0.JsonSerializable(),
            -1,
            8,
            8,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'map_data')]),
        r.VariableMirrorImpl(
            r'realX',
            32773,
            1,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'real_x')]),
        r.VariableMirrorImpl(
            r'realY',
            32773,
            1,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'real_y')]),
        r.VariableMirrorImpl(
            r'resolution',
            32773,
            1,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'resolution')]),
        r.VariableMirrorImpl(
            r'size',
            32773,
            1,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'size')]),
        r.VariableMirrorImpl(
            r'timestamp',
            32773,
            1,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'timestamp')]),
        r.VariableMirrorImpl(
            r'type',
            32773,
            1,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'type')]),
        r.VariableMirrorImpl(
            r'code',
            32773,
            2,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'code')]),
        r.VariableMirrorImpl(
            r'lines',
            32773,
            2,
            const prefix0.JsonSerializable(),
            -1,
            8,
            8,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'lines')]),
        r.VariableMirrorImpl(
            r'timestamp',
            32773,
            2,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'timestamp')]),
        r.VariableMirrorImpl(
            r'x',
            32773,
            3,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'x')]),
        r.VariableMirrorImpl(
            r'y',
            32773,
            3,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'y')]),
        r.VariableMirrorImpl(
            r'yaw',
            32773,
            3,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'yaw')]),
        r.VariableMirrorImpl(
            r'status',
            32773,
            4,
            const prefix0.JsonSerializable(),
            -1,
            8,
            8,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'codestr')]),
        r.VariableMirrorImpl(
            r'id',
            32773,
            5,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const <Object>[const prefix0.JsonProperty(name: 'id')]),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 0, 23),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 0, 24),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 1, 25),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 1, 26),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 2, 27),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 2, 28),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 3, 29),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 3, 30),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 4, 31),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 4, 32),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 5, 33),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 5, 34),
        r.MethodMirrorImpl(
            r'',
            0,
            0,
            -1,
            0,
            0,
            const <int>[],
            const <int>[0, 1, 2, 3],
            const prefix0.JsonSerializable(),
            const []),
        r.MethodMirrorImpl(r'==', 131074, -1, -1, 9, 9, const <int>[],
            const <int>[10], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(r'toString', 131074, -1, -1, 8, 8, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(
            r'noSuchMethod',
            65538,
            -1,
            -1,
            -1,
            -1,
            const <int>[],
            const <int>[11],
            const prefix0.JsonSerializable(),
            const []),
        r.MethodMirrorImpl(r'hashCode', 131075, -1, -1, 7, 7, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(
            r'runtimeType',
            131075,
            -1,
            -1,
            10,
            10,
            const <int>[],
            const <int>[],
            const prefix0.JsonSerializable(),
            const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 6, 41),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 6, 42),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 7, 43),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 7, 44),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 8, 45),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 8, 46),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 9, 47),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 9, 48),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 10, 49),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 10, 50),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 11, 51),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 11, 52),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 12, 53),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 12, 54),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 13, 55),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 13, 56),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 14, 57),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 14, 58),
        r.MethodMirrorImpl(
            r'',
            0,
            1,
            -1,
            1,
            1,
            const <int>[],
            const <int>[12, 13, 14, 15, 16, 17, 18, 19, 20],
            const prefix0.JsonSerializable(),
            const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 15, 60),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 15, 61),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 16, 62),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 16, 63),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 17, 64),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 17, 65),
        r.MethodMirrorImpl(
            r'',
            0,
            2,
            -1,
            2,
            2,
            const <int>[],
            const <int>[30, 31, 32],
            const prefix0.JsonSerializable(),
            const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 18, 67),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 18, 68),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 19, 69),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 19, 70),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 20, 71),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 20, 72),
        r.MethodMirrorImpl(
            r'',
            0,
            3,
            -1,
            3,
            3,
            const <int>[],
            const <int>[36, 37, 38],
            const prefix0.JsonSerializable(),
            const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 21, 74),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 21, 75),
        r.MethodMirrorImpl(r'', 0, 4, -1, 4, 4, const <int>[], const <int>[42],
            const prefix0.JsonSerializable(), const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 22, 77),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 22, 78),
        r.MethodMirrorImpl(r'', 0, 5, -1, 5, 5, const <int>[], const <int>[44],
            const prefix0.JsonSerializable(), const [])
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(
            r'maxX',
            33798,
            35,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'maxY',
            33798,
            35,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'minX',
            33798,
            35,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'minY',
            33798,
            35,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_maxX',
            32870,
            24,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_maxY',
            32870,
            26,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_minX',
            32870,
            28,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_minY',
            32870,
            30,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_height',
            32870,
            32,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_width',
            32870,
            34,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'other',
            32774,
            36,
            const prefix0.JsonSerializable(),
            -1,
            11,
            11,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'invocation',
            32774,
            38,
            const prefix0.JsonSerializable(),
            -1,
            12,
            12,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'dimensionX',
            33798,
            59,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'dimensionY',
            33798,
            59,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'mapData',
            33798,
            59,
            const prefix0.JsonSerializable(),
            -1,
            8,
            8,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'realX',
            33798,
            59,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'realY',
            33798,
            59,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'resolution',
            33798,
            59,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'size',
            33798,
            59,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'timestamp',
            33798,
            59,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'type',
            33798,
            59,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_dimensionX',
            32870,
            42,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_dimensionY',
            32870,
            44,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_mapData',
            32870,
            46,
            const prefix0.JsonSerializable(),
            -1,
            8,
            8,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_realX',
            32870,
            48,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_realY',
            32870,
            50,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_resolution',
            32870,
            52,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_size',
            32870,
            54,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_timestamp',
            32870,
            56,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_type',
            32870,
            58,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'code',
            33798,
            66,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'lines',
            33798,
            66,
            const prefix0.JsonSerializable(),
            -1,
            8,
            8,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'timestamp',
            33798,
            66,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_code',
            32870,
            61,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_lines',
            32870,
            63,
            const prefix0.JsonSerializable(),
            -1,
            8,
            8,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_timestamp',
            32870,
            65,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(r'x', 33798, 73, const prefix0.JsonSerializable(),
            -1, 6, 6, const <int>[], const [], null, null),
        r.ParameterMirrorImpl(r'y', 33798, 73, const prefix0.JsonSerializable(),
            -1, 6, 6, const <int>[], const [], null, null),
        r.ParameterMirrorImpl(
            r'yaw',
            33798,
            73,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_x',
            32870,
            68,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_y',
            32870,
            70,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_yaw',
            32870,
            72,
            const prefix0.JsonSerializable(),
            -1,
            6,
            6,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'status',
            33798,
            76,
            const prefix0.JsonSerializable(),
            -1,
            8,
            8,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_status',
            32870,
            75,
            const prefix0.JsonSerializable(),
            -1,
            8,
            8,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'id',
            33798,
            79,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_id',
            32870,
            78,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null)
      ],
      <Type>[
        prefix1.KnownArea,
        prefix1.MapData,
        prefix1.VirtualWall,
        prefix1.RobotPose,
        prefix1.ActionStatus,
        prefix1.ActionID,
        double,
        int,
        String,
        bool,
        Type,
        Object,
        Invocation
      ],
      6,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'maxX': (dynamic instance) => instance.maxX,
        r'maxY': (dynamic instance) => instance.maxY,
        r'minX': (dynamic instance) => instance.minX,
        r'minY': (dynamic instance) => instance.minY,
        r'height': (dynamic instance) => instance.height,
        r'width': (dynamic instance) => instance.width,
        r'dimensionX': (dynamic instance) => instance.dimensionX,
        r'dimensionY': (dynamic instance) => instance.dimensionY,
        r'mapData': (dynamic instance) => instance.mapData,
        r'realX': (dynamic instance) => instance.realX,
        r'realY': (dynamic instance) => instance.realY,
        r'resolution': (dynamic instance) => instance.resolution,
        r'size': (dynamic instance) => instance.size,
        r'timestamp': (dynamic instance) => instance.timestamp,
        r'type': (dynamic instance) => instance.type,
        r'code': (dynamic instance) => instance.code,
        r'lines': (dynamic instance) => instance.lines,
        r'x': (dynamic instance) => instance.x,
        r'y': (dynamic instance) => instance.y,
        r'yaw': (dynamic instance) => instance.yaw,
        r'status': (dynamic instance) => instance.status,
        r'id': (dynamic instance) => instance.id
      },
      {
        r'maxX=': (dynamic instance, value) => instance.maxX = value,
        r'maxY=': (dynamic instance, value) => instance.maxY = value,
        r'minX=': (dynamic instance, value) => instance.minX = value,
        r'minY=': (dynamic instance, value) => instance.minY = value,
        r'height=': (dynamic instance, value) => instance.height = value,
        r'width=': (dynamic instance, value) => instance.width = value,
        r'dimensionX=': (dynamic instance, value) =>
            instance.dimensionX = value,
        r'dimensionY=': (dynamic instance, value) =>
            instance.dimensionY = value,
        r'mapData=': (dynamic instance, value) => instance.mapData = value,
        r'realX=': (dynamic instance, value) => instance.realX = value,
        r'realY=': (dynamic instance, value) => instance.realY = value,
        r'resolution=': (dynamic instance, value) =>
            instance.resolution = value,
        r'size=': (dynamic instance, value) => instance.size = value,
        r'timestamp=': (dynamic instance, value) => instance.timestamp = value,
        r'type=': (dynamic instance, value) => instance.type = value,
        r'code=': (dynamic instance, value) => instance.code = value,
        r'lines=': (dynamic instance, value) => instance.lines = value,
        r'x=': (dynamic instance, value) => instance.x = value,
        r'y=': (dynamic instance, value) => instance.y = value,
        r'yaw=': (dynamic instance, value) => instance.yaw = value,
        r'status=': (dynamic instance, value) => instance.status = value,
        r'id=': (dynamic instance, value) => instance.id = value
      },
      null,
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
