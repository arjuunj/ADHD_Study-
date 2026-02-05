import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../chat/chat_widget.dart';

class SubjectDetailPage extends StatefulWidget {
  final String bigTaskTitle;

  const SubjectDetailPage({super.key, required this.bigTaskTitle});

  @override
  State<SubjectDetailPage> createState() => _SubjectDetailPageState();
}

class _SubjectDetailPageState extends State<SubjectDetailPage> {
  final List<Map<String, dynamic>> _microTasks = [
    {'title': 'Open document', 'isDone': false},
    {'title': 'Write introduction', 'isDone': false},
    {'title': 'Research main topic', 'isDone': false},
    {'title': 'Draft body paragraphs', 'isDone': false},
    {'title': 'Write conclusion', 'isDone': false},
    {'title': 'Proofread', 'isDone': false},
  ];

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  double get _progress {
    if (_microTasks.isEmpty) return 0.0;
    final completed = _microTasks.where((t) => t['isDone']).length;
    return completed / _microTasks.length;
  }

  void _checkProgress() {
    if (_progress == 1.0) {
      _confettiController.play();
    }
  }

  Widget _buildTasksTab() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Break it down!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              LinearPercentIndicator(
                lineHeight: 20.0,
                percent: _progress,
                center: Text(
                  "${(_progress * 100).toInt()}%",
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                barRadius: const Radius.circular(10),
                backgroundColor: Colors.grey[300],
                progressColor: Colors.blueAccent,
                animation: true,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: _microTasks.length,
                  itemBuilder: (context, index) {
                    final task = _microTasks[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: CheckboxListTile(
                        title: Text(
                          task['title'],
                          style: TextStyle(
                            decoration: task['isDone']
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        value: task['isDone'],
                        onChanged: (val) {
                          setState(() {
                            task['isDone'] = val;
                          });
                          if (val == true) {
                            _checkProgress();
                          }
                        },
                        secondary: const Icon(
                          Icons.flash_on,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.bigTaskTitle),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'Tasks'),
              Tab(icon: Icon(Icons.school), text: 'AI Tutor'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTasksTab(),
            Container(
              color: Colors.grey[50], // Light background for chat area
              child: SafeArea(child: ChatWidget(subject: widget.bigTaskTitle)),
            ),
          ],
        ),
      ),
    );
  }
}
