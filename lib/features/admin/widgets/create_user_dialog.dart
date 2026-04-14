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

  String role = "MEDICAL";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nuevo Usuario"),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: username,
            decoration: const InputDecoration(labelText: "Username"),
          ),
          TextField(
            controller: name,
            decoration: const InputDecoration(labelText: "Nombre"),
          ),
          TextField(
            controller: email,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(labelText: "Password"),
          ),

          if (role == "PATIENT")
            GestureDetector(
              onTap: () async {
                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (selectedDate != null) {
                  setState(() {
                    birthdate.text =
                    selectedDate.toIso8601String().split('T')[0];
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: birthdate,
                  decoration: const InputDecoration(
                    labelText: "Fecha de nacimiento",
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),

          const SizedBox(height: 10),

          DropdownButton<String>(
            value: role,
            onChanged: (v) => setState(() => role = v!),
            items: const [
              DropdownMenuItem(value: "MEDICAL", child: Text("Médico")),
              DropdownMenuItem(value: "PATIENT", child: Text("Paciente")),
              DropdownMenuItem(value: "CARER", child: Text("Cuidador")),
            ],
          ),
        ],
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
                const SnackBar(content: Text("Fecha de nacimiento obligatoria")),
              );
              return;
            }

            try {
              await provider.createUser({
                "username": username.text,
                "name": name.text,
                "email": email.text,
                "password": password.text,
                "type": role,
                if (role == "PATIENT") "birthdate": birthdate.text,
              });

              if (!context.mounted) return;

              Navigator.pop(context);

            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          },
          child: const Text("Crear"),
        ),
      ],
    );
  }
}
