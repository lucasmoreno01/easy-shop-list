import 'package:easy_shop_list/features/list_details/list_details_view.dart';
import 'package:easy_shop_list/features/my_lists/my_lists_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyListsView extends ConsumerWidget {
  const MyListsView({super.key});

  Future<void> _showCreateListDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final name = await showDialog<String>(
      context: context,
      builder: (_) => const _CreateListDialog(),
    );

    if (name != null && context.mounted) {
      ref.read(myListsViewModelProvider.notifier).createList(name);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(myListsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Listas'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Configurações',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: lists.isEmpty
          ? const _EmptyListsState()
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: lists.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final list = lists[index];
                return Card(
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ListDetailsView(),
                      ),
                    ),
                    leading: Icon(
                      Icons.shopping_cart_outlined,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      list.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Row(children: [Text('${list.qtdItens} itens')]),
                    trailing: IconButton(
                      tooltip: 'Excluir lista',
                      icon: Icon(
                        Icons.delete_outline,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () => ref
                          .read(myListsViewModelProvider.notifier)
                          .deleteList(list.id),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateListDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Nova lista'),
      ),
    );
  }
}

class _CreateListDialog extends StatefulWidget {
  const _CreateListDialog();

  @override
  State<_CreateListDialog> createState() => _CreateListDialogState();
}

class _CreateListDialogState extends State<_CreateListDialog> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_nameController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Criar lista',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nome da lista', style: Theme.of(context).textTheme.labelLarge),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Ex.: Compras da semana',
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Informe um nome para a lista'
                  : null,
              onFieldSubmitted: (_) => _submit(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Criar')),
      ],
    );
  }
}

class _EmptyListsState extends StatelessWidget {
  const _EmptyListsState();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_basket_outlined,
                size: 48,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Nenhuma lista por aqui',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Toque em “Nova lista” para organizar suas próximas compras.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
