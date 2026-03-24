import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/table_model.dart';
import '../viewmodels/table_provider.dart';

class TableCard extends StatelessWidget {
  final TableModel table;

  const TableCard({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TableProvider>();

    // Check if this table is selected for MOVE
    bool isSelectedForMove = provider.selectedTableForMove?.id == table.id;

    // Check if this table is selected for MERGE
    bool isSelectedForMerge = provider.selectedTablesForMerge.contains(table);

    return GestureDetector(
      onLongPress: () {
        // Start move only if table has active order
        provider.startMove(table);
      },
      onTap: () {
        // If we are in MOVE mode, try to move to this table
        if (provider.mode == TableActionMode.move) {
          provider.moveTo(table);
        }
        // If we are in MERGE mode, toggle selection
        else if (provider.mode == TableActionMode.merge) {
          provider.toggleMergeSelection(table);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: table.hasActiveOrder ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(12),

          // Blue border for selected table (move or merge)
          border: isSelectedForMove || isSelectedForMerge
              ? Border.all(color: Colors.blue, width: 4)
              : null,
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(table.name),
            Text("Seats: ${table.seats}"),
            Text("Total: ${table.totalAmount}"),
            Text("Time: ${table.minutesOpened} min"),
          ],
        ),
      ),
    );
  }
}
