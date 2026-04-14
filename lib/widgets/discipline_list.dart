// lib/widgets/discipline_list.dart

import 'package:flutter/material.dart';
import '../models/discipline_model.dart';

// Widget responsável APENAS por exibir a lista de disciplinas.
// Recebe os dados prontos e callbacks para as ações de editar e deletar.
class DisciplineList extends StatelessWidget {
  final bool isLoading;
  final List<Discipline> disciplines;
  final void Function(Discipline discipline) onEdit;
  final void Function(String title) onDelete;

  const DisciplineList({
    super.key,
    required this.isLoading,
    required this.disciplines,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.black));
    }

    if (disciplines.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Text(
            'Nenhuma disciplina cadastrada.',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: disciplines.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final discipline = disciplines[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            discipline.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Vagas: ${discipline.seats} | Verão: ${discipline.isSummer ? "Sim" : "Não"}',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'Edit',
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => onEdit(discipline),
              ),
              IconButton(
                tooltip: 'Delete',
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => onDelete(discipline.title),
              ),
            ],
          ),
        );
      },
    );
  }
}