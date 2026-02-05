import 'package:flutter/material.dart';
import '../../widgets/glass_container.dart';

class BrainDumpSheet extends StatefulWidget {
  const BrainDumpSheet({super.key});

  @override
  State<BrainDumpSheet> createState() => _BrainDumpSheetState();
}

class _BrainDumpSheetState extends State<BrainDumpSheet> {
  final _controller = TextEditingController();

  void _saveForLater() {
    if (_controller.text.isNotEmpty) {
      // Logic to save to a "Later" list (mocked here)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved "${_controller.text}" for later!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: GlassContainer(
        opacity: 0.9, // Higher opacity to be readable over content
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Brain Dump \uD83E\uDDE0',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'What\'s checking on your mind?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _saveForLater,
                    child: const Text('Save for Later'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
