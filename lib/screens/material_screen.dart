import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_workshop_manager/blocs/material/material_bloc.dart' as bloc;
import 'package:gold_workshop_manager/models/material.dart' as model;

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _karatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المواد الخام'),
      ),
      body: BlocBuilder<bloc.MaterialBloc, bloc.MaterialState>(
        builder: (context, state) {
          if (state is bloc.MaterialLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is bloc.MaterialLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'اسم المادة'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _karatController,
                          decoration: const InputDecoration(labelText: 'العيار'),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          final newMaterial = model.Material(
                            id: '', // Supabase will generate this
                            name: _nameController.text,
                            karat: _karatController.text,
                            createdAt: DateTime.now(),
                          );
                          context.read<bloc.MaterialBloc>().add(bloc.AddMaterial(newMaterial));
                          _nameController.clear();
                          _karatController.clear();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.materials.length,
                    itemBuilder: (context, index) {
                      final material = state.materials[index];
                      return ListTile(
                        title: Text(material.name),
                        subtitle: Text(material.karat),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<bloc.MaterialBloc>().add(bloc.DeleteMaterial(material.id));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is bloc.MaterialError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('لا توجد مواد لعرضها'));
        },
      ),
    );
  }
}

