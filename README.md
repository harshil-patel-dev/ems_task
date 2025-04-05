# EMS Task - Employee Management System

## Overview

EMS Task is a Flutter application for managing employee records. It provides a clean, intuitive interface for adding, editing, and viewing employee details with proper validation and state management.

## Features

- **Employee Management**
  - Add new employees with name, role, and date information
  - Edit existing employee details
  - Delete employees
  - View all employees in a list
- **Form Validation**
  - Required field validation
  - Date validation (from date must be before to date)
  - Real-time validation feedback
- **Date Selection**
  - Custom date picker with quick date options
  - Support for "No Date" option for end dates
- **State Management**
  - BLoC pattern for predictable state management
  - Form state handling with proper validation
- **Data Persistence**
  - Local storage using Hive database
  - Automatic data loading and saving

## Technical Implementation

### Architecture

The application follows the BLoC (Business Logic Component) pattern for state management, providing a clean separation of concerns:

- **Presentation Layer**: UI components and screens
- **Business Logic Layer**: BLoCs for managing state and business logic
- **Data Layer**: Models and database operations

### State Management

- Uses Flutter BLoC for predictable state management
- Formz package for form validation
- Proper error handling and user feedback

### Data Persistence

- Hive database for local storage
- Type adapters for custom objects

## Project Structure

```
lib/
├── app.dart                      # Main app configuration
├── main.dart                     # Entry point
├── core/
│   ├── constants/
│   │   └── app_constants.dart    # App-wide string constants
│   ├── database/
│   │   └── hive_helper.dart      # Database operations
│   ├── models/
│   │   ├── employee_model.dart   # Employee data model
│   │   └── quickdate_model.dart  # Date picker helper model
│   └── utils/
│       ├── app_export.dart       # Common imports
│       └── validator.dart        # Form validation logic
├── features/
│   ├── employee_details/
│   │   ├── bloc/
│   │   │   ├── employee_bloc.dart   # Employee form BLoC
│   │   │   ├── employee_event.dart  # Events for employee form
│   │   │   └── employee_state.dart  # State for employee form
│   │   └── employee_detail_form.dart # Employee form UI
│   └── home/
│       ├── bloc/
│       │   ├── home_bloc.dart       # Home screen BLoC
│       │   ├── home_event.dart      # Events for home screen
│       │   └── home_state.dart      # State for home screen
│       └── home_screen.dart         # Home screen UI
└── widgets/
    ├── custom_button.dart        # Reusable button component
    ├── custom_datepicker.dart    # Custom date picker widget
    └── custom_textformfield.dart # Custom text field widget
```

## Edge Cases Handled

1. **Form Validation**

   - Empty required fields
   - Invalid date ranges
   - Form submission only when all validations pass

2. **Date Handling**

   - Optional end dates (no date)
   - Date range validation (from date must be before to date)
   - Date formatting for display
   - Preventing selection of dates before today in the "To Date" field
   - Preventing selection of "To Date" before the selected "From Date"
   - Converting previous employees to current employees by removing the end date

3. **State Management**

   - Proper initialization of form with existing data
   - Validation on field change and form submission
   - Error display only after submission attempt
   - Unsaved changes detection when navigating back from edit mode
   - Confirmation dialog when attempting to discard changes

4. **UI/UX Considerations**
   - Proper keyboard handling
   - Loading states during database operations
   - Success/error feedback to users
   - Empty state handling for "No current employees" or "No previous employees"
   - Intuitive date selection with validation feedback

## Getting Started

### Prerequisites

- Flutter SDK (2.0 or higher)
- Dart SDK (2.12 or higher)

### Installation

1. Clone the repository

```bash
git clone https://github.com/yourusername/ems_task.git
```

2. Navigate to the project directory

```bash
cd ems_task
```

3. Install dependencies

```bash
flutter pub get
```

4. Run the app

```bash
flutter run
```

## Dependencies

- flutter_bloc: State management
- formz: Form validation
- hive: Local database
- go_router: Navigation
- intl: Date formatting

## License

This project is licensed under the MIT License - see the LICENSE file for details.
