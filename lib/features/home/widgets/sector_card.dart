import 'package:flutter/material.dart';

import '../../../core/constants/sectors.dart';
import '../../../core/localization/app_strings.dart';

/// Carte d'un secteur (catégorie) sur l'accueil.
class SectorCard extends StatelessWidget {
  const SectorCard({super.key, required this.sector, required this.onTap});

  final Sector sector;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: sector.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(sector.icon, color: sector.color, size: 26),
              ),
              const SizedBox(height: 8),
              // Flexible + ellipsis : la carte ne déborde jamais, même si la
              // police système est plus grande ou le libellé sur 2 lignes.
              Flexible(
                child: Text(
                  t.t(sector.labelKey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
