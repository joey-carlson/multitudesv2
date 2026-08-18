import 'package:flutter/material.dart';

import '../data/database.dart';
import '../domain/journal_prompts.dart';
import '../domain/persona.dart';

/// Write a reflective journal entry for a persona: pick a prompt (or free-write)
/// and save. Returns true on save. Private, on-device.
class WriteJournalScreen extends StatefulWidget {
  const WriteJournalScreen({
    super.key,
    required this.db,
    required this.userId,
    required this.persona,
  });

  final AppDatabase db;
  final String userId;
  final Persona persona;

  @override
  State<WriteJournalScreen> createState() => _WriteJournalScreenState();
}

class _WriteJournalScreenState extends State<WriteJournalScreen> {
  final _body = TextEditingController();
  String? _prompt;
  bool _saving = false;

  @override
  void dispose() {
    _body.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_body.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Write something first')));
      return;
    }
    setState(() => _saving = true);
    await widget.db.addJournalEntry(
      userId: widget.userId,
      personaId: widget.persona.id!,
      prompt: _prompt,
      body: _body.text.trim(),
    );
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final prompts = journalPromptsFor(widget.persona.name);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.persona.emoji}  Journal'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Prompts (optional)',
              style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final p in prompts)
                ChoiceChip(
                  label: SizedBox(
                    width: 260,
                    child: Text(p.text, style: const TextStyle(fontSize: 13)),
                  ),
                  selected: _prompt == p.text,
                  onSelected: (sel) =>
                      setState(() => _prompt = sel ? p.text : null),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (_prompt != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('“$_prompt”',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            ),
          TextField(
            controller: _body,
            autofocus: true,
            minLines: 6,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Write freely…',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'A short reflection is plenty. This is a tool for personal growth, '
            'not therapy — entries stay private on this device, and it\'s okay '
            'to stop anytime.',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }
}
