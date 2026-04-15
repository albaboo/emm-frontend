import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/admin_provider.dart';

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

  String gender = "UNKNOWN";
  String role = "MEDICAL";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nuevo Usuario"),

      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: username,
                      decoration: const InputDecoration(labelText: "Username"),
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: TextField(
                      controller: password,
                      decoration: const InputDecoration(labelText: "Password"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
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
              const SizedBox(height: 50),
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
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: gender,
                      onChanged: (v) => setState(() => gender = v!),
                      items: const [
                        DropdownMenuItem(
                          value: "MALE",
                          child: Text("Masculino"),
                        ),
                        DropdownMenuItem(
                          value: "FEMALE",
                          child: Text("Femenino"),
                        ),
                        DropdownMenuItem(
                          value: "UNKNOWN",
                          child: Text("No especificado"),
                        ),
                      ],
                      decoration: const InputDecoration(labelText: "Género"),
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: role,
                      onChanged: (v) => setState(() => role = v!),
                      items: const [
                        DropdownMenuItem(
                          value: "MEDICAL",
                          child: Text("Médico"),
                        ),
                        DropdownMenuItem(
                          value: "PATIENT",
                          child: Text("Paciente"),
                        ),
                        DropdownMenuItem(
                          value: "CARER",
                          child: Text("Cuidador"),
                        ),
                      ],
                      decoration: const InputDecoration(labelText: "Rol"),
                    ),
                  ),
                ],
              ),
              if (role == "PATIENT")
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
                if (role == "PATIENT") "birthdate": birthdate.text,
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
}
