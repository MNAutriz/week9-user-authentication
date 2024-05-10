# Week #9: User Authentication

**Name:** Mark Neil Autriz <br/>
**Section:** U-4L <br/>
**Student number:** 2022-03446 <br/>

## Code Description

The Todo app is a Flutter application designed to manage tasks. Users can sign up, log in, view their tasks, add new tasks, edit existing tasks, mark tasks as completed, and delete tasks. The app uses Firebase for authentication and Firestore for storing user data and task information.

## Things you did in the code

1. Signup Page (signup_page.dart):
Added fields for first name, last name, email, and password.
Implemented input validation for email, password, first name, and last name.
Proper UI response provided for invalid inputs.
2. Credential Model (credential_model.dart):
Contains the Credential class representing user credentials, including first name, last name, email, and password.
Provides methods for JSON serialization and deserialization.
3. Credential Provider (credential_provider.dart):
Handles user authentication and user data management.
Interacts with Firebase Firestore API (FirebaseCredAPI) for adding users and fetching user data.
Utilizes the Credential model for managing user data.
4. Firebase Credential API (firebase_credential_api.dart):
Provides methods for interacting with Firebase Firestore for user-related operations (e.g., adding users, fetching user data).
5. Login Page (login.dart):
Implements input validation for email and password fields.
Provides proper UI response for invalid inputs.
6. Auth Provider (auth_provider.dart):
Manages user authentication using Firebase Authentication.
Handles sign-up, login, and logout functionalities.
7. Todo Model (todo_model.dart):
Defines the Todo class representing a task, including fields like user ID, task title, and completion status.
Provides methods for JSON serialization and deserialization.
8. Todo Provider (todo_provider.dart):
Manages task-related operations (e.g., adding, editing, deleting tasks).
Interacts with Firebase Firestore API (FirebaseTodoAPI) for task management.
Utilizes the Todo model for managing task data.
9. Firebase Todo API (firebase_todo_api.dart):
Provides methods for interacting with Firebase Firestore for task-related operations.
10. Main Dart (main.dart):
Initializes the Flutter app and sets up Firebase integration.
Defines routes for different screens.
Uses Provider package for state management and dependency injection.

## Challenges encountered

The oversight in clearing the existing data in the Firebase database before reconnecting the app prevented the Todo app from loading properly. This interruption occurred because the app was attempting to retrieve data that was no longer valid or relevant due to the presence of outdated information in the database.

## Commit Log

1. Followed the handout breakdown in the program.
2. Added the functioanlity for the pages.
3. Added the authentication and models for the todo app.

## References
1. N/A