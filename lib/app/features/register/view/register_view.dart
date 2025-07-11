import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/config/theme/text_style.dart';
import 'package:netflix_clone/app/core/services/auth_servise.dart';
import 'package:netflix_clone/app/core/utils/responsive_size.dart';
import 'package:netflix_clone/app/widgets/custom_button_widget.dart';
import 'package:netflix_clone/app/widgets/text_fild_form_widget.dart';

// Enum para controlar o estado da UI
enum RegisterFlowState { enterEmail, createPassword }

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  var _flowState = RegisterFlowState.enterEmail;
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handlePrimaryAction() async {
    if (_flowState == RegisterFlowState.enterEmail) {
      await _checkEmailAndProceed();
    } else {
      await _createAccount();
    }
  }

  Future<void> _checkEmailAndProceed() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final methods = await _authService.checkEmailSignInMethods(
        email: _emailController.text.trim(),
      );
      if (!mounted) return;

      if (methods.isNotEmpty) {
        context.go('/login', extra: _emailController.text.trim());
      } else {
        setState(() => _flowState = RegisterFlowState.createPassword);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await _authService.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) context.go('/home');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao criar conta: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildHeader() {
    if (_flowState == RegisterFlowState.createPassword) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/logo.png', height: 35),
          TextButton(
            onPressed: () => context.go('/login'),
            child: Text(
              'ENTRAR',
              style: AppTextStyles.mediumTitle16.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
        ],
      );
    }
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () => context.go('/started'),
        icon: Icon(
          Icons.close,
          color: AppColors.black,
          size: context.responsiveWidth(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveSize.paddingTop,
            horizontal: context.responsiveWidth(20),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Text(
                  'Tudo pronto para assistir?',
                  style: AppTextStyles.boldDisplay24.copyWith(
                    color: AppColors.black,
                    fontSize: ResponsiveSize.font(24),
                  ),
                ),

                Text(
                  'Informe seu e-mail para criar ou acessar sua conta.',
                  style: AppTextStyles.lightBody14.copyWith(
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: ResponsiveSize.height(20)),
                CustomTextFormField(
                  darkMode: false,
                  controller: _emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  // validationType: ValidationType.email,
                ),
                SizedBox(height: ResponsiveSize.height(10)),
                if (_flowState == RegisterFlowState.createPassword) ...[
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    darkMode: false,
                    controller: _passwordController,
                    labelText: 'Crie uma senha',

                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    // validationType: ValidationType.password,
                  ),
                ],

                CustomButtonWidget(
                  label: _flowState == RegisterFlowState.enterEmail
                      ? 'VAMOS LÁ'
                      : 'CRIAR NOVA CONTA',
                  onPressed: _handlePrimaryAction,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
