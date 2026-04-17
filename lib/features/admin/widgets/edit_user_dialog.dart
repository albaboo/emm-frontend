// lib/ui/screens/admin/widgets/edit_user_dialog.dart

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/admin_provider.dart';
import '../../../models/carer_model.dart';
import '../../../models/medical_model.dart';
import '../../../models/patient_model.dart';

class EditUserDialog extends StatefulWidget {
  final int userId;

  const EditUserDialog({super.key, required this.userId});

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final name = TextEditingController();
  final lastnames = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final birthdate = TextEditingController();
  final grade = TextEditingController();
  final lastVisit = TextEditingController();
  final title = TextEditingController();
  final department = TextEditingController();

  Medical? selectedMedical;
  List<Carer> selectedCarers = [];
  String gender = 'UNKNOWN';
  String role = '';
  bool professional = false;

  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await context.read<AdminProvider>().getUser(widget.userId);

      // Rellena todos los campos con los datos que llegaron del servidor
      name.text = user.name ?? '';
      lastnames.text = user.lastnames ?? '';
      email.text = user.email ?? '';
      phone.text = user.phone ?? '';
      gender = user.gender?.value ?? 'UNKNOWN';
      role = user.type.value;

      if (user is Patient) {
        birthdate.text = user.birthdate?.toIso8601String().split('T')[0] ?? '';
        grade.text = user.grade ?? '';
        lastVisit.text = user.lastVisit?.toIso8601String().split('T')[0] ?? '';
        selectedMedical = user.medical;
        selectedCarers = List.from(user.carers ?? []);
      }

      if (user is Medical) {
        title.text = user.title ?? '';
        department.text = user.department ?? '';
      }

      if (user is Carer) {
        professional = user.professional;
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    name.dispose();
    lastnames.dispose();
    email.dispose();
    phone.dispose();
    birthdate.dispose();
    grade.dispose();
    lastVisit.dispose();
    title.dispose();
    department.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Editar Usuario"),
      content: SizedBox(
        width: 600,
        child: _loading
            ? const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              )
            : _error != null
            ? SizedBox(height: 200, child: Center(child: Text(_error!)))
            : SingleChildScrollView(child: _buildForm(context)),
      ),
      actions: _loading || _error != null
          ? [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cerrar"),
              ),
            ]
          : [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(onPressed: _submit, child: const Text("Guardar")),
            ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: name,
                decoration: const InputDecoration(labelText: "Nombre"),
              ),
            ),
            const SizedBox(width: 50),
            Expanded(
              child: TextField(
                controller: lastnames,
                decoration: const InputDecoration(labelText: "Apellidos"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: email,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ),
            const SizedBox(width: 50),
            Expanded(
              child: TextField(
                controller: phone,
                decoration: const InputDecoration(labelText: "Teléfono"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        DropdownButtonFormField<String>(
          initialValue: gender,
          onChanged: (v) => setState(() => gender = v!),
          items: const [
            DropdownMenuItem(value: "MALE", child: Text("Masculino")),
            DropdownMenuItem(value: "FEMALE", child: Text("Femenino")),
            DropdownMenuItem(value: "UNKNOWN", child: Text("No especificado")),
          ],
          decoration: const InputDecoration(labelText: "Género"),
        ),
        if (role == "PATIENT") ...[
          const SizedBox(height: 25),
          TextField(
            controller: birthdate,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: "Fecha de nacimiento",
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate:
                    DateTime.tryParse(birthdate.text) ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                setState(
                  () => birthdate.text = date.toIso8601String().split('T')[0],
                );
              }
            },
          ),
          const SizedBox(height: 20),
          TextField(
            controller: grade,
            decoration: const InputDecoration(labelText: "Grado"),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: lastVisit,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: "Última visita",
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate:
                    DateTime.tryParse(lastVisit.text) ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                setState(
                  () => lastVisit.text = date.toIso8601String().split('T')[0],
                );
              }
            },
          ),
          const SizedBox(height: 20),
          DropdownSearch<Medical>(
            selectedItem: selectedMedical,
            items: context.read<AdminProvider>().medicals,
            itemAsString: (m) => "${m.name ?? ''} ${m.lastnames ?? ''}",
            onChanged: (v) => setState(() => selectedMedical = v),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: const TextFieldProps(
                decoration: InputDecoration(labelText: "Buscar médico"),
              ),
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.name ?? ''} ${item.lastnames ?? ''}"),
                subtitle: Text(item.username),
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(labelText: "Médico"),
            ),
          ),
          const SizedBox(height: 20),
          DropdownSearch<Carer>.multiSelection(
            items: context.read<AdminProvider>().carers,
            selectedItems: selectedCarers,
            itemAsString: (c) => "${c.name ?? ''} ${c.lastnames ?? ''}",
            onChanged: (values) => setState(() => selectedCarers = values),
            popupProps: PopupPropsMultiSelection.menu(
              showSearchBox: true,
              searchFieldProps: const TextFieldProps(
                decoration: InputDecoration(labelText: "Buscar cuidador"),
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Cuidadores",
              ),
            ),
          ),
        ],
        if (role == "MEDICAL") ... [
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: title,
                  decoration: const InputDecoration(labelText: "Titulo"),
                ),
              ),
              const SizedBox(width: 50),
              Expanded(
                child: TextField(
                  controller: department,
                  decoration: const InputDecoration(labelText: "Departamento"),
                ),
              ),
            ],
          ),
        ],
        if (role == "CARER") ...[
          const SizedBox(height: 25),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Cuidador profesional"),
            value: professional,
            onChanged: (value) => setState(() => professional = value),
          ),
        ],
      ],
    );
  }

  Future<void> _submit() async {
    final provider = context.read<AdminProvider>();
    try {
      await provider.updateUser(widget.userId, {
        "name": name.text,
        "lastnames": lastnames.text,
        "email": email.text.isEmpty ? null : email.text,
        "phone": phone.text.isEmpty ? null : phone.text,
        "gender": gender,
        if (role == "PATIENT") ...{
          "birthdate": birthdate.text,
          "grade": grade.text.isEmpty ? null : grade.text,
          "lastVisit": lastVisit.text.isEmpty ? null : lastVisit.text,
          "medical": selectedMedical?.toJson(),
          "carers": selectedCarers.map((c) => c.toJson()).toList(),
        },
        if (role == "MEDICAL") ...{
          "title": title.text.isEmpty ? null : title.text,
          "department": department.text.isEmpty ? null : department.text,
        },
        if (role == "CARER") ...{
          "professional": professional,
        },
      });
      if (!context.mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
