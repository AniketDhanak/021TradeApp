# 021 Trade – Watchlist Assignment

This project is a Flutter implementation of a stock watchlist inspired by the 021 Trade application. The main goal of this assignment is to implement **reordering of stocks within a watchlist using Flutter's BLoC architecture**, along with maintaining clean UI/UX and scalable code structure.

---

## 🎯 Assignment Objective

The core requirement was:

* Enable **reordering (swapping) of stocks** within a watchlist
* Use **Flutter BLoC architecture** for state management
* Maintain a **sample data structure** for stocks
* Focus on:

    * UI/UX quality
    * Responsiveness
    * Code quality & structure
    * Reusability
    * Type safety

---

## Features Implemented

* Multiple Watchlists (Tab-based navigation)
* Reordering of stocks using drag-and-drop
* Edit Watchlist (Rename + reorder stocks)
* BLoC-based state management
* Responsive UI (adapts to screen size)
* Clean and modern UI inspired by trading apps

---

## Reordering Implementation

Stock reordering is implemented using Flutter’s `ReorderableListView`.

### Flow:

1. User drags a stock item using the drag handle
2. UI updates instantly for smooth interaction
3. A `ReorderStocksEvent` is dispatched to the BLoC
4. BLoC updates the state immutably
5. Updated watchlist is reflected across the app

### Why this approach?

This approach ensures:

* Smooth and responsive UI interaction
* Proper separation of concerns
* BLoC remains the single source of truth

---

## State Management (BLoC)

The application uses **flutter_bloc** for predictable and scalable state management.

### Key Events:

* `LoadWatchlists` → Load initial data
* `SelectWatchlist` → Switch between tabs
* `UpdateWatchlist` → Update name or stocks
* `ReorderStocksEvent` → Handle stock reordering

### State:

* Maintains:

    * List of watchlists
    * Selected watchlist index
    * Loading state

---

## Project Structure

```bash
lib/
│
├── screen/
│   └── watchlist/
│       ├── bloc/
│       │   ├── watchlist_bloc.dart
│       │   ├── watchlist_event.dart
│       │   └── watchlist_state.dart
│       │
│       ├── data/
│       │   ├── model/
│       │   └── dummy/
│       │
│       └── presentation/
│           ├── watchlist_screen.dart
│           └── edit_watchlist_screen.dart
│
├── utils/
│   ├── app_colors.dart
│   └── utils.dart
│
└── main.dart
```

---

## Data Model

### Stock

```dart
class Stock {
  final String name;
  final String symbol;
  final double price;
  final double change;
}
```

### Watchlist

```dart
class Watchlist {
  final String name;
  final List<Stock> stocks;
}
```

---

## UI/UX Considerations

* Clean card-based layout
* Drag handle for intuitive reordering
* Color-coded price changes (green/red)
* Consistent spacing and typography
* Smooth interaction during reorder

---

## Responsiveness

* Custom utility methods used for scaling UI
* Works across different screen sizes
* Maintains consistent layout proportions

---

## Code Quality & Reusability

* Modular structure (feature-based separation)
* Reusable widgets and styling
* Clear separation of UI and business logic
* Immutable state updates in BLoC

---

## Type Safety

* Strong typing used across models and BLoC
* Avoided dynamic structures
* Ensures predictable behavior and fewer runtime errors

---

## ▶️ Getting Started

1. Clone the repository:

```bash
git clone https://github.com/AniketDhanak/021TradeApp.git
```

2. Navigate to project:

```bash
cd 021TradeApp
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

---

## 📌 Notes

* Dummy data is used for watchlists and stocks
* Architecture is designed to be easily extendable for API integration
* Focus was kept on clarity, usability, and maintainability

---

## Conclusion

This project demonstrates:

* Practical usage of Flutter BLoC
* Clean handling of UI interactions like drag-and-drop
* Maintainable and scalable code structure

The implementation focuses on balancing **user experience and architecture**, ensuring both are handled effectively.

---
