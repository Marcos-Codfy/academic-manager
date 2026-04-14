// lib/views/home_view.dart

import 'package:flutter/material.dart';
import '../models/discipline_model.dart';
import '../viewmodels/discipline_viewmodel.dart';
import '../widgets/discipline_form.dart';
import '../widgets/discipline_list.dart';

// A HomeView agora é apenas um ORQUESTRADOR.
// Ela não sabe como desenhar o formulário nem a lista —
// delega isso para DisciplineForm e DisciplineList respectivamente.
class HomeView extends StatefulWidget {
  final DisciplineViewModel viewModel;

  const HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Disciplina sendo editada no momento (null = modo criação)
  Discipline? _disciplineToEdit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.loadDisciplines();
    });
  }

  // Chamado pelo DisciplineForm quando o usuário clica em "Save"
  void _handleSave(Discipline discipline, String? editingTitle) async {
    if (editingTitle != null) {
      await widget.viewModel.updateDiscipline(editingTitle, discipline);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Disciplina atualizada com sucesso')),
        );
      }
    } else {
      await widget.viewModel.addDiscipline(discipline);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Disciplina criada com sucesso')),
        );
      }
    }
    setState(() => _disciplineToEdit = null);
  }

  // Chamado pelo DisciplineList quando o usuário clica em editar
  void _handleEdit(Discipline discipline) {
    setState(() => _disciplineToEdit = discipline);
  }

  // Chamado pelo DisciplineList quando o usuário clica em deletar
  void _handleDelete(String title) async {
    await widget.viewModel.deleteDiscipline(title);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Disciplina removida')),
      );
    }
  }

  // Chamado pelo DisciplineForm quando o usuário clica em "Cancel"
  void _handleCancel() {
    setState(() => _disciplineToEdit = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Academic'),
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 800;

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: isDesktop
                        ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: _buildForm()),
                        const SizedBox(width: 32),
                        Expanded(flex: 1, child: _buildList()),
                      ],
                    )
                        : Column(
                      children: [
                        _buildForm(),
                        const SizedBox(height: 32),
                        _buildList(),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildForm() {
    return DisciplineForm(
      disciplineToEdit: _disciplineToEdit,
      onSave: _handleSave,
      onCancel: _handleCancel,
    );
  }

  Widget _buildList() {
    return DisciplineList(
      isLoading: widget.viewModel.isLoading,
      disciplines: widget.viewModel.disciplines,
      onEdit: _handleEdit,
      onDelete: _handleDelete,
    );
  }
}