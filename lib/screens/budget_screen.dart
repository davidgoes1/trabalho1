import 'package:flutter/material.dart';

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