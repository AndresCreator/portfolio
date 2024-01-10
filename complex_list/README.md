# README for Complex List - A Flutter To-Do App

## Overview

Complex List is a modern To-Do list application built with Flutter. It's designed to demonstrate the implementation of a To-Do list using the hexagonal architecture pattern. This app is perfect for showcasing how to structure a Flutter project to achieve clean architecture, maintainability, and scalability.

### Key Features:

- **Lazy Loading**: Efficiently handles large lists by loading items as needed, enhancing performance and user experience.
- **State Management**: Utilizes the flutter_bloc package for robust and predictable state management.
- **Dependency Injection**: Leverages get_it for clean and decoupled dependency management.
- **Data Persistence**: Implements sqflite for local data storage, ensuring your to-do items are saved between sessions.
- **Navigation**: Integrated with go_router for an improved routing experience.

## Environment

This app is built with Flutter and is compatible with Flutter SDK version '>=3.2.3 <4.0.0'.

## Getting Started

To get started with Complex List, follow these simple steps:

1. **Install Dependencies**:
   Navigate to the project directory and run:
   ```bash
   flutter pub get
   ```
2. **Run the App**:
   Launch an emulator or connect a physical device and execute:
   ```bash
   flutter run
   ```

## Architecture

Complex List follows the hexagonal architecture pattern, also known as the ports and adapters pattern. This architecture promotes the separation of concerns by dividing the application into inside and outside parts.

- **Inside**: Consists of domain entities (`ListItem`), use cases (like `FetchItems`), and ports (interfaces like `ListItemRepositoryPort`).
- **Outside**: Involves adapters (like `SqfliteListItemRepository`) and the UI (widgets and BLoC).

This separation allows for easier testing, maintenance, and scalability.

## Dependencies

- `sqflite`: For local database storage.
- `get_it`: For dependency injection.
- `flutter_bloc`: For implementing the BLoC pattern.
- `path`: Used in managing file paths, particularly for database storage.
- `go_router`: For navigation and routing.
- `cupertino_icons`: For iOS style icons.
- `flutter_lints`: For enforcing good coding practices.
