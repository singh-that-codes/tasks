import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly', // Corrected URL
];

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: scopes);

class GoogleSigning extends StatefulWidget {
  const GoogleSigning({Key? key}) : super(key: key);

  @override
  State<GoogleSigning> createState() => _GoogleSigningState();
}

class _GoogleSigningState extends State<GoogleSigning> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
        _isAuthorized = account != null;
      });
    });
    _googleSignIn.signInSilently(); // Attempt silent sign-in
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: _handleSignIn, // Call _handleSignIn when button is pressed
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.login_outlined),
            const SizedBox(width: 8), // Added spacing between icon and text
            Text('Sign in with Google'),
          ],
        ),
      ),
    );
  }
}
