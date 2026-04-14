// lib/widgets/discipline_form.dart

import 'package:flutter/material.dart';
import '../models/discipline_model.dart';

// Widget responsável APENAS por exibir e controlar o formulário de disciplinas.
// Recebe callbacks para notificar a HomeView quando o usuário salvar ou cancelar.
class DisciplineForm extends StatefulWidget {
  final Discipline? disciplineToEdit; // null = modo criação, preenchido = modo edição
  final void Function(Discipline discipline, String? editingTitle) onSave;
  final VoidCallback onCancel;

  const DisciplineForm({
    super.key,
    required this.onSave,
    required this.onCancel,
    this.disciplineToEdit,
  });

  @override
  State<DisciplineForm> createState() => _DisciplineFormState();
}

class _DisciplineFormState extends State<DisciplineForm> {
  final _titleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _seatsController = TextEditingController();
  bool _isSummer = false;

  // Guarda o título original ao entrar no modo de edição
  String? _editingTitle;

  @override
  void initState() {
    super.initState();
    _populateFromDiscipline(widget.disciplineToEdit);
  }

  // Quando a HomeView passa uma nova disciplina para editar, reagimos aqui
  @override
  void didUpdateWidget(DisciplineForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.disciplineToEdit != oldWidget.disciplineToEdit) {
      _populateFromDiscipline(widget.disciplineToEdit);
    }
  }

  void _populateFromDiscipline(Discipline? discipline) {
    if (discipline != null) {
      _editingTitle = discipline.title;
      _titleController.text = discipline.title;
      _startDateController.text = discipline.startDate.toIso8601String().split('T').first;
      _endDateController.text = discipline.endDate.toIso8601String().split('T').first;
      _seatsController.text = discipline.seats.toString();
      setState(() => _isSummer = discipline.isSummer);
    } else {
      _clearFields();
    }
  }

  void _clearFields() {
    _editingTitle = null;
    _titleController.clear();
    _startDateController.clear();
    _endDateController.clear();
    _seatsController.clear();
    setState(() => _isSummer = false);
  }

  void _handleSave() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O título é obrigatório', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
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

    widget.onSave(discipline, _editingTitle);
    _clearFields();
  }

  void _handleCancel() {
    _clearFields();
    widget.onCancel();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _seatsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _editingTitle != null;

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
            isEditing ? 'Editar Disciplina' : 'Nova Disciplina',
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
                  onPressed: _handleSave,
                  child: const Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ),
              if (isEditing) ...[
                const SizedBox(width: 16),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _handleCancel,
                  child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        bool isNumber = false,
        String? hint,
      }) {
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