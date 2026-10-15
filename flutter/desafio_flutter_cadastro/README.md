# Desafio — Formulários e Validações no Flutter

Projeto de cadastro de usuário elaborado conforme **a página 25 (Desafio)** do PDF do professor, considerando também o exemplo prático e a estrutura da atividade nas páginas 23 e 24.

## Requisitos atendidos

- Cinco campos com `TextFormField`: **nome completo, e-mail, CPF, telefone e senha**.
- Todos agrupados em `Form` identificado por `GlobalKey<FormState>`.
- `TextEditingController` para captura dos dados, com `dispose()`.
- `InputDecoration` com rótulos, dicas, ícones e bordas.
- `keyboardType` adequado para cada tipo de entrada.
- `FilteringTextInputFormatter.digitsOnly` em CPF e telefone.
- Limite de 11 dígitos para CPF e telefone.
- Campos obrigatórios e validações específicas:
  - Nome: deve ser preenchido;
  - E-mail: deve estar preenchido e possuir formato com `@` e domínio;
  - CPF: deve conter exatamente 11 dígitos;
  - Telefone: deve conter 10 ou 11 dígitos;
  - Senha: deve conter pelo menos 6 caracteres.
- Mensagens de erro exibidas embaixo dos campos (`validator`).
- Botão **CADASTRAR** que utiliza `_formKey.currentState!.validate()`.
- `SnackBar` de sucesso após a validação completa.
- `SingleChildScrollView`, `Padding` e `SizedBox` para boa apresentação e evitar overflow.
- Extra da aula: contador de caracteres da senha em tempo real por `onChanged` e opção de mostrar/ocultar senha.

> **Observação importante:** esta é uma atividade local de validação e interface; o formulário **não** cria uma conta real nem persiste informações em banco de dados. O próximo tópico do material é integração com servidor e APIs.
>
> A validação do CPF segue o exemplo ensinado no PDF: **quantidade de 11 dígitos**. Não verifica os dígitos verificadores da Receita Federal, pois isso não foi solicitado no desafio.

## Como executar

1. Instale o [Flutter SDK](https://docs.flutter.dev/get-started/install) e confirme que o comando `flutter doctor` funciona.
2. Extraia o arquivo ZIP e abra a pasta `desafio_flutter_cadastro` no VS Code ou Android Studio.
3. No terminal, dentro da pasta, execute:

```bash
flutter create --project-name desafio_flutter_cadastro --platforms=android,web .
flutter pub get
flutter run -d chrome
```

O comando `flutter create` gera as pastas nativas da plataforma (como `android/` e `web/`) que não estão incluídas no ZIP. O arquivo principal da solução já está presente em `lib/main.dart`. **Não execute** `flutter create` com `--overwrite`.

Para rodar em um emulador Android, inicie-o e execute `flutter run`.

Se você já possui um projeto Flutter criado, basta substituir o conteúdo de `lib/main.dart` pelo código deste projeto e executar `flutter run`.

## Testar

```bash
flutter test
```

Os testes em `test/widget_test.dart` verificam a exibição dos cinco campos, erros para campos vazios, rejeição de valores inválidos e `SnackBar` no preenchimento válido.

## Exemplos para testar manualmente

| Campo | Exemplo válido | Exemplo inválido |
| --- | --- | --- |
| Nome completo | Maria Silva | Campo vazio |
| E-mail | maria@email.com | mariaemail.com |
| CPF | 12345678901 | 12345 |
| Telefone | 62999999999 | 62999 |
| Senha | 123456 | 123 |

**Importante:** os CPFs acima são apenas sequências para exercitar o limite de caracteres, não documentos reais validados.

## Estrutura dos arquivos

```text
desafio_flutter_cadastro/
├── lib/
│   └── main.dart
├── test/
│   └── widget_test.dart
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

Não utiliza bibliotecas externas para máscaras: o exercício pede entradas apenas numéricas para CPF e telefone, e isso é feito com os formatadores nativos do Flutter.
