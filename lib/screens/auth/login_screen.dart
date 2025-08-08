import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isEmailAuth = true;
  
  // Text styles
  TextStyle get _inputTextStyle => GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 16,
  );
  
  TextStyle get _hintTextStyle => GoogleFonts.poppins(
    color: Colors.black54,
    fontSize: 16,
  );
  
  TextStyle get _linkTextStyle => GoogleFonts.poppins(
    color: Colors.blue[700],
    fontSize: 13,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );
  
  // Background color for input fields
  Color get _inputBackgroundColor => Colors.grey[100]!;
  
  // Border color for input fields
  Color get _inputBorderColor => Colors.grey[300]!;

  // Get demo credentials
  Map<String, Map<String, String>> get _demoCredentials => AuthProvider.demoCredentials;


  // Build animated background
  Widget _buildAnimatedBackground() {
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.backgroundColor,
                AppTheme.surfaceColor,
              ],
            ),
          ),
        ),
        // Animated circles
        ...List.generate(
          5,
          (index) => Positioned(
            left: 100.0 * index,
            top: 100.0 * (index % 3),
            child: Container(
              width: 200.0 * (index + 1),
              height: 200.0 * (index + 1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Build logo and title section
  Widget _buildLogoSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryStart.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.home_work_rounded,
            size: 48,
            color: Colors.white,
          ),
        ).animate().scale(delay: const Duration(milliseconds: 200), duration: const Duration(milliseconds: 600), curve: Curves.elasticOut),
        
        const SizedBox(height: 16),
        Text(
          'PG Flow',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppTheme.primary800,
            letterSpacing: 1.2,
          ),
        ).animate().fadeIn(delay: const Duration(milliseconds: 300), duration: const Duration(milliseconds: 600)).slideY(
          begin: -0.3,
          end: 0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
        ),
        
        const SizedBox(height: 8),
        Text(
          'Streamline your PG management',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppTheme.neutral600,
            fontWeight: FontWeight.w400,
          ),
        ).animate().fadeIn(delay: const Duration(milliseconds: 400), duration: const Duration(milliseconds: 600)).slideY(
          begin: -0.2,
          end: 0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
        ),
      ],
    );
  }
  
  // Build auth method toggle
  Widget _buildAuthMethodToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: _isEmailAuth ? AppTheme.primaryGradient : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() => _isEmailAuth = true),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Center(
                      child: Text(
                        'Email',
                        style: GoogleFonts.poppins(
                          color: _isEmailAuth ? Colors.white : Colors.white70,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: !_isEmailAuth ? AppTheme.primaryGradient : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() => _isEmailAuth = false),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Center(
                      child: Text(
                        'Phone',
                        style: GoogleFonts.poppins(
                          color: !_isEmailAuth ? Colors.white : Colors.white70,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 600)).slideY(
      begin: 0.3,
      end: 0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }
                
  // Build animated input field
  Widget _buildAnimatedInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    int delay = 0,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.black54,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _inputBackgroundColor,
            border: Border.all(color: _inputBorderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            style: _inputTextStyle,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(
                prefixIcon,
                color: Colors.black54,
                size: 20,
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: Duration(milliseconds: 600 + delay * 100), duration: const Duration(milliseconds: 500)).slideY(
      begin: 0.3,
      end: 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  // Build the main login form
  Widget _buildLoginForm() {
    // Create a local key if the form key is already used
    final formKey = _formKey.currentState == null 
        ? _formKey 
        : GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: GlassCard(
            padding: const EdgeInsets.all(32),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLogoSection(),
                const SizedBox(height: 32),
                _buildAuthMethodToggle(),
                const SizedBox(height: 24),
                _buildLoginFormContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build login form content
  Widget _buildLoginFormContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Input Fields
        if (_isEmailAuth) ...[
          _buildAnimatedInputField(
            controller: _emailController,
            label: 'Email Address',
            hint: 'Enter your email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            delay: 1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildAnimatedInputField(
            controller: _passwordController,
            label: 'Password',
            hint: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            delay: 2,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.black54,
                size: 20,
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
        ] else ...[
          _buildAnimatedInputField(
            controller: _phoneController,
            label: 'Phone Number',
            hint: 'Enter your phone number',
            prefixIcon: Icons.phone_android_outlined,
            keyboardType: TextInputType.phone,
            delay: 1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (value.length < 10) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildAnimatedInputField(
            controller: _passwordController,
            label: 'Password',
            hint: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            delay: 2,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.black54,
                size: 20,
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
        ],
        
        const SizedBox(height: 24),
        
        // Login Button
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : GradientButton(
                onPressed: _handleLogin,
                text: 'Login',
                textStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: Colors.black,
                ),
              ),
        
        const SizedBox(height: 24),
        
        // Divider with "or"
        Row(
          children: [
            Expanded(child: Divider(color: Colors.black.withValues(alpha: 0.1))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'or',
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.black.withValues(alpha: 0.1))),
          ],
        ).animate().fadeIn(delay: const Duration(milliseconds: 900), duration: const Duration(milliseconds: 500)),
        
        const SizedBox(height: 24),
        
        // Demo Login Buttons
        Column(
          children: _demoCredentials.entries.map((entry) {
            final userType = entry.key;
            final credentials = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GradientButtonOutlined(
                onPressed: () => _loginWithDemoCredentials(userType, credentials),
                text: 'Login as ${userType.toUpperCase()}',
                textStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
        ).animate().fadeIn(delay: const Duration(milliseconds: 1100), duration: const Duration(milliseconds: 500)),
        
        const SizedBox(height: 32),
        
        // Sign Up Link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: GoogleFonts.poppins(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupScreen()),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Sign Up',
                  style: _linkTextStyle,
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: const Duration(milliseconds: 1200), duration: const Duration(milliseconds: 500)),
      ],
    );
  }

  Future<void> _loginWithDemoCredentials(String userType, Map<String, String> credentials) async {
    setState(() => _isLoading = true);
    
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      if (_isEmailAuth) {
        await authProvider.login(
          credentials['email']!,
          credentials['password']!,
        );
      } else {
        await authProvider.loginWithPhone(
          credentials['phone']!,
          credentials['password']!,
        );
      }

      // Navigate based on user role using GoRouter
      if (!mounted) return;
      final user = authProvider.currentUser;
      
      if (user != null) {
        // Use GoRouter to navigate
        String route;
        if (user.role == 'owner') {
          route = '/owner/dashboard';
        } else if (user.role == 'manager') {
          route = '/manager/dashboard';
        } else {
          route = '/tenant/dashboard';
        }
        
        // Navigate using GoRouter
        if (mounted) {
          context.go(route);
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      // Use email/password or phone based on the auth method
      if (_isEmailAuth) {
        await authProvider.login(
          _emailController.text.trim(),
          _passwordController.text,
        );
      } else {
        // Use phone-based login
        await authProvider.loginWithPhone(
          _phoneController.text.trim(),
          _passwordController.text,
        );
      }

      // Navigate based on user role using GoRouter
      if (!mounted) return;
      final user = authProvider.currentUser;
      
      if (user != null) {
        // Use GoRouter to navigate
        String route;
        if (user.role == 'owner') {
          route = '/owner/dashboard';
        } else if (user.role == 'manager') {
          route = '/manager/dashboard';
        } else {
          route = '/tenant/dashboard';
        }
        
        // Navigate using GoRouter
        if (mounted) {
          context.go(route);
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          _buildAnimatedBackground(),
          
          // Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: _buildLoginForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 