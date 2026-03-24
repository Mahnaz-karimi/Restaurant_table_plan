Solution Structure

I structured the project using a simple layered architecture to keep responsibilities clearly separated:

Model layer (TableModel)
Represents the table entity and holds its state (name, seats, total amount, time, active order status).

State & Business Logic layer (TableProvider)
Contains all application logic such as move, merge, activation rules, and mode management.
UI widgets do not contain business rules.

UI layer (TablePlanScreen, TableCard)
Responsible only for rendering data and forwarding user interactions to the provider.

This separation keeps the code clean, testable, and easy to maintain.

How I Manage State

I used Provider (ChangeNotifier) for state management.

The application uses a simple state machine with:

enum TableActionMode { normal, move, merge }

This ensures:

Only one interaction mode is active at a time

Move and Merge cannot conflict

UI reacts automatically through notifyListeners()

All state mutations happen inside the provider.
Widgets only call methods like:

startMove()

moveTo()

startMergeMode()

toggleMergeSelection()

mergeTables()

No global variables are used.

This keeps state predictable and centralized.

How I Handle Business Logic

All business rules are enforced inside the provider using early returns.

Examples:

Move is only allowed from a table with an active order.

Move is only allowed to an empty table.

Merge requires at least 2 selected tables.

Only tables with active orders can be merged.

The UI does not contain conditional business logic.
It only reacts to provider state.

This approach:

Keeps widgets simple

Makes logic testable

Avoids duplicated validation

How I Think About Edge Cases

I explicitly handled the following edge cases:

Attempting to move to a non-empty table.

Attempting to merge with an empty table.

Attempting to merge only one table.

Cancelling move or merge mode.

Preventing conflicting modes.

Each operation validates state before executing logic to prevent inconsistent UI or corrupted data.
