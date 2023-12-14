import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: TwoLists(),
        ),
      ),
    );
  }
}

class TwoLists extends StatefulWidget {
  const TwoLists({super.key});

  @override
  State<TwoLists> createState() => _TwoListsState();
}

class _TwoListsState extends State<TwoLists> {
  List<String> left = [
        "first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "nineth"
      ],
      right = ["A"];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (_, constraints) => DragTarget<String>(
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        style: candidateData.isNotEmpty
                            ? BorderStyle.solid
                            : BorderStyle.none,
                        width: 3,
                      ),
                    ),
                    child: ListView(
                      children: [
                        for (final item in left)
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Draggable<String>(
                              data: item,
                              feedback: _ElementFeedback(
                                item: item,
                                width: constraints.maxWidth,
                              ),
                              child: _Element(item: item),
                            ),
                          ),
                      ],
                    ),
                  );
                },
                onWillAccept: (item) => !left.contains(item),
                onAccept: (item) {
                  setState(() {
                    if (!left.contains(item)) {
                      left.add(item);
                      right.remove(item);
                    }
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (_, constraints) => DragTarget<String>(
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        style: candidateData.isNotEmpty
                            ? BorderStyle.solid
                            : BorderStyle.none,
                        width: 3,
                      ),
                    ),
                    child: ListView(
                      children: [
                        for (final item in right)
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Draggable<String>(
                              data: item,
                              feedback: _ElementFeedback(
                                item: item,
                                width: constraints.maxWidth,
                              ),
                              child: _Element(item: item),
                            ),
                          ),
                      ],
                    ),
                  );
                },
                onWillAccept: (item) => !right.contains(item),
                onAccept: (item) {
                  setState(() {
                    if (!right.contains(item)) {
                      right.add(item);
                      left.remove(item);
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Element extends StatelessWidget {
  const _Element({
    required this.item,
  });

  final String item;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 40,
        color: Colors.grey[200],
        child: Text(item),
      ),
    );
  }
}

class _ElementFeedback extends StatelessWidget {
  const _ElementFeedback({
    required this.item,
    required this.width,
  });

  final String item;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        height: 40,
        width: width,
        color: Colors.blue,
        child: Text(
          item,
        ),
      ),
    );
  }
}
