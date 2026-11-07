import 'package:flutter/material.dart';

void main() => runApp(const FamAcademicoApp());

const laranjaFam = Color(0xFFF58220);
const pretoFam = Color(0xFF20232A);

class Curso {
  final String nome;
  final int horas;
  final String descricao;
  const Curso(this.nome, this.horas, this.descricao);
}

const cursos = <Curso>[
  Curso(
    'Sistemas de Informação',
    3200,
    'Formação voltada à análise, ao desenvolvimento e à gestão de soluções de tecnologia da informação.',
  ),
  Curso(
    'Administração',
    3000,
    'Formação em gestão organizacional, planejamento estratégico e processos administrativos.',
  ),
  Curso(
    'Design Gráfico',
    2400,
    'Formação em comunicação visual, identidade gráfica e desenvolvimento de projetos criativos.',
  ),
  Curso(
    'Análise e Desenvolvimento de Sistemas',
    2000,
    'Formação prática em desenvolvimento de aplicações, programação e soluções digitais.',
  ),
];

class FamAcademicoApp extends StatelessWidget {
  const FamAcademicoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'FAM Acadêmico | Ambiente de Aprendizagem',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: laranjaFam),
      scaffoldBackgroundColor: const Color(0xFFF7F7F8),
      appBarTheme: const AppBarTheme(
        backgroundColor: pretoFam,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    ),
    initialRoute: '/login',
    routes: {
      '/login': (_) => const LoginTela(),
      '/inicio': (_) => const PrincipalTela(),
      '/perfil': (_) => const PerfilTela(),
      '/cadastro': (_) => const CadastroTela(),
    },
  );
}

class LogoFam extends StatelessWidget {
  final double largura;
  const LogoFam({super.key, this.largura = 160});
  @override
  Widget build(BuildContext context) => Image.asset(
    'assets/images/logo_FAM.png',
    width: largura,
    errorBuilder: (_, _, _) => const Text(
      'FAM',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: laranjaFam,
      ),
    ),
  );
}

class LoginTela extends StatefulWidget {
  const LoginTela({super.key});
  @override
  State<LoginTela> createState() => _LoginTelaState();
}

class _LoginTelaState extends State<LoginTela> {
  final chave = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void entrar() {
    if (!chave.currentState!.validate()) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PrincipalTela()),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Acesso ao Portal Acadêmico')),
    body: Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: chave,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: LogoFam(largura: 210)),
                  const SizedBox(height: 28),
                  const Text(
                    'Portal Acadêmico FAM',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Bem-vindo ao ambiente acadêmico. Informe seus dados para continuar.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail acadêmico',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty)
                        return 'Por favor, informe seu e-mail.';
                      if (!v.contains('@') || !v.contains('.'))
                        return 'Informe um endereço de e-mail válido.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha de acesso',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (v) => v == null || v.length < 4
                        ? 'A senha deve conter pelo menos 4 caracteres.'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: entrar,
                    child: const Text('Acessar ambiente acadêmico'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Ambiente de demonstração: utilize um e-mail válido e uma senha com pelo menos 4 caracteres. Não utilize sua senha institucional.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class PrincipalTela extends StatefulWidget {
  const PrincipalTela({super.key});
  @override
  State<PrincipalTela> createState() => _PrincipalTelaState();
}

class _PrincipalTelaState extends State<PrincipalTela> {
  int aba = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(['Início', 'Cursos', 'Configurações'][aba])),
    drawer: Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFFFF3E8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoFam(largura: 200),
                  SizedBox(height: 12),
                  Text(
                    'Portal Acadêmico FAM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: pretoFam,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
                setState(() => aba = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.school_outlined),
              title: const Text('Cursos'),
              onTap: () {
                Navigator.pop(context);
                setState(() => aba = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/perfil');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add_alt),
              title: const Text('Cadastro'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cadastro');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                setState(() => aba = 2);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Encerrar acesso'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    ),
    body: IndexedStack(
      index: aba,
      children: const [
        InicioConteudo(),
        CursosConteudo(),
        ConfiguracoesConteudo(),
      ],
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: aba,
      onDestinationSelected: (indice) => setState(() => aba = indice),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(Icons.school_outlined),
          selectedIcon: Icon(Icons.school),
          label: 'Cursos',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Ajustes',
        ),
      ],
    ),
  );
}

class InicioConteudo extends StatelessWidget {
  const InicioConteudo({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFFE1C5)),
        ),
        child: const Column(
          children: [
            LogoFam(largura: 230),
            SizedBox(height: 12),
            Text(
              'Portal Acadêmico FAM',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      const Text(
        'Bem-vindo ao seu ambiente acadêmico!',
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      const Text(
        'Acesse os recursos disponíveis para acompanhar informações acadêmicas e conhecer os cursos apresentados neste ambiente.',
      ),
      const SizedBox(height: 12),
      const Text(
        'Atenção: os dados apresentados são ilustrativos e não representam registros acadêmicos oficiais.',
      ),
      const SizedBox(height: 20),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Serviços acadêmicos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Consulte as informações dos cursos, visualize seu perfil de demonstração ou realize um cadastro de exemplo.',
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/cadastro'),
                icon: const Icon(Icons.person_add),
                label: const Text('Realizar cadastro'),
              ),
              OutlinedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/perfil'),
                icon: const Icon(Icons.person),
                label: const Text('Consultar meu perfil'),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class CursosConteudo extends StatelessWidget {
  const CursosConteudo({super.key});
  @override
  Widget build(BuildContext context) => ListView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: cursos.length,
    itemBuilder: (context, i) {
      final curso = cursos[i];
      return Card(
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color(0xFFFFE6D0),
            child: Icon(Icons.menu_book, color: pretoFam),
          ),
          title: Text(curso.nome),
          subtitle: Text('Carga horária ilustrativa: ${curso.horas} horas'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetalhesCursoTela(curso: curso)),
          ),
        ),
      );
    },
  );
}

