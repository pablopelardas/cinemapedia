import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  FullScreenLoader({super.key});

  final messages = <String>[
    'Loading movies',
    'Buying popcorn',
    'Buying soda',
    'Calling to the cinema',
    'Asking for the tickets',
    'Asking for the best seats',
    'Asking for the best popcorn',
    'This is taking too long',
  ];

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(milliseconds: 1200), (x) {
      if (x >= messages.length) {
        return messages[0];
      } else {
        return messages[x];
      }
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),

          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading... Please wait.');
              }
              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
