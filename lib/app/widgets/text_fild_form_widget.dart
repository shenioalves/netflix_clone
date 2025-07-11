import 'package:flutter/material.dart';
// Importe suas cores e o helper de responsividade
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/config/theme/text_style.dart';

/// Um widget TextFormField versátil e reutilizável para formulários e campos de busca.
///
/// Suporta validação, campos de senha com toggle de visibilidade,
/// e um botão para limpar o texto.
class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isSearchField;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? colorText;
  final bool darkMode;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.validator,
    this.isPassword = false,
    this.isSearchField = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.colorText,
    this.darkMode = true,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  // Estado para controlar a visibilidade da senha
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
    // Listener para reconstruir o widget quando o texto muda (para o botão de limpar)
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
    if (widget.onChanged != null) {
      widget.onChanged!(widget.controller.text);
    }
  }

  // Alterna a visibilidade da senha
  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(8.0);
    final BorderSide borderSide = BorderSide(color: AppColors.grey, width: 1.0);
    final BorderSide focusedBorderSide = BorderSide(
      color: AppColors.blue,
      width: 1.5,
    );
    final Color color;
    final Color colorText;
    if (widget.darkMode) {
      color = AppColors.greyDark1;
      colorText = AppColors.white;
    } else {
      color = AppColors.greyLight3;
      colorText = AppColors.black;
    }

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _isObscured,
      validator: widget.validator,
      style: AppTextStyles.lightHeadline18.copyWith(color: colorText),
      cursorColor: colorText, // Cor do texto digitado
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: AppTextStyles.lightHeadline18.copyWith(color: colorText),
        hintStyle: AppTextStyles.lightHeadline18.copyWith(color: colorText),
        prefixIcon: widget.prefixIcon,
        suffixIcon: _buildSuffixIcon(),
        filled: true,
        fillColor: color, // Cor de fundo do campo
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: focusedBorderSide,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: AppColors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: AppColors.red, width: 2),
        ),
      ),
    );
  }

  /// Constrói o ícone de sufixo com base nas propriedades do widget.
  Widget? _buildSuffixIcon() {
    // Se um ícone customizado foi passado, ele tem prioridade.
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    // Se for um campo de senha, mostra o toggle de visibilidade.
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          color: AppColors.greyLight3,
        ),
        onPressed: _toggleVisibility,
      );
    }

    // Se for um campo de busca e tiver texto, mostra o botão de limpar.
    if (widget.isSearchField && widget.controller.text.isNotEmpty) {
      return IconButton(
        icon: Icon(Icons.clear, color: AppColors.greyLight3),
        onPressed: () => widget.controller.clear(),
      );
    }

    // Se nenhuma das condições acima for atendida, não mostra ícone.
    return null;
  }
}
