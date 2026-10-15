import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CadastroApp());
}

/// Aplicativo da atividade "Formulários e Validações no Flutter".
class CadastroApp extends StatelessWidget {
  const CadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2154B8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F6FC),
      ),
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // O Form e a GlobalKey permitem validar todos os campos de uma vez.
  final _formKey = GlobalKey<FormState>();

  // Controllers permitem obter os dados inseridos pelo usuário.
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _mostrarSenha = false;
  int _caracteresSenha = 0;

  @override
  void dispose() {
    // Liberação obrigatória dos controllers para evitar vazamentos de memória.
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  InputDecoration _decoracao({
    required String rotulo,
    required String dica,
    required IconData icone,
    Widget? sufixo,
  }) {
    return InputDecoration(
      labelText: rotulo,
      hintText: dica,
      prefixIcon: Icon(icone),
      suffixIcon: sufixo,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFCCD6E6)),
      ),
    );
  }

  void _cadastrar() {
    FocusScope.of(context).unfocus();

    // Cada validator do Form é executado ao chamar validate().
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Demonstra a leitura de um TextEditingController.
    // A atividade é apenas local: não envia ou salva dados em um servidor.
    final nome = _nomeController.text.trim();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cadastro realizado com sucesso, $nome!'),
        backgroundColor: const Color(0xFF197145),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de usuário'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF3F6FC),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              // Os erros são exibidos após pressionar CADASTRAR.
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    const Icon(
                      Icons.person_add_alt_1_rounded,
                      size: 50,
                      color: Color(0xFF2154B8),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Crie sua conta',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF142D59),
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Preencha os dados abaixo para realizar o cadastro.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF59677B)),
                    ),
                    const SizedBox(height: 22),
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Color(0xFFE3E9F3)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // 1. NOME COMPLETO
                            TextFormField(
                              controller: _nomeController,
                              decoration: _decoracao(
                                rotulo: 'Nome completo',
                                dica: 'Digite seu nome completo',
                                icone: Icons.person_outline,
                              ),
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                              validator: (valor) {
                                if (valor == null || valor.trim().isEmpty) {
                                  return 'Digite seu nome completo';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // 2. E-MAIL
                            TextFormField(
                              controller: _emailController,
                              decoration: _decoracao(
                                rotulo: 'E-mail',
                                dica: 'exemplo@email.com',
                                icone: Icons.email_outlined,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autocorrect: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                                LengthLimitingTextInputFormatter(120),
                              ],
                              validator: (valor) {
                                if (valor == null || valor.trim().isEmpty) {
                                  return 'Digite seu e-mail';
                                }
                                // Confere a presença de @ e domínio no e-mail.
                                final emailRegex =
                                    RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
                                if (!emailRegex.hasMatch(valor.trim())) {
                                  return 'Digite um e-mail válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // 3. CPF: apenas números e exatamente 11 dígitos.
                            TextFormField(
                              controller: _cpfController,
                              decoration: _decoracao(
                                rotulo: 'CPF',
                                dica: 'Somente números (11 dígitos)',
                                icone: Icons.badge_outlined,
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                              validator: (valor) {
                                if (valor == null || valor.isEmpty) {
                                  return 'Digite seu CPF';
                                }
                                if (valor.length != 11) {
                                  return 'O CPF deve ter 11 dígitos';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // 4. TELEFONE: apenas números, 10 ou 11 dígitos.
                            TextFormField(
                              controller: _telefoneController,
                              decoration: _decoracao(
                                rotulo: 'Telefone',
                                dica: 'DDD + número (10 ou 11 dígitos)',
                                icone: Icons.phone_outlined,
                              ),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                              validator: (valor) {
                                if (valor == null || valor.isEmpty) {
                                  return 'Digite seu telefone';
                                }
                                if (valor.length != 10 && valor.length != 11) {
                                  return 'O telefone deve ter 10 ou 11 dígitos';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // 5. SENHA: obrigatória, com no mínimo 6 caracteres.
                            TextFormField(
                              controller: _senhaController,
                              obscureText: !_mostrarSenha,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _cadastrar(),
                              autocorrect: false,
                              enableSuggestions: false,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(64),
                              ],
                              onChanged: (valor) {
                                // Feedback simples em tempo real (conteúdo da aula).
                                setState(() => _caracteresSenha = valor.length);
                              },
                              decoration: _decoracao(
                                rotulo: 'Senha',
                                dica: 'Mínimo de 6 caracteres',
                                icone: Icons.lock_outline,
                                sufixo: IconButton(
                                  tooltip: _mostrarSenha
                                      ? 'Ocultar senha'
                                      : 'Mostrar senha',
                                  icon: Icon(_mostrarSenha
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                  onPressed: () {
                                    setState(() => _mostrarSenha = !_mostrarSenha);
                                  },
                                ),
                              ),
                              validator: (valor) {
                                if (valor == null || valor.isEmpty) {
                                  return 'Digite uma senha';
                                }
                                if (valor.length < 6) {
                                  return 'A senha deve ter pelo menos 6 caracteres';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Caracteres da senha: $_caracteresSenha (mínimo: 6)',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF59677B),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 52,
                              child: ElevatedButton.icon(
                                onPressed: _cadastrar,
                                icon: const Icon(Icons.check_circle_outline),
                                label: const Text('CADASTRAR'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2154B8),
                                  foregroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Atividade prática de Flutter e Dart • Dados não são enviados.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Color(0xFF77849A)),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
