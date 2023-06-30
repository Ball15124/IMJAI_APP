# IMJAI_APP

IMJAI Application for Integrated Project II.

## Please read this before start the code.

## Requirement

- Run with Android & IOS emulator only.
- .env file (included in the zipped folder)
  Place make sure to put .env file in the backend folder.
- dart SDK version `2.19.6 (stable)` or below.
- flutter SDK version `>=2.19.0 <3.0.0`.

## Set up

(Do this if you wan't to run the backend server by yourself.)

#### Back-end

1. Run `npm install` in terminal to install packages.
2. Run `npm start` in terminal to start the backend server.

- If you running into `DATABASE_URL` not found. Make sure to put .env file in the folder and run `npx prisma generate` to re-establsih the DATABASE_URL.

##### Front-end

1. Download all dependencies by running `flutter pub get` in the terminal of frontend.
2. Run `flutter run` in terminal to run the project.

- If the error occured. Please make sure to use dart SDK version `2.19.6 (stable)` or below.

- If you are running backend server by yourself.

* Make sure to replace the `baseUrl` in the file `imjai_frontend/lib/pages/caller.dart` with your own IP address.
