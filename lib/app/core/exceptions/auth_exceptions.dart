/// Uma classe base para todas as exceções relacionadas com a autenticação.
abstract class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

/// Lançada se o utilizador não for encontrado durante o login.
class UserNotFoundException extends AuthException {
  UserNotFoundException()
    : super('Nenhum utilizador encontrado com este email.');
}

/// Lançada se for fornecida uma senha incorreta.
class WrongPasswordException extends AuthException {
  WrongPasswordException() : super('A senha fornecida está incorreta.');
}

/// Lançada se um email já estiver em uso durante o registo.
class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException()
    : super('Este email já está a ser utilizado por outra conta.');
}

/// Lançada para senhas fracas durante o registo.
class WeakPasswordException extends AuthException {
  WeakPasswordException()
    : super('A senha é muito fraca. Por favor, escolha uma senha mais forte.');
}

/// Uma exceção genérica para outros erros do Firebase Auth.
class GenericAuthException extends AuthException {
  GenericAuthException(String message) : super(message);
}
