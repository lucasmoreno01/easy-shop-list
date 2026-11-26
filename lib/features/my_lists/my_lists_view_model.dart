import 'package:easy_shop_list/features/my_lists/my_lists_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myListsViewModelProvider =
    NotifierProvider<MyListsViewModel, List<ListModel>>(MyListsViewModel.new);

class MyListsViewModel extends Notifier<List<ListModel>> {
  @override
  List<ListModel> build() => const [];

  void createList(String name) {
    if (name.isEmpty) return;

    final list = ListModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name.trim(),
    );
    state = [...state, list];
  }

  void deleteList(String id) {
    state = state.where((list) => list.id != id).toList();
  }
}
