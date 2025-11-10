// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'local_student_model.dart';

// // **************************************************************************
// // IsarCollectionGenerator
// // **************************************************************************

// // coverage:ignore-file
// // ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

// extension GetStudentCollectionCollection on Isar {
//   IsarCollection<StudentCollection> get studentCollections => this.collection();
// }

// const StudentCollectionSchema = CollectionSchema(
//   name: r'StudentCollection',
//   id: 6167676798204934637,
//   properties: {
//     r'address': PropertySchema(
//       id: 0,
//       name: r'address',
//       type: IsarType.string,
//     ),
//     r'email': PropertySchema(
//       id: 1,
//       name: r'email',
//       type: IsarType.string,
//     ),
//     r'name': PropertySchema(
//       id: 2,
//       name: r'name',
//       type: IsarType.string,
//     ),
//     r'phoneNumber': PropertySchema(
//       id: 3,
//       name: r'phoneNumber',
//       type: IsarType.string,
//     ),
//     r'photoUrl': PropertySchema(
//       id: 4,
//       name: r'photoUrl',
//       type: IsarType.string,
//     ),
//     r'registeredCourses': PropertySchema(
//       id: 5,
//       name: r'registeredCourses',
//       type: IsarType.longList,
//     ),
//     r'studentId': PropertySchema(
//       id: 6,
//       name: r'studentId',
//       type: IsarType.string,
//     )
//   },
//   estimateSize: _studentCollectionEstimateSize,
//   serialize: _studentCollectionSerialize,
//   deserialize: _studentCollectionDeserialize,
//   deserializeProp: _studentCollectionDeserializeProp,
//   idName: r'id',
//   indexes: {},
//   links: {},
//   embeddedSchemas: {},
//   getId: _studentCollectionGetId,
//   getLinks: _studentCollectionGetLinks,
//   attach: _studentCollectionAttach,
//   version: '3.1.0+1',
// );

// int _studentCollectionEstimateSize(
//   StudentCollection object,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   var bytesCount = offsets.last;
//   bytesCount += 3 + object.address.length * 3;
//   bytesCount += 3 + object.email.length * 3;
//   bytesCount += 3 + object.name.length * 3;
//   bytesCount += 3 + object.phoneNumber.length * 3;
//   {
//     final value = object.photoUrl;
//     if (value != null) {
//       bytesCount += 3 + value.length * 3;
//     }
//   }
//   bytesCount += 3 + object.registeredCourses.length * 8;
//   bytesCount += 3 + object.studentId.length * 3;
//   return bytesCount;
// }

// void _studentCollectionSerialize(
//   StudentCollection object,
//   IsarWriter writer,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   writer.writeString(offsets[0], object.address);
//   writer.writeString(offsets[1], object.email);
//   writer.writeString(offsets[2], object.name);
//   writer.writeString(offsets[3], object.phoneNumber);
//   writer.writeString(offsets[4], object.photoUrl);
//   writer.writeLongList(offsets[5], object.registeredCourses);
//   writer.writeString(offsets[6], object.studentId);
// }

// StudentCollection _studentCollectionDeserialize(
//   Id id,
//   IsarReader reader,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   final object = StudentCollection();
//   object.address = reader.readString(offsets[0]);
//   object.email = reader.readString(offsets[1]);
//   object.id = id;
//   object.name = reader.readString(offsets[2]);
//   object.phoneNumber = reader.readString(offsets[3]);
//   object.photoUrl = reader.readStringOrNull(offsets[4]);
//   object.registeredCourses = reader.readLongList(offsets[5]) ?? [];
//   object.studentId = reader.readString(offsets[6]);
//   return object;
// }

// P _studentCollectionDeserializeProp<P>(
//   IsarReader reader,
//   int propertyId,
//   int offset,
//   Map<Type, List<int>> allOffsets,
// ) {
//   switch (propertyId) {
//     case 0:
//       return (reader.readString(offset)) as P;
//     case 1:
//       return (reader.readString(offset)) as P;
//     case 2:
//       return (reader.readString(offset)) as P;
//     case 3:
//       return (reader.readString(offset)) as P;
//     case 4:
//       return (reader.readStringOrNull(offset)) as P;
//     case 5:
//       return (reader.readLongList(offset) ?? []) as P;
//     case 6:
//       return (reader.readString(offset)) as P;
//     default:
//       throw IsarError('Unknown property with id $propertyId');
//   }
// }

// Id _studentCollectionGetId(StudentCollection object) {
//   return object.id;
// }

// List<IsarLinkBase<dynamic>> _studentCollectionGetLinks(
//     StudentCollection object) {
//   return [];
// }

// void _studentCollectionAttach(
//     IsarCollection<dynamic> col, Id id, StudentCollection object) {
//   object.id = id;
// }

