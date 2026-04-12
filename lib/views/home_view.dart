import 'package:flutter/material.dart';
import '../models/discipline_model.dart';
import '../viewmodels/discipline_viewmodel.dart';

class HomeView extends StatefulWidget {
  final DisciplineViewModel viewModel;

  const HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _titleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _seatsController = TextEditingController();

  bool _isSummer = false;

  void _saveDiscipline() async {
    // Validação básica
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O título é obrigatório', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
      );
      return;
    }

    final discipline = Discipline(
      title: _titleController.text,
      startDate: DateTime.tryParse(_startDateController.text) ?? DateTime.now(),
      endDate: DateTime.tryParse(_endDateController.text) ?? DateTime.now(),
      seats: int.tryParse(_seatsController.text) ?? 0,
      isSummer: _isSummer,
    );

    await widget.viewModel.addDiscipline(discipline);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Disciplina criada com sucesso')),
      );
      _titleController.clear();
      _startDateController.clear();
      _endDateController.clear();
      _seatsController.clear();
      setState(() => _isSummer = false);
    }
  }

  void _deleteDiscipline(String title) async {
    await widget.viewModel.deleteDiscipline(title);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Disciplina removida')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Academic'), // Nome corrigido!
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          // LayoutBuilder detecta o tamanho da tela para ser responsivo
          return LayoutBuilder(
            builder: (context, constraints) {
              // Se a tela for larga (Web/Desktop), dividimos em duas colunas
              bool isDesktop = constraints.maxWidth > 800;

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  // SingleChildScrollView previne o erro de overflow (faixas amarelas)
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

  // Extraímos o formulário para um widget separado para organizar o código
  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nova Disciplina',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildTextField('Title', _titleController),
          _buildTextField('Start Date', _startDateController, hint: 'YYYY-MM-DD'),
          _buildTextField('End Date', _endDateController, hint: 'YYYY-MM-DD'),
          _buildTextField('Seats', _seatsController, isNumber: true),

          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Curso de Verão', style: TextStyle(fontWeight: FontWeight.w500)),
              Switch(
                value: _isSummer,
                activeColor: Colors.black,
                onChanged: (val) => setState(() => _isSummer = val),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveDiscipline,
              child: const Text('Save', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  // Extraímos a lista para um widget separado
  Widget _buildList() {
    if (widget.viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.black));
    }

    if (widget.viewModel.disciplines.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Text('Nenhuma disciplina cadastrada.', style: TextStyle(color: Colors.black54)),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true, // Importante quando ListView está dentro de um ScrollView
      physics: const NeverScrollableScrollPhysics(), // Desativa o scroll interno da lista
      itemCount: widget.viewModel.disciplines.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final discipline = widget.viewModel.disciplines[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(discipline.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Vagas: ${discipline.seats} | Verão: ${discipline.isSummer ? "Sim" : "Não"}'),
          trailing: IconButton(
            tooltip: 'Delete',
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _deleteDiscipline(discipline.title),
          ),
        );
      },
    );
  }

  // Campo de texto padronizado
  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false, String? hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}