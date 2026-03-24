import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/table_provider.dart';
import '../widgets/table_card.dart';

class TablePlanScreen extends StatelessWidget {
  const TablePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TableProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        // Dynamic title based on current mode
        title: provider.mode == TableActionMode.normal
            // NORMAL MODE → Show Merge button in center
            ? ElevatedButton.icon(
                onPressed: provider.startMergeMode,
                icon: const Icon(Icons.merge),
                label: const Text("Merge Tables"),
              )
            // MERGE MODE → Show Confirm & Cancel buttons
            : provider.mode == TableActionMode.merge
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: provider.mergeTables,
                    icon: const Icon(Icons.check),
                    label: const Text("Confirm"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: provider.cancelMerge,
                    icon: const Icon(Icons.close),
                    label: const Text("Cancel"),
                  ),
                ],
              )
            // MOVE MODE → Show cancel only
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Move Mode"),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: provider.cancelMove,
                    icon: const Icon(Icons.close),
                    label: const Text("Cancel"),
                  ),
                ],
              ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: provider.tables.length,
        itemBuilder: (context, index) {
          return TableCard(table: provider.tables[index]);
        },
      ),
    );
  }
}
