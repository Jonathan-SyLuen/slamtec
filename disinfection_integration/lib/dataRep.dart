import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(name: 'result')
class KnownArea {
  @JsonProperty(name: 'max_x')
  double maxX;
  @JsonProperty(name: 'max_y')
  double maxY;
  @JsonProperty(name: 'min_x')
  double minX;
  @JsonProperty(name: 'min_y')
  double minY;
  late final double height;
  late final double width;

  KnownArea(this.maxX, this.maxY, this.minX, this.minY) {
    height = maxY - minY;
    width = maxX - minX;
  }
}

@jsonSerializable
@Json(name: 'result/')
class MapData {
  @JsonProperty(name: 'dimension_x')
  int dimensionX;
  @JsonProperty(name: 'dimension_y')
  int dimensionY;
  @JsonProperty(name: 'map_data')
  String mapData;
  @JsonProperty(name: 'real_x')
  double realX;
  @JsonProperty(name: 'real_y')
  double realY;
  @JsonProperty(name: 'resolution')
  double resolution;
  @JsonProperty(name: 'size')
  int size;
  @JsonProperty(name: 'timestamp')
  int timestamp;
  @JsonProperty(name: 'type')
  int type;

  MapData(this.dimensionX, this.dimensionY, this.mapData, this.realX,
      this.realY, this.resolution, this.size, this.timestamp, this.type);
}

@jsonSerializable
@Json(name: 'result')
class VirtualWall {
  @JsonProperty(name: 'code')
  int code;
  @JsonProperty(name: 'lines')
  String lines;
  @JsonProperty(name: 'timestamp')
  int timestamp;

  VirtualWall(this.code, this.lines, this.timestamp);
}

@jsonSerializable
@Json(name: 'result')
class RobotPose {
  @JsonProperty(name: 'x')
  double x;
  @JsonProperty(name: 'y')
  double y;
  @JsonProperty(name: 'yaw')
  double yaw;

  RobotPose(this.x, this.y, this.yaw);
}

@jsonSerializable
@Json(name: 'result')
class ActionStatus {
  @JsonProperty(name: 'codestr')
  String status;

  ActionStatus(this.status);
}

@jsonSerializable
@Json(name: 'result')
class ActionID {
  @JsonProperty(name: 'id')
  int id;

  ActionID(this.id);
}
