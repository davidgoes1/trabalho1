import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 219, 95, 45),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 235, 170, 31),
        ),
      ),
      home: const Telalogin(),
    );
  }
}

class Telalogin extends StatefulWidget {
  const Telalogin({super.key});

  @override
  _TelaloginState createState() => _TelaloginState();
}

class _TelaloginState extends State<Telalogin> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  String senhaError = '';
  bool _obscureSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tela de Login",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 5,
      ),
      drawer: _buildDrawer(context), // Adicionando o Drawer
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCustomTextField("Nome Completo", nomeController, Colors.black, false),
                const SizedBox(height: 20),
                _buildCustomTextField("Email", emailController, Colors.black, false),
                const SizedBox(height: 20),
                _buildCustomTextField("Senha", senhaController, Colors.black, true),
                const SizedBox(height: 20),
                if (senhaError.isNotEmpty)
                  Text(
                    senhaError,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 241, 139, 21),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CadastroPage()),
                    );
                  },
                  child: const Text("Não tem uma conta? Cadastre-se aqui"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextField(String label, TextEditingController controller, Color color, bool obscureText) {
    return TextField(
      controller: controller,
      obscureText: obscureText && _obscureSenha,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.deepPurple[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        suffixIcon: obscureText
            ? IconButton(
                icon: Icon(
                  _obscureSenha ? Icons.visibility : Icons.visibility_off,
                  color: const Color.fromARGB(255, 231, 85, 18),
                ),
                onPressed: () {
                  setState(() {
                    _obscureSenha = !_obscureSenha;
                  });
                },
              )
            : null,
      ),
    );
  }

  void _login() {
    String nome = nomeController.text;
    String email = emailController.text;
    String senha = senhaController.text;

    if (nome.isNotEmpty && email.isNotEmpty && senha.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuPage()),
      );
    } else {
      setState(() {
        senhaError = 'Preencha todos os campos!';
      });
    }
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 230, 150, 31),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Perfil', style: TextStyle(color: Colors.black)),
            onTap: () {
              // Lógica de navegação para Perfil
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Configurações', style: TextStyle(color: Colors.black)),
            onTap: () {
              // Lógica de navegação para Configurações
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Sair', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool _obscureSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro", style: TextStyle(color: Colors.black)),
      ),
      drawer: _buildDrawer(context), // Adicionando o Drawer
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildCustomTextField("Nome Completo", nomeController, Colors.black, false),
                const SizedBox(height: 20),
                _buildCustomTextField("Email", emailController, Colors.black, false),
                const SizedBox(height: 20),
                _buildCustomTextField("Senha", senhaController, Colors.black, true),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registrar,
                  child: const Text('Cadastrar', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 245, 130, 22),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextField(String label, TextEditingController controller, Color color, bool obscureText) {
    return TextField(
      controller: controller,
      obscureText: obscureText && _obscureSenha,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.deepPurple[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        suffixIcon: obscureText
            ? IconButton(
                icon: Icon(
                  _obscureSenha ? Icons.visibility : Icons.visibility_off,
                  color: const Color.fromARGB(255, 240, 149, 31),
                ),
                onPressed: () {
                  setState(() {
                    _obscureSenha = !_obscureSenha;
                  });
                },
              )
            : null,
      ),
    );
  }

  void _registrar() {
    String nome = nomeController.text;
    String email = emailController.text;
    String senha = senhaController.text;

    print('Usuário cadastrado: $nome, $email, $senha');
    Navigator.pop(context);
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 224, 102, 31),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Perfil', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Configurações', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Sair', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Principal", style: TextStyle(color: Colors.black)),
      ),
      drawer: _buildDrawer(context), // Adicionando o Drawer
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bem-vindo ao Menu Principal'),
            const SizedBox(height: 20),
            // Botão Controle Financeiro
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BudgetPage()),
                );
              },
              icon: const Icon(Icons.account_balance_wallet),
              label: const Text("Controle Financeiro"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 226, 117, 28),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 212, 124, 22),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Perfil', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Configurações', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Sair', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

