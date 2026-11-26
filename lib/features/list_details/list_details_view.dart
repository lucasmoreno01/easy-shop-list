import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListDetailsView extends ConsumerWidget {
  const ListDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Lista'),
        centerTitle: false,
      ),
      body: const Center(child: Text('Detalhes da Lista')),
    );
  }
}