// extension StudentCollectionQueryWhereSort
//     on QueryBuilder<StudentCollection, StudentCollection, QWhere> {
//   QueryBuilder<StudentCollection, StudentCollection, QAfterWhere> anyId() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(const IdWhereClause.any());
//     });
//   }
// }

// extension StudentCollectionQueryWhere
//     on QueryBuilder<StudentCollection, StudentCollection, QWhereClause> {
//   QueryBuilder<StudentCollection, StudentCollection, QAfterWhereClause>
//       idEqualTo(Id id) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(IdWhereClause.between(
//         lower: id,
//         upper: id,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterWhereClause>
//       idNotEqualTo(Id id) {
//     return QueryBuilder.apply(this, (query) {
//       if (query.whereSort == Sort.asc) {
//         return query
//             .addWhereClause(
//               IdWhereClause.lessThan(upper: id, includeUpper: false),
//             )
//             .addWhereClause(
//               IdWhereClause.greaterThan(lower: id, includeLower: false),
//             );
//       } else {
//         return query
//             .addWhereClause(
//               IdWhereClause.greaterThan(lower: id, includeLower: false),
//             )
//             .addWhereClause(
//               IdWhereClause.lessThan(upper: id, includeUpper: false),
//             );
//       }
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterWhereClause>
//       idGreaterThan(Id id, {bool include = false}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(
//         IdWhereClause.greaterThan(lower: id, includeLower: include),
//       );
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterWhereClause>
//       idLessThan(Id id, {bool include = false}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(
//         IdWhereClause.lessThan(upper: id, includeUpper: include),
//       );
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterWhereClause>
//       idBetween(
//     Id lowerId,
//     Id upperId, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(IdWhereClause.between(
//         lower: lowerId,
//         includeLower: includeLower,
//         upper: upperId,
//         includeUpper: includeUpper,
//       ));
//     });
//   }
// }

