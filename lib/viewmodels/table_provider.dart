import 'package:flutter/material.dart';
import '../model/table_model.dart';

enum TableActionMode { normal, move, merge }

class TableProvider extends ChangeNotifier {
  List<TableModel> tables = [];

  TableActionMode mode = TableActionMode.normal;

  TableModel? selectedTableForMove;
  List<TableModel> selectedTablesForMerge = [];

  TableProvider() {
    _generateMockData();
  }

  void _generateMockData() {
    tables = List.generate(12, (index) {
      return TableModel(
        id: index.toString(),
        name: "Table ${index + 1}",
        seats: 4,
        totalAmount: index % 3 == 0 ? 120 : 0,
        minutesOpened: index % 3 == 0 ? 25 : 0,
        hasActiveOrder: index % 3 == 0,
      );
    });
  }

  // ================= MOVE =================

  void startMove(TableModel table) {
    if (!table.hasActiveOrder) return;

    selectedTableForMove = table;
    selectedTablesForMerge.clear();
    mode = TableActionMode.move;

    notifyListeners();
  }

  void moveTo(TableModel target) {
    if (mode != TableActionMode.move) return;
    if (selectedTableForMove == null) return;

    // ❌ cannot move to non-empty table
    if (target.hasActiveOrder) return;

    // Transfer data
    target.totalAmount = selectedTableForMove!.totalAmount;
    target.minutesOpened = selectedTableForMove!.minutesOpened;
    target.hasActiveOrder = true;

    // Clear source
    selectedTableForMove!.clear();

    // Reset state
    selectedTableForMove = null;
    mode = TableActionMode.normal;

    notifyListeners();
  }

  void cancelMove() {
    selectedTableForMove = null;
    mode = TableActionMode.normal;
    notifyListeners();
  }

  // ================= MERGE =================

  void startMergeMode() {
    selectedTableForMove = null;
    selectedTablesForMerge.clear();
    mode = TableActionMode.merge;

    notifyListeners();
  }

  void toggleMergeSelection(TableModel table) {
    if (mode != TableActionMode.merge) return;

    // ❌ only tables with active orders
    if (!table.hasActiveOrder) return;

    if (selectedTablesForMerge.contains(table)) {
      selectedTablesForMerge.remove(table);
    } else {
      selectedTablesForMerge.add(table);
    }

    notifyListeners();
  }

  void mergeTables() {
    if (mode != TableActionMode.merge) return;

    // ❌ at least 2 tables
    if (selectedTablesForMerge.length < 2) return;

    double combinedTotal = 0;

    for (var table in selectedTablesForMerge) {
      combinedTotal += table.totalAmount;
    }

    // First table keeps total
    final mainTable = selectedTablesForMerge.first;
    mainTable.totalAmount = combinedTotal;

    // Others become empty
    for (int i = 1; i < selectedTablesForMerge.length; i++) {
      selectedTablesForMerge[i].clear();
    }

    selectedTablesForMerge.clear();
    mode = TableActionMode.normal;

    notifyListeners();
  }

  void cancelMerge() {
    selectedTablesForMerge.clear();
    mode = TableActionMode.normal;
    notifyListeners();
  }
}
