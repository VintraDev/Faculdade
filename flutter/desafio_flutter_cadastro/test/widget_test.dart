import 'package:desafio_flutter_cadastro/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Apresenta os cinco campos exigidos pelo professor', (tester) async {
    await tester.pumpWidget(const CadastroApp());

    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.text('Nome completo'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('CPF'), findsOneWidget);
    expect(find.text('Telefone'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('CADASTRAR'), findsOneWidget);
  });

  testWidgets('Exibe erros quando todos os campos estão vazios', (tester) async {
    await tester.pumpWidget(const CadastroApp());
    await tester.ensureVisible(find.text('CADASTRAR'));
    await tester.tap(find.text('CADASTRAR'));
    await tester.pumpAndSettle();

    expect(find.text('Digite seu nome completo'), findsOneWidget);
    expect(find.text('Digite seu e-mail'), findsOneWidget);
    expect(find.text('Digite seu CPF'), findsOneWidget);
    expect(find.text('Digite seu telefone'), findsOneWidget);
    expect(find.text('Digite uma senha'), findsOneWidget);
  });

  testWidgets('Reprova e-mail inválido, CPF curto e senha curta', (tester) async {
    await tester.pumpWidget(const CadastroApp());
    final campos = find.byType(TextFormField);

    await tester.enterText(campos.at(0), 'Maria Silva');
    await tester.enterText(campos.at(1), 'maria-sem-arroba');
    await tester.enterText(campos.at(2), '123');
    await tester.enterText(campos.at(3), '62999999999');
    await tester.enterText(campos.at(4), '123');
    await tester.ensureVisible(find.text('CADASTRAR'));
    await tester.tap(find.text('CADASTRAR'));
    await tester.pumpAndSettle();

    expect(find.text('Digite um e-mail válido'), findsOneWidget);
    expect(find.text('O CPF deve ter 11 dígitos'), findsOneWidget);
    expect(
      find.text('A senha deve ter pelo menos 6 caracteres'),
      findsOneWidget,
    );
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('Cadastro válido apresenta SnackBar de confirmação', (tester) async {
    await tester.pumpWidget(const CadastroApp());
    final campos = find.byType(TextFormField);

    await tester.enterText(campos.at(0), 'Maria Silva');
    await tester.enterText(campos.at(1), 'maria@email.com');
    await tester.enterText(campos.at(2), '12345678901');
    await tester.enterText(campos.at(3), '62999999999');
    await tester.enterText(campos.at(4), '123456');
    await tester.ensureVisible(find.text('CADASTRAR'));
    await tester.tap(find.text('CADASTRAR'));
    await tester.pump();

    expect(
      find.text('Cadastro realizado com sucesso, Maria Silva!'),
      findsOneWidget,
    );
  });
}
