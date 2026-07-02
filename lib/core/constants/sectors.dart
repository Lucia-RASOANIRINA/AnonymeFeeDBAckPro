import 'package:flutter/material.dart';

/// Secteurs prédéfinis avec leurs templates de questionnaire.
///
/// Les libellés sont des clés de traduction (voir [AppStrings]).
class Sector {
  final String id;
  final String labelKey;
  final IconData icon;
  final Color color;

  const Sector({
    required this.id,
    required this.labelKey,
    required this.icon,
    required this.color,
  });
}

class Sectors {
  Sectors._();

  static const List<Sector> all = [
    Sector(
      id: 'health',
      labelKey: 'sector_health',
      icon: Icons.local_hospital_outlined,
      color: Color(0xFFE53935),
    ),
    Sector(
      id: 'education',
      labelKey: 'sector_education',
      icon: Icons.school_outlined,
      color: Color(0xFF1E88E5),
    ),
    Sector(
      id: 'commerce',
      labelKey: 'sector_commerce',
      icon: Icons.storefront_outlined,
      color: Color(0xFFFB8C00),
    ),
    Sector(
      id: 'public_admin',
      labelKey: 'sector_public_admin',
      icon: Icons.account_balance_outlined,
      color: Color(0xFF6D4C41),
    ),
    Sector(
      id: 'hospitality',
      labelKey: 'sector_hospitality',
      icon: Icons.restaurant_outlined,
      color: Color(0xFF8E24AA),
    ),
    Sector(
      id: 'transport',
      labelKey: 'sector_transport',
      icon: Icons.directions_bus_outlined,
      color: Color(0xFF00897B),
    ),
  ];

  static Sector? byId(String id) {
    for (final s in all) {
      if (s.id == id) return s;
    }
    return null;
  }
}
