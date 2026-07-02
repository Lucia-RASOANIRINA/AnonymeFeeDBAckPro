import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/error/error_handler.dart';
import '../../data/datasources/remote/supabase_service.dart';

/// Conversation anonyme 2-way entre le citoyen (auteur du feedback) et l'admin.
/// L'anonymat est préservé : l'échange passe uniquement par l'`anonCode`.
class ConversationScreen extends ConsumerStatefulWidget {
  const ConversationScreen({
    super.key,
    required this.feedbackId,
    required this.anonCode,
    this.asAdmin = false,
  });

  final String feedbackId;
  final String anonCode;
  final bool asAdmin;

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  final _controller = TextEditingController();
  late Future<List<Map<String, dynamic>>> _future;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<Map<String, dynamic>>> _load() =>
      ref.read(supabaseServiceProvider).fetchConversation(widget.anonCode);

  void _refresh() => setState(() => _future = _load());

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    final service = ref.read(supabaseServiceProvider);
    final messenger = ScaffoldMessenger.of(context);
    try {
      if (widget.asAdmin) {
        await service.sendAdminMessage(
          feedbackId: widget.feedbackId,
          anonCode: widget.anonCode,
          body: text,
        );
      } else {
        await service.sendUserMessage(
          feedbackId: widget.feedbackId,
          anonCode: widget.anonCode,
          body: text,
        );
      }
      _controller.clear();
      _refresh();
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Envoi impossible : ${ErrorHandler.humanize(e)}')),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversation · ${widget.anonCode}'),
        actions: [
          IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _future,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(child: Text(ErrorHandler.humanize(snap.error!)));
                }
                final msgs = snap.data ?? [];
                if (msgs.isEmpty) {
                  return const Center(
                    child: Text('Aucun message. Démarrez la conversation.'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: msgs.length,
                  itemBuilder: (_, i) => _Bubble(row: msgs[i], asAdmin: widget.asAdmin),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Votre message…',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _sending ? null : _send,
                    icon: _sending
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.row, required this.asAdmin});
  final Map<String, dynamic> row;
  final bool asAdmin;

  @override
  Widget build(BuildContext context) {
    final sender = row['sender'] as String? ?? 'user';
    final body = row['body'] as String? ?? '';
    final createdAt = DateTime.tryParse(row['created_at']?.toString() ?? '');
    // « Moi » à droite : user pour le citoyen, admin pour l'espace admin.
    final mine = asAdmin ? sender == 'admin' : sender == 'user';
    final color = sender == 'admin'
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.surfaceContainerHighest;

    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sender == 'admin' ? 'Administrateur' : 'Vous',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(body),
            if (createdAt != null)
              Text(DateFormat.Hm().format(createdAt.toLocal()),
                  style: const TextStyle(fontSize: 10, color: Colors.black45)),
          ],
        ),
      ),
    );
  }
}
