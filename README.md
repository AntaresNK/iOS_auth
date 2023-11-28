# iOS_auth
This is an iOS application for user registration and authorization with a clean and user-friendly design. It uses SnapKit for Auto Layout constraints and includes a navigation controller. The app provides sign-in, sign-up, and password create/reset functionalities along with user profile page.

## Screenshots
<img width="345" alt="Снимок экрана 2023-10-15 в 21 20 32" src="https://github.com/AntaresNK/iOS_auth/assets/132342182/19a8dca6-b7aa-45e2-9641-4ffc6e3301e7">
<img width="339" alt="Снимок экрана 2023-10-15 в 21 21 15" src="https://github.com/AntaresNK/iOS_auth/assets/132342182/715e5f7f-2a95-4dc7-8801-e23466e7873c">
<img width="333" alt="Снимок экрана 2023-10-15 в 21 21 38" src="https://github.com/AntaresNK/iOS_auth/assets/132342182/cead7e6d-4c27-4743-b99b-14f1e6508569">
<img width="342" alt="Снимок экрана 2023-10-15 в 21 22 02" src="https://github.com/AntaresNK/iOS_auth/assets/132342182/3a79acf9-0829-437d-aee0-f1e42cf95567">
<img width="325" alt="Снимок экрана 2023-10-15 в 21 22 43" src="https://github.com/AntaresNK/iOS_auth/assets/132342182/9e85461f-8c6e-46af-92ee-5e4ed607bfd2">
<img width="329" alt="Снимок экрана 2023-10-15 в 21 23 24" src="https://github.com/AntaresNK/iOS_auth/assets/132342182/233cc30b-be88-43de-a591-11fe61a227eb">
<img width="337" alt="Снимок экрана 2023-10-15 в 21 44 55" src="https://github.com/AntaresNK/iOS_auth/assets/132342182/8d9e525b-b410-4006-baca-431f8565bcca">
<img width="334" alt="Снимок экрана 2023-10-15 в 21 36 21" src="https://github.com/AntaresNK/iOS_auth/assets/132342182/3ea0685e-803e-4eff-b9f7-197008064002">
<img width="341" alt="Снимок экрана 2023-11-28 в 18 08 00" src="https://github.com/AntaresNK/iOS_auth/assets/132342182/eb05e2f9-37b8-4519-97d7-0bb3640cc4a4">



## Features and Usage
- ### Splash Screen
  - **SplashScreeViewController**: Presented with logo and moto of the application. Allows users to sign in or sign up.
- ### Sign Up
  - **SignupViewController**: New users can create an account by providing their email. Entering email should satisfy the standard of email address to make `nextButton` available. If email is already registered, appears warning text (to check, please use email: "qwerty@gmail.co"). 
  - **AlertViewController**: If an email address is not registered yet, appears alerting screen, informing that verification has been sent to the current email address. After closing of this screen tapping `closeButton`, appears user profile screen.
  - **ProfileViewController**: Users should fill the personal information like name, lastname, date of birth and email (filled by default). When all cells are filled `signinButton` becames available, tapping of which opens create password screen.
- ### Sign In
  - **SigninViewController**: Allows registered users to log in using their email and password. Sign in button becomes enable only if both email and password are correct (you can use email: "qwerty@gmail.co", password: "Qwer23#"). If email and/or password is wrong, appears text warning "Wrong email or password". 
- ### Create / Reset Password
  - **CreatePasswordViewController**:  Users can create a new or reset existing one if they forget it. To set, it is needed to enter the text in the `passwordTextField`  satisfying requirements stated below of the cells. Each time required symbol is typed, the "requirement" becomes colored. It is needed to confirm the password on the `repeatPasswordTextField`. When enetered passwords match, `nextButton` becomes enabled and directs to Splash Screen. Please note that TextFields have secure entry and if you want to see the entered text, tap `showPasswordButton`.
  - **PopUpViewController**:  After resetting of the password, appears the popup message informing about successfull reset of the password.

## Installation
1. Clone or download the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on a simulator or a physical device.

## Testing
The application has been tested on the following devices and screen sizes:

- iPhone 11 Pro Max
- iPhone 14 Pro
- iPhone SE (3rd generation)
- iPad (10th generation)

The layout adapts well to different screen sizes.

## Author
Nazym Sayakhmet

git: AntaresNK

email: nsayakhmet@gmail.com
