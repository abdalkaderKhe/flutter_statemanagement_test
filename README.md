
## Flutter State Management Showcase Test

This project implements a basic Network Request and Todo-App-Like functionality, focusing on state management, local data persistent and navigation using Riverpod and GoRouter packages for Flutter.

### Requirements

-   Create a Todo List application following the workflow defined below.
-   use go_router package for navigation.
-   use hooks_riverpod package for ephermal and global state management.
-   use Dio package for Network requests
-   implement local authentication flow and redirect on user login/logout 
-   you are free in the UI design decision, just make sure to handle async state, required navigation and user feedback properly i.e  using snackbars or alertDialogs.


### Application Workflow
-   starts with a login screen / signup screen
-   user can login with existing username or signup if not "use sharedpreferences for simple authentication flow".
-   use http://www.boredapi.com to fetch random activities.
-   on success activity fetch the user should be able to accept or reject the fetched random activity.
-   on user acception show an "Add Todo" Form Dialog with prefilled textfield with the activity description("activity" value fetched from the api) and three other fields for a- priority ("high-medium-low) b- deadline date, c- optional note, only the note value can be null.
-   on user rejection prompt the user to fetch another activity or cancel.
-   user can toggle the todo status "done" or "not done".
-   display the "done" and "not done" todos on different in the same screen.
-   save user's todos to shared preferences instance.
-   implement a logut button.


### Project Setup

2.  Clone the repository.
4.  Ensure you have Flutter installed and configured.
6.  Run `flutter pub get` to download dependencies.

### Running the App

2.  Run `flutter run` to launch the app on your preferred device or emulator.

### Submission Guide 

1. **Host your code:**: please fork this repo to your own space and complete the task there on a separate, feature branch.

2. **Share the link:**: when done, issue a pull request to "your own" repo and send the link to the pull request.

Feel free to reach out if you need clarification on specific requirements.

#### Best of Luck.