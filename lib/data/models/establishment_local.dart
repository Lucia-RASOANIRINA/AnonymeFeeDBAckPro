import 'package:isar_community/isar.dart';

part 'establishment_local.g.dart';

/// Cache local des établissements/services (pour fonctionner hors ligne et
/// afficher le nom après un scan QR sans réseau).
@collection
class EstablishmentLocal {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String serverId;

  late String name;

  @Index()
  late String sectorId;

  String? address;
  double? latitude;
  double? longitude;

  /// Code QR / slug public de l'établissement.
  @Index()
  String? qrCode;

  DateTime cachedAt = DateTime.now();
}
