import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/core/utils/responsive_size.dart';
import 'package:netflix_clone/app/core/services/auth_servise.dart';
import 'package:netflix_clone/app/widgets/custom_button_widget.dart';
import 'package:netflix_clone/app/widgets/text_fild_form_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Chave global para identificar e validar o formulário.
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos de texto.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Instância do nosso serviço de autenticação.
  final _authService = AuthService();

  // Estado para controlar o indicador de carregamento.
  bool _isLoading = false;

  @override
  void dispose() {
    // Limpa os controladores quando o widget é descartado.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Função para lidar com a submissão do formulário de login.
  Future<void> _submitLogin() async {
    // Valida o formulário. Se não for válido, retorna.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Ativa o indicador de carregamento.
    setState(() => _isLoading = true);

    try {
      // Chama o serviço de autenticação.
      await _authService.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Em caso de sucesso, navega para a tela principal.
      // O 'mounted' verifica se o widget ainda está na árvore de widgets.
      if (mounted) {
        context.go('/home');
      }
    } on FirebaseAuthException catch (e) {
      log('Erro de login do Firebase: ${e.message}', error: e);
      // Mostra uma mensagem de erro amigável para o utilizador.
      final snackBar = SnackBar(
        content: Text(
          'Email ou senha inválidos.',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.red,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = ResponsiveSize.width(30);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          spacing: 20,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                    size: width,
                  ),
                  onPressed: () => context.pop(),
                ),
                Image.asset('assets/images/logo.png', height: width + 10),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                spacing: width,
                children: [
                  CustomTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, insira seu email.';
                      }
                      if (!value.contains('@')) {
                        return 'Por favor, insira um email válido.';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: _passwordController,
                    labelText: 'Senha',
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha.';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter no mínimo 6 caracteres.';
                      }
                      return null;
                    },
                  ),
                  CustomButtonWidget(
                    label: 'Entrar',
                    onPressed: _isLoading ? null : _submitLogin,
                    isLoading: _isLoading,
                  ),
                  TextButton(
                    onPressed: () => context.go('/register'),
                    child: Text(
                      'Não tem uma conta? Registre-se',
                      style: TextStyle(color: AppColors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
