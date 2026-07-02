import 'package:flutter/material.dart';

import '../../../data/models/feedback_models.dart';

/// Sélecteur de note adaptatif : étoiles (1-5), échelle (1-10) ou smileys (1-5).
class RatingSelector extends StatelessWidget {
  const RatingSelector({
    super.key,
    required this.type,
    required this.value,
    required this.onTypeChanged,
    required this.onChanged,
  });

  final RatingType type;
  final int value;
  final ValueChanged<RatingType> onTypeChanged;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Choix du type d'échelle.
        SegmentedButton<RatingType>(
          segments: const [
            ButtonSegment(value: RatingType.stars, icon: Icon(Icons.star)),
            ButtonSegment(
                value: RatingType.smiley,
                icon: Icon(Icons.sentiment_satisfied_alt)),
            ButtonSegment(
                value: RatingType.scale, icon: Icon(Icons.looks_one_outlined)),
          ],
          selected: {type},
          onSelectionChanged: (s) => onTypeChanged(s.first),
        ),
        const SizedBox(height: 16),
        switch (type) {
          RatingType.stars => _StarRow(value: value, onChanged: onChanged),
          RatingType.smiley => _SmileyRow(value: value, onChanged: onChanged),
          RatingType.scale => _ScaleRow(value: value, onChanged: onChanged),
        },
      ],
    );
  }
}

class _StarRow extends StatelessWidget {
  const _StarRow({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        final filled = i < value;
        return IconButton(
          iconSize: 40,
          onPressed: () => onChanged(i + 1),
          icon: Icon(
            filled ? Icons.star_rounded : Icons.star_outline_rounded,
            color: filled ? Colors.amber : null,
          ),
        );
      }),
    );
  }
}

class _SmileyRow extends StatelessWidget {
  const _SmileyRow({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  static const _icons = [
    Icons.sentiment_very_dissatisfied,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_satisfied,
    Icons.sentiment_very_satisfied,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (i) {
        final selected = value == i + 1;
        return IconButton(
          iconSize: 38,
          onPressed: () => onChanged(i + 1),
          icon: Icon(
            _icons[i],
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
          ),
        );
      }),
    );
  }
}

class _ScaleRow extends StatelessWidget {
  const _ScaleRow({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(10, (i) {
        final n = i + 1;
        final selected = value == n;
        return ChoiceChip(
          label: Text('$n'),
          selected: selected,
          onSelected: (_) => onChanged(n),
        );
      }),
    );
  }
}