// O restante do código para a página BudgetPage permanece o mesmo, adicionei o Drawer a ela também!

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  double _orcamento = 0;
  double _totalDespesas = 0;
  double _totalInvestimentos = 0;
  double _totalDividas = 0;

  final List<Map<String, dynamic>> _despesas = [];
  final List<Map<String, dynamic>> _investimento = [];
  final List<Map<String, dynamic>> _dividas = [];

  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  void _adicionarDespesa() {
    final double valor = double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0;
    final String descricao = _descricaoController.text;

    if (valor > 0 && descricao.isNotEmpty) {
      setState(() {
        _despesas.add({'descricao': descricao, 'valor': valor});
        _totalDespesas += valor;
      });
      _valorController.clear();
      _descricaoController.clear();
    }
  }

  void _definirOrcamento() {
    final double valor = double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0;
    if (valor > 0) {
      setState(() {
        _orcamento += valor;
      });
      _valorController.clear();
    }
  }

  void _adicionarInvestimento() {
    final double valor = double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0;
    final String descricao = _descricaoController.text;

    if (valor > 0 && descricao.isNotEmpty) {
      setState(() {
        _investimento.add({'descricao': descricao, 'valor': valor});
        _totalInvestimentos += valor;
      });
      _valorController.clear();
      _descricaoController.clear();
    }
  }

  void _adicionarDivida() {
    final double valor = double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0;
    final String descricao = _descricaoController.text;

    if (valor > 0 && descricao.isNotEmpty) {
      setState(() {
        _dividas.add({'descricao': descricao, 'valor': valor});
        _totalDividas += valor;
      });
      _valorController.clear();
      _descricaoController.clear();
    }
  }

  double _calcularSaldo() {
    return _orcamento - _totalDespesas - _totalDividas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Controle de Finanças", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Center(
        child: Container(
          height: 700,
          width: 450,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color.fromARGB(255, 238, 108, 22), Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_balance_wallet,
                color: Colors.black,
                size: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                "PocketCash",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 26),
              Text(
                'Orçamento: R\$${_orcamento.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _valorController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _adicionarDespesa,
                    child: const Text('Adicionar Despesa', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade800,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _definirOrcamento,
                    child: const Text('Definir Orçamento', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Despesas Totais: R\$${_totalDespesas.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                'Investimentos Totais: R\$${_totalInvestimentos.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                'Dívidas Totais: R\$${_totalDividas.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                'Sobrou: R\$${_calcularSaldo().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _calcularSaldo() > 0 ? Colors.green : (_calcularSaldo() < 0 ? Colors.red : Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _adicionarInvestimento,
                    child: const Text('Adicionar Investimento', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _adicionarDivida,
                    child: const Text('Adicionar Dívida', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    if (_despesas.isNotEmpty) ...[
                      const Text(
                        'Despesas:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      for (var despesa in _despesas)
                        ListTile(
                          title: Text(despesa['descricao'], style: const TextStyle(color: Colors.black)),
                          trailing: Text('R\$${despesa['valor'].toStringAsFixed(2)}', style: const TextStyle(color: Colors.black)),
                        ),
                    ],
                    if (_investimento.isNotEmpty) ...[
                      const Text(
                        'Investimentos:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      for (var investimento in _investimento)
                        ListTile(
                          title: Text(investimento['descricao'], style: const TextStyle(color: Colors.black)),
                          trailing: Text('R\$${investimento['valor'].toStringAsFixed(2)}', style: const TextStyle(color: Colors.black)),
                        ),
                    ],
                    if (_dividas.isNotEmpty) ...[
                      const Text(
                        'Dívidas:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      for (var divida in _dividas)
                        ListTile(
                          title: Text(divida['descricao'], style: const TextStyle(color: Colors.black)),
                          trailing: Text('R\$${divida['valor'].toStringAsFixed(2)}', style: const TextStyle(color: Colors.black)),
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 202, 109, 32),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Perfil', style: TextStyle(color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Configurações', style: TextStyle(color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Sair', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
