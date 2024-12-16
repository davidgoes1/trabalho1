import 'package:flutter/material.dart';

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