class DetalhesCursoTela extends StatelessWidget {
  final Curso curso;
  const DetalhesCursoTela({super.key, required this.curso});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Informações do curso')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.school, color: laranjaFam, size: 64),
          const SizedBox(height: 20),
          Text(
            curso.nome,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text('Carga horária de referência: ${curso.horas} horas'),
          const SizedBox(height: 12),
          Text(curso.descricao),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Retornar à lista de cursos'),
          ),
        ],
      ),
    ),
  );
}

class PerfilTela extends StatelessWidget {
  const PerfilTela({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Perfil acadêmico')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(radius: 28, child: Icon(Icons.person, size: 30)),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Estudante de demonstração',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Curso de referência: Sistemas de Informação'),
          const SizedBox(height: 12),
          const Text('E-mail de demonstração: aluno@exemplo.com'),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Retornar à página anterior'),
          ),
        ],
      ),
    ),
  );
}

class CadastroTela extends StatefulWidget {
  const CadastroTela({super.key});
  @override
  State<CadastroTela> createState() => _CadastroTelaState();
}

class _CadastroTelaState extends State<CadastroTela> {
  final chave = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void cadastrar() {
    if (!chave.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cadastro de ${nomeController.text.trim()} validado com sucesso! Esta é uma confirmação de demonstração; os dados não foram armazenados.',
        ),
      ),
    );
    nomeController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Cadastro de estudante')),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: chave,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Cadastro acadêmico',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome completo do estudante',
                ),
                validator: (valor) => valor == null || valor.trim().isEmpty
                    ? 'O nome completo é obrigatório.'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail acadêmico',
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty)
                    return 'Por favor, informe seu e-mail.';
                  if (!valor.contains('@') || !valor.contains('.'))
                    return 'Informe um endereço de e-mail válido.';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: cadastrar,
                icon: const Icon(Icons.check),
                label: const Text('Confirmar cadastro'),
              ),
              const SizedBox(height: 12),
              const Text(
                'Este formulário é exclusivamente didático. Os dados informados não são armazenados nem enviados a servidores.',
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class ConfiguracoesConteudo extends StatefulWidget {
  const ConfiguracoesConteudo({super.key});
  @override
  State<ConfiguracoesConteudo> createState() => _ConfiguracoesConteudoState();
}

class _ConfiguracoesConteudoState extends State<ConfiguracoesConteudo> {
  bool termos = false;
  bool notificacoes = true;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        'Preferências do ambiente acadêmico',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      const Text(
        'Defina as opções de uso do aplicativo. As alterações são temporárias e válidas somente durante esta execução.',
      ),
      const SizedBox(height: 20),
      CheckboxListTile(
        title: const Text(
          'Declaro estar ciente das condições de uso deste ambiente de demonstração.',
        ),
        value: termos,
        onChanged: (valor) => setState(() => termos = valor ?? false),
      ),
      SwitchListTile(
        title: const Text('Habilitar notificações acadêmicas (demonstração)'),
        value: notificacoes,
        onChanged: (valor) => setState(() => notificacoes = valor),
      ),
      const SizedBox(height: 20),
      Text('Ciência das condições: ${termos ? 'Confirmada' : 'Pendente'}'),
      Text('Notificações: ${notificacoes ? 'Habilitadas' : 'Desabilitadas'}'),
    ],
  );
}
