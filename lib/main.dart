import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'My Notes',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed( 
          seedColor: Colors.deepPurple, 
          brightness: Brightness.light
        ),
      ),
      home: const HomePage( ),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
      },
    ),
  );
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (coontext, snapshot ){
        switch(snapshot.connectionState ){
          case ConnectionState.done:
          final user = FirebaseAuth.instance.currentUser;
          if( user != null ){
            if( user.emailVerified ){
              print('Email is verified');
            }
            else{
              return const VerifyEmailView();
            }
          } else {
            return const LoginView();
          }
          return const Text('Done');
          //   if( user?.emailVerified ?? false ){
          //     return const Text('Done');
          //   } else{ 
          //     return const VerifyEmailView( );
          //   }
          //return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

