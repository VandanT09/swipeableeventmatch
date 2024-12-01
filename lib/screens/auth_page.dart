import 'package:flutter/material.dart';
import 'home_page.dart'; // Replace with the correct path to your HomePage file

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Controllers for date of birth
  final TextEditingController _dobDayController = TextEditingController();
  final TextEditingController _dobMonthController = TextEditingController();
  final TextEditingController _dobYearController = TextEditingController();

  String? _selectedGender;

  bool isLogin =
      true; // Track whether we're showing the sign-in or sign-up form

  static const Color brandColor = Color(0xFFE86343);

  // Method to build the text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: brandColor),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // Method to build social buttons
  Widget _buildSocialButton({
    required String text,
    IconData? icon,
    Widget? iconWidget,
    Color iconColor = Colors.black87,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black87,
    bool outlined = false,
  }) {
    final buttonStyle = outlined
        ? OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            foregroundColor: iconColor,
            side: BorderSide(color: iconColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.black12),
            ),
          );

    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconWidget ??
            (icon != null
                ? Icon(icon, color: iconColor, size: 20)
                : const SizedBox.shrink()),
        if (iconWidget != null || icon != null) const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            color: outlined ? iconColor : textColor,
            fontSize: 16,
          ),
        ),
      ],
    );

    return SizedBox(
      width: double.infinity,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: content,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: content,
            ),
    );
  }

  // Method to build primary button (Sign in / Sign up)
  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: brandColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // Method to build the sign-in form
  Widget _buildSignInForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTextField(
          controller: _usernameController,
          label: 'Username',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _passwordController,
          label: 'Password',
          isPassword: true,
        ),
        const SizedBox(height: 24),
        _buildPrimaryButton(
          text: 'Sign in',
          onPressed: () {
            // Add your sign-in logic here
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        const SizedBox(height: 24),
        // Forgot Password Link (Above OR Divider)
        Align(
          child: TextButton(
            onPressed: () {
              // Implement forgot password functionality
            },
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: brandColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'OR',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),
        _buildSocialButton(
          text: 'Continue with Google',
          iconWidget: Image.asset(
            'images/googlelogo.webp',
            height: 24,
          ),
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        _buildSocialButton(
          text: 'Continue with Facebook',
          icon: Icons.facebook,
          iconColor: Colors.blue,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        _buildSocialButton(
          text: 'Continue with Mobile',
          icon: Icons.phone,
          iconColor: Colors.green,
          onPressed: () {},
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account? ",
              style: TextStyle(fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isLogin = false; // Switch to sign-up form
                });
              },
              child: const Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 14,
                  color: brandColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Method to build the sign-up form
  Widget _buildSignUpForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTextField(
          controller: _usernameController,
          label: 'Username',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _passwordController,
          label: 'Password',
          isPassword: true,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _confirmPasswordController,
          label: 'Confirm Password',
          isPassword: true,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _ageController,
          label: 'Age',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        // Gender Dropdown
        Container(
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              labelText: 'Gender',
              border: InputBorder.none,
            ),
            value: _selectedGender,
            items: ['Male', 'Female', 'Other']
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        // Date of Birth Fields
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _dobDayController,
                label: 'Day',
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildTextField(
                controller: _dobMonthController,
                label: 'Month',
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildTextField(
                controller: _dobYearController,
                label: 'Year',
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _emailController,
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        _buildPrimaryButton(
          text: 'Create Account',
          onPressed: () {
            // Add your sign-up logic here
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        const SizedBox(height: 24),
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'OR',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),
        _buildSocialButton(
          text: 'Continue with Google',
          iconWidget: Image.asset(
            'images/googlelogo.webp',
            height: 24,
          ),
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        _buildSocialButton(
          text: 'Continue with Facebook',
          icon: Icons.facebook,
          iconColor: Colors.blue,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        _buildSocialButton(
          text: 'Continue with Mobile',
          icon: Icons.phone,
          iconColor: Colors.green,
          onPressed: () {},
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account? ",
              style: TextStyle(fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isLogin = true; // Switch to sign-in form
                });
              },
              child: const Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 14,
                  color: brandColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build method remains the same as in the original code
    // Only content inside has been modified
    return Scaffold(
      backgroundColor: brandColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: const [
                    Text(
                      'EventMatch',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        isLogin ? 'Sign in' : 'Sign up',
                        style: TextStyle(
                          color: brandColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: isLogin ? _buildSignInForm() : _buildSignUpForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
