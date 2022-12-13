import 'package:json_annotation/json_annotation.dart';

part 'new_and_hot_resp.g.dart';

@JsonSerializable()
class NewAndHotResp {
  @JsonKey(name: 'dates')
  Dates? dates;
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<NewAndHotData>? results;

  NewAndHotResp({this.dates, this.page, this.results});

  factory NewAndHotResp.fromJson(Map<String, dynamic> json) {
    return _$NewAndHotRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewAndHotRespToJson(this);
}

@JsonSerializable()
class NewAndHotData {
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'original_language')
  String? originalLanguage;

  @JsonKey(name: 'original_title')
  String? originalTitle;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey(name: 'title')
  String? title;

  NewAndHotData({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
  });

  factory NewAndHotData.fromJson(Map<String, dynamic> json) {
    return _$NewAndHotDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewAndHotDataToJson(this);
}

@JsonSerializable()
class Dates {
  String? maximum;
  String? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);
}
