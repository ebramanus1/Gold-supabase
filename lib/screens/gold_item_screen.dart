import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_workshop_manager/blocs/gold_item/gold_item_bloc.dart';
import 'package:gold_workshop_manager/models/gold_item.dart';

class GoldItemScreen extends StatefulWidget {
  const GoldItemScreen({super.key});

  @override
  State<GoldItemScreen> createState() => _GoldItemScreenState();
}

class _GoldItemScreenState extends State<GoldItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _materialIdController = TextEditingController();
  final TextEditingController _karatController = TextEditingController();

  final TextEditingController _searchKaratController = TextEditingController();
  final TextEditingController _searchStatusController = TextEditingController();
  DateTime? _searchStartDate;
  DateTime? _searchEndDate;

  @override
  void initState() {
    super.initState();
    _loadGoldItems();
  }

  void _loadGoldItems() {
    context.read<GoldItemBloc>().add(LoadGoldItems(
          karat: _searchKaratController.text,
          startDate: _searchStartDate,
          endDate: _searchEndDate,
          status: _searchStatusController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة القطع الذهبية'),
      ),
      body: BlocBuilder<GoldItemBloc, GoldItemState>(
        builder: (context, state) {
          if (state is GoldItemLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GoldItemLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'اسم القطعة'),
                      ),
                      TextField(
                        controller: _weightController,
                        decoration: const InputDecoration(labelText: 'الوزن'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: _statusController,
                        decoration: const InputDecoration(labelText: 'الحالة'),
                      ),
                      TextField(
                        controller: _materialIdController,
                        decoration: const InputDecoration(labelText: 'معرف المادة'),
                      ),
                      TextField(
                        controller: _karatController,
                        decoration: const InputDecoration(labelText: 'العيار'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final newGoldItem = GoldItem(
                            id: '', // Supabase will generate this
                            name: _nameController.text,
                            materialId: _materialIdController.text,
                            karat: _karatController.text,
                            weight: double.parse(_weightController.text),
                            status: _statusController.text,
                            createdAt: DateTime.now(),
                          );
                          context.read<GoldItemBloc>().add(AddGoldItem(newGoldItem));
                          _nameController.clear();
                          _weightController.clear();
                          _statusController.clear();
                          _materialIdController.clear();
                          _karatController.clear();
                        },
                        child: const Text('إضافة قطعة ذهبية'),
                      ),
                      const Divider(),
                      TextField(
                        controller: _searchKaratController,
                        decoration: const InputDecoration(labelText: 'بحث حسب العيار'),
                      ),
                      TextField(
                        controller: _searchStatusController,
                        decoration: const InputDecoration(labelText: 'بحث حسب الحالة'),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: _searchStartDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null && picked != _searchStartDate) {
                                  setState(() {
                                    _searchStartDate = picked;
                                  });
                                }
                              },
                              child: Text(_searchStartDate == null
                                  ? 'تاريخ البدء'
                                  : _searchStartDate!.toLocal().toString().split(' ')[0]),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: _searchEndDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null && picked != _searchEndDate) {
                                  setState(() {
                                    _searchEndDate = picked;
                                  });
                                }
                              },
                              child: Text(_searchEndDate == null
                                  ? 'تاريخ الانتهاء'
                                  : _searchEndDate!.toLocal().toString().split(' ')[0]),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: _loadGoldItems,
                        child: const Text('بحث'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.goldItems.length,
                    itemBuilder: (context, index) {
                      final item = state.goldItems[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('الوزن: ${item.weight}, الحالة: ${item.status}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<GoldItemBloc>().add(DeleteGoldItem(item.id));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is GoldItemError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('لا توجد قطع ذهبية لعرضها'));
        },
      ),
    );
  }
}

