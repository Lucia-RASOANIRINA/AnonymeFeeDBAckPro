// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFeedbackLocalCollection on Isar {
  IsarCollection<FeedbackLocal> get feedbackLocals => this.collection();
}

const FeedbackLocalSchema = CollectionSchema(
  name: r'FeedbackLocal',
  id: 435726757451932290,
  properties: {
    r'anonCode': PropertySchema(
      id: 0,
      name: r'anonCode',
      type: IsarType.string,
    ),
    r'comment': PropertySchema(id: 1, name: r'comment', type: IsarType.string),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'establishmentId': PropertySchema(
      id: 3,
      name: r'establishmentId',
      type: IsarType.string,
    ),
    r'establishmentName': PropertySchema(
      id: 4,
      name: r'establishmentName',
      type: IsarType.string,
    ),
    r'hasLocation': PropertySchema(
      id: 5,
      name: r'hasLocation',
      type: IsarType.bool,
    ),
    r'isCritical': PropertySchema(
      id: 6,
      name: r'isCritical',
      type: IsarType.bool,
    ),
    r'lastSyncError': PropertySchema(
      id: 7,
      name: r'lastSyncError',
      type: IsarType.string,
    ),
    r'latitude': PropertySchema(
      id: 8,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'localPhotoPaths': PropertySchema(
      id: 9,
      name: r'localPhotoPaths',
      type: IsarType.stringList,
    ),
    r'localUuid': PropertySchema(
      id: 10,
      name: r'localUuid',
      type: IsarType.string,
    ),
    r'localVideoPath': PropertySchema(
      id: 11,
      name: r'localVideoPath',
      type: IsarType.string,
    ),
    r'locationLabel': PropertySchema(
      id: 12,
      name: r'locationLabel',
      type: IsarType.string,
    ),
    r'longitude': PropertySchema(
      id: 13,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'priority': PropertySchema(id: 14, name: r'priority', type: IsarType.bool),
    r'problemDetails': PropertySchema(
      id: 15,
      name: r'problemDetails',
      type: IsarType.string,
    ),
    r'problemTypes': PropertySchema(
      id: 16,
      name: r'problemTypes',
      type: IsarType.stringList,
    ),
    r'ratingNormalized': PropertySchema(
      id: 17,
      name: r'ratingNormalized',
      type: IsarType.long,
    ),
    r'ratingRaw': PropertySchema(
      id: 18,
      name: r'ratingRaw',
      type: IsarType.long,
    ),
    r'ratingType': PropertySchema(
      id: 19,
      name: r'ratingType',
      type: IsarType.string,
      enumMap: _FeedbackLocalratingTypeEnumValueMap,
    ),
    r'remotePhotoUrls': PropertySchema(
      id: 20,
      name: r'remotePhotoUrls',
      type: IsarType.stringList,
    ),
    r'remoteVideoUrl': PropertySchema(
      id: 21,
      name: r'remoteVideoUrl',
      type: IsarType.string,
    ),
    r'sectorId': PropertySchema(
      id: 22,
      name: r'sectorId',
      type: IsarType.string,
    ),
    r'serverId': PropertySchema(
      id: 23,
      name: r'serverId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 24,
      name: r'status',
      type: IsarType.string,
      enumMap: _FeedbackLocalstatusEnumValueMap,
    ),
    r'suggestion': PropertySchema(
      id: 25,
      name: r'suggestion',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 26,
      name: r'syncStatus',
      type: IsarType.string,
      enumMap: _FeedbackLocalsyncStatusEnumValueMap,
    ),
  },

  estimateSize: _feedbackLocalEstimateSize,
  serialize: _feedbackLocalSerialize,
  deserialize: _feedbackLocalDeserialize,
  deserializeProp: _feedbackLocalDeserializeProp,
  idName: r'id',
  indexes: {
    r'localUuid': IndexSchema(
      id: -6532194816220061379,
      name: r'localUuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'localUuid',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'sectorId': IndexSchema(
      id: 1119158776821935563,
      name: r'sectorId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sectorId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'syncStatus': IndexSchema(
      id: 8239539375045684509,
      name: r'syncStatus',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'syncStatus',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _feedbackLocalGetId,
  getLinks: _feedbackLocalGetLinks,
  attach: _feedbackLocalAttach,
  version: '3.3.2',
);

int _feedbackLocalEstimateSize(
  FeedbackLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.anonCode.length * 3;
  {
    final value = object.comment;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.establishmentId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.establishmentName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastSyncError;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.localPhotoPaths.length * 3;
  {
    for (var i = 0; i < object.localPhotoPaths.length; i++) {
      final value = object.localPhotoPaths[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.localUuid.length * 3;
  {
    final value = object.localVideoPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.locationLabel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.problemDetails;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.problemTypes.length * 3;
  {
    for (var i = 0; i < object.problemTypes.length; i++) {
      final value = object.problemTypes[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.ratingType.name.length * 3;
  bytesCount += 3 + object.remotePhotoUrls.length * 3;
  {
    for (var i = 0; i < object.remotePhotoUrls.length; i++) {
      final value = object.remotePhotoUrls[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.remoteVideoUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.sectorId.length * 3;
  {
    final value = object.serverId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.name.length * 3;
  {
    final value = object.suggestion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.syncStatus.name.length * 3;
  return bytesCount;
}

void _feedbackLocalSerialize(
  FeedbackLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.anonCode);
  writer.writeString(offsets[1], object.comment);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.establishmentId);
  writer.writeString(offsets[4], object.establishmentName);
  writer.writeBool(offsets[5], object.hasLocation);
  writer.writeBool(offsets[6], object.isCritical);
  writer.writeString(offsets[7], object.lastSyncError);
  writer.writeDouble(offsets[8], object.latitude);
  writer.writeStringList(offsets[9], object.localPhotoPaths);
  writer.writeString(offsets[10], object.localUuid);
  writer.writeString(offsets[11], object.localVideoPath);
  writer.writeString(offsets[12], object.locationLabel);
  writer.writeDouble(offsets[13], object.longitude);
  writer.writeBool(offsets[14], object.priority);
  writer.writeString(offsets[15], object.problemDetails);
  writer.writeStringList(offsets[16], object.problemTypes);
  writer.writeLong(offsets[17], object.ratingNormalized);
  writer.writeLong(offsets[18], object.ratingRaw);
  writer.writeString(offsets[19], object.ratingType.name);
  writer.writeStringList(offsets[20], object.remotePhotoUrls);
  writer.writeString(offsets[21], object.remoteVideoUrl);
  writer.writeString(offsets[22], object.sectorId);
  writer.writeString(offsets[23], object.serverId);
  writer.writeString(offsets[24], object.status.name);
  writer.writeString(offsets[25], object.suggestion);
  writer.writeString(offsets[26], object.syncStatus.name);
}

FeedbackLocal _feedbackLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FeedbackLocal();
  object.anonCode = reader.readString(offsets[0]);
  object.comment = reader.readStringOrNull(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.establishmentId = reader.readStringOrNull(offsets[3]);
  object.establishmentName = reader.readStringOrNull(offsets[4]);
  object.hasLocation = reader.readBool(offsets[5]);
  object.id = id;
  object.isCritical = reader.readBool(offsets[6]);
  object.lastSyncError = reader.readStringOrNull(offsets[7]);
  object.latitude = reader.readDoubleOrNull(offsets[8]);
  object.localPhotoPaths = reader.readStringList(offsets[9]) ?? [];
  object.localUuid = reader.readString(offsets[10]);
  object.localVideoPath = reader.readStringOrNull(offsets[11]);
  object.locationLabel = reader.readStringOrNull(offsets[12]);
  object.longitude = reader.readDoubleOrNull(offsets[13]);
  object.priority = reader.readBool(offsets[14]);
  object.problemDetails = reader.readStringOrNull(offsets[15]);
  object.problemTypes = reader.readStringList(offsets[16]) ?? [];
  object.ratingNormalized = reader.readLong(offsets[17]);
  object.ratingRaw = reader.readLong(offsets[18]);
  object.ratingType =
      _FeedbackLocalratingTypeValueEnumMap[reader.readStringOrNull(
        offsets[19],
      )] ??
      RatingType.stars;
  object.remotePhotoUrls = reader.readStringList(offsets[20]) ?? [];
  object.remoteVideoUrl = reader.readStringOrNull(offsets[21]);
  object.sectorId = reader.readString(offsets[22]);
  object.serverId = reader.readStringOrNull(offsets[23]);
  object.status =
      _FeedbackLocalstatusValueEnumMap[reader.readStringOrNull(offsets[24])] ??
      FeedbackStatus.submitted;
  object.suggestion = reader.readStringOrNull(offsets[25]);
  object.syncStatus =
      _FeedbackLocalsyncStatusValueEnumMap[reader.readStringOrNull(
        offsets[26],
      )] ??
      LocalSyncStatus.pending;
  return object;
}

P _feedbackLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readStringList(offset) ?? []) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readDoubleOrNull(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringList(offset) ?? []) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (_FeedbackLocalratingTypeValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              RatingType.stars)
          as P;
    case 20:
      return (reader.readStringList(offset) ?? []) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (_FeedbackLocalstatusValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              FeedbackStatus.submitted)
          as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (_FeedbackLocalsyncStatusValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              LocalSyncStatus.pending)
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FeedbackLocalratingTypeEnumValueMap = {
  r'stars': r'stars',
  r'scale': r'scale',
  r'smiley': r'smiley',
};
const _FeedbackLocalratingTypeValueEnumMap = {
  r'stars': RatingType.stars,
  r'scale': RatingType.scale,
  r'smiley': RatingType.smiley,
};
const _FeedbackLocalstatusEnumValueMap = {
  r'submitted': r'submitted',
  r'inProgress': r'inProgress',
  r'resolved': r'resolved',
};
const _FeedbackLocalstatusValueEnumMap = {
  r'submitted': FeedbackStatus.submitted,
  r'inProgress': FeedbackStatus.inProgress,
  r'resolved': FeedbackStatus.resolved,
};
const _FeedbackLocalsyncStatusEnumValueMap = {
  r'pending': r'pending',
  r'syncing': r'syncing',
  r'synced': r'synced',
  r'error': r'error',
};
const _FeedbackLocalsyncStatusValueEnumMap = {
  r'pending': LocalSyncStatus.pending,
  r'syncing': LocalSyncStatus.syncing,
  r'synced': LocalSyncStatus.synced,
  r'error': LocalSyncStatus.error,
};

Id _feedbackLocalGetId(FeedbackLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _feedbackLocalGetLinks(FeedbackLocal object) {
  return [];
}

void _feedbackLocalAttach(
  IsarCollection<dynamic> col,
  Id id,
  FeedbackLocal object,
) {
  object.id = id;
}

extension FeedbackLocalByIndex on IsarCollection<FeedbackLocal> {
  Future<FeedbackLocal?> getByLocalUuid(String localUuid) {
    return getByIndex(r'localUuid', [localUuid]);
  }

  FeedbackLocal? getByLocalUuidSync(String localUuid) {
    return getByIndexSync(r'localUuid', [localUuid]);
  }

  Future<bool> deleteByLocalUuid(String localUuid) {
    return deleteByIndex(r'localUuid', [localUuid]);
  }

  bool deleteByLocalUuidSync(String localUuid) {
    return deleteByIndexSync(r'localUuid', [localUuid]);
  }

  Future<List<FeedbackLocal?>> getAllByLocalUuid(List<String> localUuidValues) {
    final values = localUuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'localUuid', values);
  }

  List<FeedbackLocal?> getAllByLocalUuidSync(List<String> localUuidValues) {
    final values = localUuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'localUuid', values);
  }

  Future<int> deleteAllByLocalUuid(List<String> localUuidValues) {
    final values = localUuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'localUuid', values);
  }

  int deleteAllByLocalUuidSync(List<String> localUuidValues) {
    final values = localUuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'localUuid', values);
  }

  Future<Id> putByLocalUuid(FeedbackLocal object) {
    return putByIndex(r'localUuid', object);
  }

  Id putByLocalUuidSync(FeedbackLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'localUuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLocalUuid(List<FeedbackLocal> objects) {
    return putAllByIndex(r'localUuid', objects);
  }

  List<Id> putAllByLocalUuidSync(
    List<FeedbackLocal> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'localUuid', objects, saveLinks: saveLinks);
  }
}

extension FeedbackLocalQueryWhereSort
    on QueryBuilder<FeedbackLocal, FeedbackLocal, QWhere> {
  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension FeedbackLocalQueryWhere
    on QueryBuilder<FeedbackLocal, FeedbackLocal, QWhereClause> {
  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause>
  localUuidEqualTo(String localUuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'localUuid', value: [localUuid]),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause>
  localUuidNotEqualTo(String localUuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'localUuid',
                lower: [],
                upper: [localUuid],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'localUuid',
                lower: [localUuid],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'localUuid',
                lower: [localUuid],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'localUuid',
                lower: [],
                upper: [localUuid],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause> sectorIdEqualTo(
    String sectorId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'sectorId', value: [sectorId]),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause>
  sectorIdNotEqualTo(String sectorId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sectorId',
                lower: [],
                upper: [sectorId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sectorId',
                lower: [sectorId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sectorId',
                lower: [sectorId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sectorId',
                lower: [],
                upper: [sectorId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause>
  createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'createdAt', value: [createdAt]),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause>
  createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [],
                upper: [createdAt],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [createdAt],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [createdAt],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [],
                upper: [createdAt],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause>
  createdAtGreaterThan(DateTime createdAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [createdAt],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause>
  createdAtLessThan(DateTime createdAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [],
          upper: [createdAt],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause>
  createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [lowerCreatedAt],
          includeLower: includeLower,
          upper: [upperCreatedAt],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause>
  syncStatusEqualTo(LocalSyncStatus syncStatus) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'syncStatus', value: [syncStatus]),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterWhereClause>
  syncStatusNotEqualTo(LocalSyncStatus syncStatus) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'syncStatus',
                lower: [],
                upper: [syncStatus],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'syncStatus',
                lower: [syncStatus],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'syncStatus',
                lower: [syncStatus],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'syncStatus',
                lower: [],
                upper: [syncStatus],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension FeedbackLocalQueryFilter
    on QueryBuilder<FeedbackLocal, FeedbackLocal, QFilterCondition> {
  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  anonCodeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'anonCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  anonCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'anonCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  anonCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'anonCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  anonCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'anonCode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  anonCodeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'anonCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  anonCodeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'anonCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  anonCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'anonCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  anonCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'anonCode',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  anonCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'anonCode', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  anonCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'anonCode', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'comment'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'comment'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'comment',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'comment',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'comment', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  commentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'comment', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'establishmentId'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'establishmentId'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'establishmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'establishmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'establishmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'establishmentId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'establishmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'establishmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'establishmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'establishmentId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'establishmentId', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'establishmentId', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'establishmentName'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'establishmentName'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'establishmentName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'establishmentName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'establishmentName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'establishmentName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'establishmentName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'establishmentName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'establishmentName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'establishmentName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'establishmentName', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  establishmentNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'establishmentName', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  hasLocationEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasLocation', value: value),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  isCriticalEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isCritical', value: value),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastSyncError'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastSyncError'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lastSyncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastSyncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastSyncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastSyncError',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'lastSyncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'lastSyncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'lastSyncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'lastSyncError',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastSyncError', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  lastSyncErrorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'lastSyncError', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'latitude'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'latitude'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  latitudeEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  latitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  latitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  latitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'latitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'localPhotoPaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'localPhotoPaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'localPhotoPaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'localPhotoPaths',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'localPhotoPaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'localPhotoPaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'localPhotoPaths',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'localPhotoPaths',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localPhotoPaths', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'localPhotoPaths', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'localPhotoPaths', length, true, length, true);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'localPhotoPaths', 0, true, 0, true);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'localPhotoPaths', 0, false, 999999, true);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'localPhotoPaths', 0, true, length, include);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localPhotoPaths',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localPhotoPathsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localPhotoPaths',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localUuidEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'localUuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localUuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'localUuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localUuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'localUuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localUuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'localUuid',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localUuidStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'localUuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localUuidEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'localUuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'localUuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'localUuid',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localUuid', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'localUuid', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'localVideoPath'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'localVideoPath'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'localVideoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'localVideoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'localVideoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'localVideoPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'localVideoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'localVideoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'localVideoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'localVideoPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localVideoPath', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  localVideoPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'localVideoPath', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'locationLabel'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'locationLabel'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'locationLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'locationLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'locationLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'locationLabel',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'locationLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'locationLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'locationLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'locationLabel',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'locationLabel', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  locationLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'locationLabel', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'longitude'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'longitude'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  longitudeEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  longitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  longitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  longitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'longitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  priorityEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'priority', value: value),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'problemDetails'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'problemDetails'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'problemDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'problemDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'problemDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'problemDetails',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'problemDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'problemDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'problemDetails',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'problemDetails',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'problemDetails', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemDetailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'problemDetails', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'problemTypes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'problemTypes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'problemTypes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'problemTypes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'problemTypes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'problemTypes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'problemTypes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'problemTypes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'problemTypes', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'problemTypes', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'problemTypes', length, true, length, true);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'problemTypes', 0, true, 0, true);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'problemTypes', 0, false, 999999, true);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'problemTypes', 0, true, length, include);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'problemTypes', length, include, 999999, true);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  problemTypesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'problemTypes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingNormalizedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'ratingNormalized', value: value),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingNormalizedGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'ratingNormalized',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingNormalizedLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'ratingNormalized',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingNormalizedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'ratingNormalized',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingRawEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'ratingRaw', value: value),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingRawGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'ratingRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingRawLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'ratingRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingRawBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'ratingRaw',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingTypeEqualTo(RatingType value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'ratingType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingTypeGreaterThan(
    RatingType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'ratingType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingTypeLessThan(
    RatingType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'ratingType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingTypeBetween(
    RatingType lower,
    RatingType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'ratingType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'ratingType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingTypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'ratingType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'ratingType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'ratingType',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'ratingType', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  ratingTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'ratingType', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'remotePhotoUrls',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'remotePhotoUrls',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'remotePhotoUrls',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'remotePhotoUrls',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'remotePhotoUrls',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'remotePhotoUrls',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'remotePhotoUrls',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'remotePhotoUrls',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'remotePhotoUrls', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'remotePhotoUrls', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'remotePhotoUrls', length, true, length, true);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'remotePhotoUrls', 0, true, 0, true);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'remotePhotoUrls', 0, false, 999999, true);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'remotePhotoUrls', 0, true, length, include);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'remotePhotoUrls',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remotePhotoUrlsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'remotePhotoUrls',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'remoteVideoUrl'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'remoteVideoUrl'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'remoteVideoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'remoteVideoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'remoteVideoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'remoteVideoUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'remoteVideoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'remoteVideoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'remoteVideoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'remoteVideoUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'remoteVideoUrl', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  remoteVideoUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'remoteVideoUrl', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  sectorIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sectorId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  sectorIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sectorId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  sectorIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sectorId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  sectorIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sectorId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  sectorIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sectorId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  sectorIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sectorId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  sectorIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sectorId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  sectorIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sectorId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  sectorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sectorId', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  sectorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sectorId', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'serverId'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'serverId'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'serverId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'serverId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'serverId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'serverId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'serverId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'serverId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'serverId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'serverId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'serverId', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  serverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'serverId', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  statusEqualTo(FeedbackStatus value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  statusGreaterThan(
    FeedbackStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  statusLessThan(
    FeedbackStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  statusBetween(
    FeedbackStatus lower,
    FeedbackStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  statusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  statusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'suggestion'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'suggestion'),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'suggestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'suggestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'suggestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'suggestion',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'suggestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'suggestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'suggestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'suggestion',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'suggestion', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  suggestionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'suggestion', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  syncStatusEqualTo(LocalSyncStatus value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'syncStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  syncStatusGreaterThan(
    LocalSyncStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'syncStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  syncStatusLessThan(
    LocalSyncStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'syncStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  syncStatusBetween(
    LocalSyncStatus lower,
    LocalSyncStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'syncStatus',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  syncStatusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'syncStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  syncStatusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'syncStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  syncStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'syncStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  syncStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'syncStatus',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  syncStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncStatus', value: ''),
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterFilterCondition>
  syncStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'syncStatus', value: ''),
      );
    });
  }
}

extension FeedbackLocalQueryObject
    on QueryBuilder<FeedbackLocal, FeedbackLocal, QFilterCondition> {}

extension FeedbackLocalQueryLinks
    on QueryBuilder<FeedbackLocal, FeedbackLocal, QFilterCondition> {}

extension FeedbackLocalQuerySortBy
    on QueryBuilder<FeedbackLocal, FeedbackLocal, QSortBy> {
  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByAnonCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anonCode', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByAnonCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anonCode', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByEstablishmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'establishmentId', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByEstablishmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'establishmentId', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByEstablishmentName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'establishmentName', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByEstablishmentNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'establishmentName', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByHasLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLocation', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByHasLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLocation', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByIsCritical() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCritical', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByIsCriticalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCritical', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByLastSyncError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncError', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByLastSyncErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncError', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByLocalUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUuid', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByLocalUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUuid', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByLocalVideoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVideoPath', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByLocalVideoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVideoPath', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByLocationLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLabel', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByLocationLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLabel', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByProblemDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemDetails', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByProblemDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemDetails', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByRatingNormalized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingNormalized', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByRatingNormalizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingNormalized', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByRatingRaw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingRaw', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByRatingRawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingRaw', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByRatingType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingType', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByRatingTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingType', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByRemoteVideoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteVideoUrl', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByRemoteVideoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteVideoUrl', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortBySectorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectorId', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortBySectorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectorId', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortByServerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortBySuggestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestion', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortBySuggestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestion', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }
}

extension FeedbackLocalQuerySortThenBy
    on QueryBuilder<FeedbackLocal, FeedbackLocal, QSortThenBy> {
  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByAnonCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anonCode', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByAnonCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anonCode', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByEstablishmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'establishmentId', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByEstablishmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'establishmentId', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByEstablishmentName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'establishmentName', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByEstablishmentNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'establishmentName', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByHasLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLocation', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByHasLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLocation', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByIsCritical() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCritical', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByIsCriticalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCritical', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByLastSyncError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncError', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByLastSyncErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncError', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByLocalUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUuid', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByLocalUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUuid', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByLocalVideoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVideoPath', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByLocalVideoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVideoPath', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByLocationLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLabel', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByLocationLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLabel', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByProblemDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemDetails', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByProblemDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemDetails', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByRatingNormalized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingNormalized', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByRatingNormalizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingNormalized', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByRatingRaw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingRaw', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByRatingRawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingRaw', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByRatingType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingType', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByRatingTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingType', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByRemoteVideoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteVideoUrl', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByRemoteVideoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteVideoUrl', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenBySectorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectorId', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenBySectorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectorId', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenByServerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenBySuggestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestion', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenBySuggestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestion', Sort.desc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy> thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QAfterSortBy>
  thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }
}

extension FeedbackLocalQueryWhereDistinct
    on QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> {
  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByAnonCode({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'anonCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByComment({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comment', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByEstablishmentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'establishmentId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByEstablishmentName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'establishmentName',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByHasLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasLocation');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByIsCritical() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCritical');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByLastSyncError({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'lastSyncError',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByLocalPhotoPaths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localPhotoPaths');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByLocalUuid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localUuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByLocalVideoPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'localVideoPath',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByLocationLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'locationLabel',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByProblemDetails({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'problemDetails',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByProblemTypes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemTypes');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByRatingNormalized() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ratingNormalized');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByRatingRaw() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ratingRaw');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByRatingType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ratingType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByRemotePhotoUrls() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remotePhotoUrls');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct>
  distinctByRemoteVideoUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'remoteVideoUrl',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctBySectorId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sectorId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByServerId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serverId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctByStatus({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctBySuggestion({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'suggestion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackLocal, QDistinct> distinctBySyncStatus({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus', caseSensitive: caseSensitive);
    });
  }
}

extension FeedbackLocalQueryProperty
    on QueryBuilder<FeedbackLocal, FeedbackLocal, QQueryProperty> {
  QueryBuilder<FeedbackLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FeedbackLocal, String, QQueryOperations> anonCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'anonCode');
    });
  }

  QueryBuilder<FeedbackLocal, String?, QQueryOperations> commentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comment');
    });
  }

  QueryBuilder<FeedbackLocal, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FeedbackLocal, String?, QQueryOperations>
  establishmentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'establishmentId');
    });
  }

  QueryBuilder<FeedbackLocal, String?, QQueryOperations>
  establishmentNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'establishmentName');
    });
  }

  QueryBuilder<FeedbackLocal, bool, QQueryOperations> hasLocationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasLocation');
    });
  }

  QueryBuilder<FeedbackLocal, bool, QQueryOperations> isCriticalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCritical');
    });
  }

  QueryBuilder<FeedbackLocal, String?, QQueryOperations>
  lastSyncErrorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSyncError');
    });
  }

  QueryBuilder<FeedbackLocal, double?, QQueryOperations> latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<FeedbackLocal, List<String>, QQueryOperations>
  localPhotoPathsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localPhotoPaths');
    });
  }

  QueryBuilder<FeedbackLocal, String, QQueryOperations> localUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localUuid');
    });
  }

  QueryBuilder<FeedbackLocal, String?, QQueryOperations>
  localVideoPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localVideoPath');
    });
  }

  QueryBuilder<FeedbackLocal, String?, QQueryOperations>
  locationLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locationLabel');
    });
  }

  QueryBuilder<FeedbackLocal, double?, QQueryOperations> longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<FeedbackLocal, bool, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<FeedbackLocal, String?, QQueryOperations>
  problemDetailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemDetails');
    });
  }

  QueryBuilder<FeedbackLocal, List<String>, QQueryOperations>
  problemTypesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemTypes');
    });
  }

  QueryBuilder<FeedbackLocal, int, QQueryOperations>
  ratingNormalizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ratingNormalized');
    });
  }

  QueryBuilder<FeedbackLocal, int, QQueryOperations> ratingRawProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ratingRaw');
    });
  }

  QueryBuilder<FeedbackLocal, RatingType, QQueryOperations>
  ratingTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ratingType');
    });
  }

  QueryBuilder<FeedbackLocal, List<String>, QQueryOperations>
  remotePhotoUrlsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remotePhotoUrls');
    });
  }

  QueryBuilder<FeedbackLocal, String?, QQueryOperations>
  remoteVideoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteVideoUrl');
    });
  }

  QueryBuilder<FeedbackLocal, String, QQueryOperations> sectorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sectorId');
    });
  }

  QueryBuilder<FeedbackLocal, String?, QQueryOperations> serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serverId');
    });
  }

  QueryBuilder<FeedbackLocal, FeedbackStatus, QQueryOperations>
  statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<FeedbackLocal, String?, QQueryOperations> suggestionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'suggestion');
    });
  }

  QueryBuilder<FeedbackLocal, LocalSyncStatus, QQueryOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }
}
