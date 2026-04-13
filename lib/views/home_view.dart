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

  // Control variable to know if we are creating or editing
  // Variável de controle para saber se estamos a criar ou a editar
  String? _editingTitle;

  @override
  void initState() {
    super.initState();
    // This runs as soon as the screen is loaded
    // Isto corre assim que o ecrã é carregado.
    // Usamos o addPostFrameCallback para garantir que a UI está pronta antes de pedir à API.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.loadDisciplines();
    });
  }

  void _saveDiscipline() async {
    // Basic validation
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

    // Se _editingTitle tiver valor, significa que estamos no modo de edição
    if (_editingTitle != null) {
      await widget.viewModel.updateDiscipline(_editingTitle!, discipline);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Disciplina atualizada com sucesso')),
        );
      }
    } else {
      // Caso contrário, é uma criação nova
      await widget.viewModel.addDiscipline(discipline);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Disciplina criada com sucesso')),
        );
      }
    }

    // Limpa o formulário após salvar/atualizar
    if (mounted) {
      _clearForm();
    }
  }

  // Preenche os campos do formulário com os dados da disciplina selecionada
  void _editDiscipline(Discipline discipline) {
    setState(() {
      _editingTitle = discipline.title;
      _titleController.text = discipline.title;
      // Formatando as datas de volta para 'YYYY-MM-DD' para preencher o input
      _startDateController.text = discipline.startDate.toIso8601String().split('T').first;
      _endDateController.text = discipline.endDate.toIso8601String().split('T').first;
      _seatsController.text = discipline.seats.toString();
      _isSummer = discipline.isSummer;
    });
  }

  void _deleteDiscipline(String title) async {
    await widget.viewModel.deleteDiscipline(title);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Disciplina removida')),
      );
    }
  }

  // Helper method to clear the form
  // Método auxiliar para limpar o formulário e sair do modo de edição
  void _clearForm() {
    _titleController.clear();
    _startDateController.clear();
    _endDateController.clear();
    _seatsController.clear();
    setState(() {
      _isSummer = false;
      _editingTitle = null; // Sai do modo de edição
    });
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
          Text(
            // O Título da caixa muda dinamicamente se estamos a editar
            _editingTitle != null ? 'Editar Disciplina' : 'Nova Disciplina',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveDiscipline,
                  child: const Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ),
              // Mostra botão de cancelar apenas se estiver a editar para limpar e voltar ao modo "Nova Disciplina"
              if (_editingTitle != null) ...[
                const SizedBox(width: 16),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _clearForm,
                  child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                ),
              ]
            ],
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min, // Mantém os ícones juntos
            children: [
              // Ícone de Editar
              IconButton(
                tooltip: 'Edit',
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => _editDiscipline(discipline),
              ),
              // Ícone de Deletar
              IconButton(
                tooltip: 'Delete',
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _deleteDiscipline(discipline.title),
              ),
            ],
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