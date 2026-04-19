import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/admin_provider.dart';
import '../../../models/carer_model.dart';
import '../../../models/medical_model.dart';

class CreateUserDialog extends StatefulWidget {
  const CreateUserDialog({super.key});

  @override
  State<CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  final username = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final birthdate = TextEditingController();
  final lastnames = TextEditingController();
  final phone = TextEditingController();
  final grade = TextEditingController();
  final lastVisit = TextEditingController();
  final title = TextEditingController();
  final department = TextEditingController();

  Medical? selectedMedical;
  List<Carer> selectedCarers = [];
  String gender = "UNKNOWN";
  String role = "MEDICAL";
  bool professional = false;

  void _onRoleChanged(String newRole) {
    if (role == newRole) return;

    setState(() {
      role = newRole;

      // Limpia campos dependientes del rol para no arrastrar datos.
      birthdate.clear();
      grade.clear();
      lastVisit.clear();
      selectedMedical = null;
      selectedCarers = [];

      title.clear();
      department.clear();

      professional = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 760;

    return AlertDialog(
      title: const Text("Nuevo Usuario"),

      content: SizedBox(
        width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _responsiveTwoFields(
                isMobile: isMobile,
                first: TextField(
                  controller: username,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                second: TextField(
                  controller: password,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
              ),
              SizedBox(height: isMobile ? 20 : 50),
              _responsiveTwoFields(
                isMobile: isMobile,
                first: TextField(
                  controller: name,
                  decoration: const InputDecoration(labelText: "Nombre"),
                ),
                second: TextField(
                  controller: lastnames,
                  decoration: const InputDecoration(labelText: "Apellidos"),
                ),
              ),
              SizedBox(height: isMobile ? 20 : 50),
              _responsiveTwoFields(
                isMobile: isMobile,
                first: TextField(
                  controller: email,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                second: TextField(
                  controller: phone,
                  decoration: const InputDecoration(labelText: "Teléfono"),
                ),
              ),
              SizedBox(height: isMobile ? 20 : 50),
              _responsiveTwoFields(
                isMobile: isMobile,
                first: DropdownButtonFormField<String>(
                  initialValue: gender,
                  onChanged: (v) => setState(() => gender = v!),
                  items: const [
                    DropdownMenuItem(value: "MALE", child: Text("Masculino")),
                    DropdownMenuItem(value: "FEMALE", child: Text("Femenino")),
                    DropdownMenuItem(
                      value: "UNKNOWN",
                      child: Text("No especificado"),
                    ),
                  ],
                  decoration: const InputDecoration(labelText: "Género"),
                ),
                second: DropdownButtonFormField<String>(
                  initialValue: role,
                  onChanged: (v) {
                    if (v != null) _onRoleChanged(v);
                  },
                  items: const [
                    DropdownMenuItem(value: "MEDICAL", child: Text("Médico")),
                    DropdownMenuItem(value: "PATIENT", child: Text("Paciente")),
                    DropdownMenuItem(value: "CARER", child: Text("Cuidador")),
                  ],
                  decoration: const InputDecoration(labelText: "Rol"),
                ),
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
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (date != null) {
                      setState(() {
                        birthdate.text = date.toIso8601String().split('T')[0];
                      });
                    }
                  },
                ),
                const SizedBox(height: 25),

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
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (date != null) {
                      setState(() {
                        lastVisit.text = date.toIso8601String().split('T')[0];
                      });
                    }
                  },
                ),

                const SizedBox(height: 20),

                // MEDICAL SELECT
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

                    itemBuilder: (context, item, isSelected) {
                      return ListTile(
                        title: Text(
                          "${item.name ?? ''} ${item.lastnames ?? ''}",
                        ),
                        subtitle: Text(item.username),
                      );
                    },
                  ),

                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Médico",
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // CARERS MULTI SELECT (simple versión)
                DropdownSearch<Carer>.multiSelection(
                  items: context.read<AdminProvider>().carers,
                  selectedItems: selectedCarers,

                  itemAsString: (c) => "${c.name ?? ''} ${c.lastnames ?? ''}",

                  onChanged: (List<Carer> values) {
                    setState(() {
                      selectedCarers = values;
                    });
                  },

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
              if (role == "MEDICAL") ...[
                const SizedBox(height: 25),
                _responsiveTwoFields(
                  isMobile: isMobile,
                  first: TextField(
                    controller: title,
                    decoration: const InputDecoration(labelText: "Título"),
                  ),
                  second: TextField(
                    controller: department,
                    decoration: const InputDecoration(
                      labelText: "Departamento",
                    ),
                  ),
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
          ),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),

        ElevatedButton(
          onPressed: () async {
            final provider = context.read<AdminProvider>();

            if (username.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Nombre de usuario obligatorio")),
              );
              return;
            }

            if (role == "PATIENT" && birthdate.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Fecha de nacimiento obligatoria"),
                ),
              );
              return;
            }

            try {
              await provider.createUser({
                "username": username.text,
                "name": name.text,
                "lastnames": lastnames.text,
                "email": email.text.isEmpty ? null : email.text,
                "phone": phone.text.isEmpty ? null : phone.text,
                "password": password.text,
                "type": role,
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
                  "department": department.text.isEmpty
                      ? null
                      : department.text,
                },
                if (role == "CARER") ...{"professional": professional},
              });

              if (!context.mounted) return;

              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(e.toString())));
            }
          },
          child: const Text("Crear"),
        ),
      ],
    );
  }

  Widget _responsiveTwoFields({
    required bool isMobile,
    required Widget first,
    required Widget second,
  }) {
    if (isMobile) {
      return Column(children: [first, const SizedBox(height: 16), second]);
    }

    return Row(
      children: [
        Expanded(child: first),
        const SizedBox(width: 50),
        Expanded(child: second),
      ],
    );
  }
}
