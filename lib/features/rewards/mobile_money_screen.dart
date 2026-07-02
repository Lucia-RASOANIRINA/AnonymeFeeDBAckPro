import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Récompense optionnelle par Mobile Money (MVola, Orange Money, Airtel Money).
///
/// Écran de saisie de l'intention de versement. L'intégration réelle d'un
/// agrégateur de paiement se branche dans [_confirm] (API opérateur / passerelle).
class MobileMoneyScreen extends StatefulWidget {
  const MobileMoneyScreen({super.key});

  @override
  State<MobileMoneyScreen> createState() => _MobileMoneyScreenState();
}

enum _Operator { mvola, orange, airtel }

extension on _Operator {
  String get label => switch (this) {
        _Operator.mvola => 'MVola',
        _Operator.orange => 'Orange Money',
        _Operator.airtel => 'Airtel Money',
      };
  Color get color => switch (this) {
        _Operator.mvola => const Color(0xFFE2001A),
        _Operator.orange => const Color(0xFFFF7900),
        _Operator.airtel => const Color(0xFFED1C24),
      };
}

class _MobileMoneyScreenState extends State<MobileMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _amount = TextEditingController(text: '2000');
  _Operator _operator = _Operator.mvola;
  bool _submitting = false;

  @override
  void dispose() {
    _phone.dispose();
    _amount.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    // TODO(paiement) : appeler l'API de l'agrégateur / opérateur ici.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _submitting = false);
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Demande enregistrée'),
        content: Text(
          'Un versement de ${_amount.text} Ar via ${_operator.label} vers '
          '${_phone.text} a été enregistré. Vous recevrez une confirmation.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Récompense Mobile Money')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Recevez une petite récompense pour un feedback utile. '
              'Choisissez votre opérateur, saisissez votre numéro et le montant.',
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                for (final op in _Operator.values)
                  ChoiceChip(
                    label: Text(op.label),
                    selected: _operator == op,
                    selectedColor: op.color.withValues(alpha: 0.2),
                    onSelected: (_) => setState(() => _operator = op),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Numéro Mobile Money',
                prefixText: '+261 ',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.length < 9) ? 'Numéro invalide' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amount,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Montant',
                suffixText: 'Ar',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                if (n == null || n < 500) return 'Montant minimum 500 Ar';
                return null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _submitting ? null : _confirm,
              icon: _submitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.payments_outlined),
              label: const Text('Confirmer le versement'),
            ),
          ],
        ),
      ),
    );
  }
}
