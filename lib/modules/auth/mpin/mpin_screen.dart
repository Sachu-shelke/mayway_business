import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mayway_business/config/theme/app_colors.dart';
import 'package:mayway_business/widget/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/routes/router_import.gr.dart';
import '../../main_home/main_home_screen.dart';

class PinCodeOtp extends StatefulWidget {
  final bool isSignup;
  final bool isSplash;
  final bool? isForgetOtp;
  const PinCodeOtp({
    super.key,
    required this.isSignup,
    required this.isSplash,
    this.isForgetOtp,
  });

  @override
  _PinCodeOtpState createState() => _PinCodeOtpState();
}

class _PinCodeOtpState extends State<PinCodeOtp> {
  late Size _screenSize;
  String userName = "";
  late String savedMPIN;
  bool isAuth = false;
  final LocalAuthentication auth = LocalAuthentication();

  // MPIN model (for handling digits)
  List<int?> mpinDigits = [null, null, null, null];

  @override
  void initState() {
    super.initState();
    _loadSavedMPIN();
    _checkBiometrics();
  }

  // Load MPIN from SharedPreferences (if any)
  Future<void> _loadSavedMPIN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedMPIN = prefs.getString('saved_mpin') ?? '';
    });
    print('Saved MPIN: $savedMPIN'); // Debugging line to print saved MPIN
  }

  // Save MPIN to SharedPreferences
  Future<void> _saveMPIN(String mpin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_mpin', mpin);
    print('MPIN saved: $mpin'); // Debugging line to print saved MPIN
  }

  // Validate if the MPIN entered is correct
  bool _isMPINValid() {
    String enteredMPIN = mpinDigits.map((digit) => digit.toString()).join('');
    print('Entered MPIN: $enteredMPIN'); // Debugging line to print entered MPIN
    return enteredMPIN == savedMPIN;
  }

  // Handling input when a number key is pressed
  void _setCurrentDigit(int digit) {
    for (int i = 0; i < 4; i++) {
      if (mpinDigits[i] == null) {
        setState(() {
          mpinDigits[i] = digit;
        });
        break;
      }
    }
    if (mpinDigits.every((digit) => digit != null)) {
      String enteredMPIN = mpinDigits.map((digit) => digit.toString()).join('');
      if (savedMPIN.isEmpty) {
        // If MPIN is empty (first-time setup), save it
        context.router.push(MainHomeScreenRoute(isFromSignup: widget.isSignup));
        _saveMPIN(enteredMPIN); // Save MPIN only once
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('MPIN saved successfully')));
      } else if (_isMPINValid()) {
        // If MPIN is valid, navigate to the main screen
        context.router.push(MainHomeScreenRoute(isFromSignup: widget.isSignup));
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Sign-in successful')));
        print('Sign-in successful');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Incorrect MPIN')));
      }
      setState(() {
        mpinDigits = [null, null, null, null]; // Reset the digits after checking
      });
    }
  }

  // Backspace functionality
  void _handleBackspace() {
    setState(() {
      for (int i = 3; i >= 0; i--) {
        if (mpinDigits[i] != null) {
          mpinDigits[i] = null;
          break;
        }
      }
    });
  }

  // Method to handle biometric authentication
  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (canCheckBiometrics) {
      try {
        bool authenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to continue',
          options: AuthenticationOptions(biometricOnly: true),
        );
        if (authenticated) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text('Biometric authentication successful')));
          context.router.push(MainHomeScreenRoute(isFromSignup: widget.isSignup));
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text('Authentication failed')));
        }
      } catch (e) {
        print("Error during biometric authentication: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Logo(),
          const SizedBox(height: 140),
          const Icon(Icons.lock, size: 40),
          Text(
            widget.isForgetOtp == true ? 'Set New Mpin' : 'Enter Mpin',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return _getColorTextField(mpinDigits[index]);
            }),
          ),
          const SizedBox(height: 10),
          _getOtpKeyboard()
        ],
      ),
    );
  }

  // Generate OTP input fields
  Widget _getColorTextField(int? digit) {
    return Container(
      width: 24.0,
      height: 24.0,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkOrangeColor),
        color: digit != null ? AppColors.appColors : Colors.white,
      ),
    );
  }

  // OTP Keyboard
  Widget _getOtpKeyboard() {
    return Container(
      height: 360,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: _otpKeyboardRowWithBackspace(['1', '2', '3'])),
          Expanded(child: _otpKeyboardRowWithBackspace(['4', '5', '6'])),
          Expanded(child: _otpKeyboardRowWithBackspace(['7', '8', '9'])),
          Expanded(child: _otpKeyboardRowWithBackspace(['', '0', 'backspace'])),
        ],
      ),
    );
  }

  // Helper function to create rows for OTP buttons
  Widget _otpKeyboardRowWithBackspace(List<String> labels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: labels.map((label) {
        if (label == 'backspace') {
          return _otpKeyboardInputButton(
            label: Icon(Icons.backspace_outlined, color: Colors.black),
            onPressed: _handleBackspace,
          );
        }
        return _otpKeyboardInputButton(label: label, onPressed: () {
          if (label.isNotEmpty) {
            _setCurrentDigit(int.parse(label));
          }
        });
      }).toList(),
    );
  }

  // Button for each OTP digit
  Widget _otpKeyboardInputButton({
    required dynamic label,
    required VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50.0,
          width: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.appColors,
          ),
          child: Center(
            child: label is String
                ? Text(
              label,
              textScaleFactor: 1.0,
              style: TextStyle(fontSize: 22.0, color: Colors.black),
            )
                : label, // If it's an Icon, display it
          ),
        ),
      ),
    );
  }
}