// extension StudentCollectionQueryFilter
//     on QueryBuilder<StudentCollection, StudentCollection, QFilterCondition> {
//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       addressEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'address',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       addressGreaterThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'address',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       addressLessThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'address',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       addressBetween(
//     String lower,
//     String upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'address',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       addressStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'address',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       addressEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'address',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       addressContains(String value, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'address',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       addressMatches(String pattern, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'address',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       addressIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'address',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       addressIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'address',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       emailEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'email',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       emailGreaterThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'email',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       emailLessThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'email',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       emailBetween(
//     String lower,
//     String upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'email',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       emailStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'email',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       emailEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'email',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       emailContains(String value, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'email',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       emailMatches(String pattern, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'email',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       emailIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'email',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       emailIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'email',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       idEqualTo(Id value) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       idGreaterThan(
//     Id value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       idLessThan(
//     Id value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       idBetween(
//     Id lower,
//     Id upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'id',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       nameEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'name',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       nameGreaterThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'name',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       nameLessThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'name',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       nameBetween(
//     String lower,
//     String upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'name',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       nameStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'name',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       nameEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'name',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       nameContains(String value, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'name',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       nameMatches(String pattern, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'name',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       nameIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'name',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       nameIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'name',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       phoneNumberEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'phoneNumber',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       phoneNumberGreaterThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'phoneNumber',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       phoneNumberLessThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'phoneNumber',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       phoneNumberBetween(
//     String lower,
//     String upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'phoneNumber',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       phoneNumberStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'phoneNumber',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       phoneNumberEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'phoneNumber',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       phoneNumberContains(String value, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'phoneNumber',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       phoneNumberMatches(String pattern, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'phoneNumber',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       phoneNumberIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'phoneNumber',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       phoneNumberIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'phoneNumber',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlIsNull() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(const FilterCondition.isNull(
//         property: r'photoUrl',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlIsNotNull() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(const FilterCondition.isNotNull(
//         property: r'photoUrl',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlEqualTo(
//     String? value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'photoUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlGreaterThan(
//     String? value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'photoUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlLessThan(
//     String? value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'photoUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlBetween(
//     String? lower,
//     String? upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'photoUrl',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'photoUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'photoUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlContains(String value, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'photoUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlMatches(String pattern, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'photoUrl',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'photoUrl',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       photoUrlIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'photoUrl',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       registeredCoursesElementEqualTo(int value) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'registeredCourses',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       registeredCoursesElementGreaterThan(
//     int value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'registeredCourses',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       registeredCoursesElementLessThan(
//     int value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'registeredCourses',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       registeredCoursesElementBetween(
//     int lower,
//     int upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'registeredCourses',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       registeredCoursesLengthEqualTo(int length) {
//     return QueryBuilder.apply(this, (query) {
//       return query.listLength(
//         r'registeredCourses',
//         length,
//         true,
//         length,
//         true,
//       );
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       registeredCoursesIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.listLength(
//         r'registeredCourses',
//         0,
//         true,
//         0,
//         true,
//       );
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       registeredCoursesIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.listLength(
//         r'registeredCourses',
//         0,
//         false,
//         999999,
//         true,
//       );
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       registeredCoursesLengthLessThan(
//     int length, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.listLength(
//         r'registeredCourses',
//         0,
//         true,
//         length,
//         include,
//       );
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       registeredCoursesLengthGreaterThan(
//     int length, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.listLength(
//         r'registeredCourses',
//         length,
//         include,
//         999999,
//         true,
//       );
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       registeredCoursesLengthBetween(
//     int lower,
//     int upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.listLength(
//         r'registeredCourses',
//         lower,
//         includeLower,
//         upper,
//         includeUpper,
//       );
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       studentIdEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'studentId',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       studentIdGreaterThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'studentId',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       studentIdLessThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'studentId',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       studentIdBetween(
//     String lower,
//     String upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'studentId',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       studentIdStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'studentId',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       studentIdEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'studentId',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       studentIdContains(String value, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'studentId',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       studentIdMatches(String pattern, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'studentId',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       studentIdIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'studentId',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterFilterCondition>
//       studentIdIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'studentId',
//         value: '',
//       ));
//     });
//   }
// }

// extension StudentCollectionQueryObject
//     on QueryBuilder<StudentCollection, StudentCollection, QFilterCondition> {}

// extension StudentCollectionQueryLinks
//     on QueryBuilder<StudentCollection, StudentCollection, QFilterCondition> {}

// extension StudentCollectionQuerySortBy
//     on QueryBuilder<StudentCollection, StudentCollection, QSortBy> {
//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByAddress() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'address', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByAddressDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'address', Sort.desc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByEmail() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'email', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByEmailDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'email', Sort.desc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByName() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'name', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByNameDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'name', Sort.desc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByPhoneNumber() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'phoneNumber', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByPhoneNumberDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'phoneNumber', Sort.desc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByPhotoUrl() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'photoUrl', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByPhotoUrlDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'photoUrl', Sort.desc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByStudentId() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'studentId', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       sortByStudentIdDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'studentId', Sort.desc);
//     });
//   }
// }

// extension StudentCollectionQuerySortThenBy
//     on QueryBuilder<StudentCollection, StudentCollection, QSortThenBy> {
//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByAddress() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'address', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByAddressDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'address', Sort.desc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByEmail() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'email', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByEmailDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'email', Sort.desc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy> thenById() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'id', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByIdDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'id', Sort.desc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByName() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'name', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByNameDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'name', Sort.desc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByPhoneNumber() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'phoneNumber', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByPhoneNumberDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'phoneNumber', Sort.desc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByPhotoUrl() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'photoUrl', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByPhotoUrlDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'photoUrl', Sort.desc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByStudentId() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'studentId', Sort.asc);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QAfterSortBy>
//       thenByStudentIdDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'studentId', Sort.desc);
//     });
//   }
// }

// extension StudentCollectionQueryWhereDistinct
//     on QueryBuilder<StudentCollection, StudentCollection, QDistinct> {
//   QueryBuilder<StudentCollection, StudentCollection, QDistinct>
//       distinctByAddress({bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QDistinct> distinctByEmail(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QDistinct> distinctByName(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QDistinct>
//       distinctByPhoneNumber({bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'phoneNumber', caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QDistinct>
//       distinctByPhotoUrl({bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'photoUrl', caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QDistinct>
//       distinctByRegisteredCourses() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'registeredCourses');
//     });
//   }

//   QueryBuilder<StudentCollection, StudentCollection, QDistinct>
//       distinctByStudentId({bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'studentId', caseSensitive: caseSensitive);
//     });
//   }
// }

// extension StudentCollectionQueryProperty
//     on QueryBuilder<StudentCollection, StudentCollection, QQueryProperty> {
//   QueryBuilder<StudentCollection, int, QQueryOperations> idProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'id');
//     });
//   }

//   QueryBuilder<StudentCollection, String, QQueryOperations> addressProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'address');
//     });
//   }

//   QueryBuilder<StudentCollection, String, QQueryOperations> emailProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'email');
//     });
//   }

//   QueryBuilder<StudentCollection, String, QQueryOperations> nameProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'name');
//     });
//   }

//   QueryBuilder<StudentCollection, String, QQueryOperations>
//       phoneNumberProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'phoneNumber');
//     });
//   }

//   QueryBuilder<StudentCollection, String?, QQueryOperations>
//       photoUrlProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'photoUrl');
//     });
//   }

//   QueryBuilder<StudentCollection, List<int>, QQueryOperations>
//       registeredCoursesProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'registeredCourses');
//     });
//   }

//   QueryBuilder<StudentCollection, String, QQueryOperations>
//       studentIdProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'studentId');
//     });
//   }
// }
