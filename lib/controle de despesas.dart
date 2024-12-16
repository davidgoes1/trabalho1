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
      home: BudgetPage(),
    );
  }
}

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  double _orcamento = 0;
  double _totalDespesas = 0;
  double _totalInvestimentos = 0; // eu adicionei essa função
  double _totalDividas = 0; // essa também

  final List<Map<String, dynamic>> _despesas = [];
  final List<Map<String, dynamic>> _investimento =[]; // eu adicionei essa também
  final List<Map<String, dynamic>> _dividas =[]; // essa também

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
    final double valor = double.tryParse(_valorController.text.replaceAll(',','.')) ?? 0;
    final String descricao = _descricaoController.text;

    if(valor > 0 && descricao.isNotEmpty) {
      setState(() {
        _investimento.add({'descricao': descricao, 'valor': valor});
        _totalInvestimentos += valor;
      });
      _valorController.clear();
      _descricaoController.clear();
    }
  }  // adicionei esse void

   void _adicionarDivida() {
    final double valor = double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0;
    final String descricao = _descricaoController.text;

    if(valor > 0 && descricao.isNotEmpty) {
      setState(() {
        _dividas.add({'descricao': descricao, 'valor': valor});
        _totalDividas += valor;
      });
      _valorController.clear();
      _descricaoController.clear();
    }
  }   // adicionei esse void

  double _calcularSaldo() {
    return _orcamento - _totalDespesas - _totalDividas; 
  } // esse já tinha eu só coloque totalDividas

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Container(
          height: 700,
          width: 450,
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 120,
              ),
              SizedBox(height: 20),
              Text(
                "PocketCash",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 26), // mudei a numero que tinha aqui '30'
              Text(
                'Orçamento: R\$${_orcamento.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _valorController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Valor',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _adicionarDespesa,
                    child: Text('Adicionar Despesa'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade800,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _definirOrcamento,
                    child: Text('Definir Orçamento'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Despesas Totais: R\$${_totalDespesas.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Investimentos Totais: R\$${_totalInvestimentos.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16), // essa parte do invetimento e da dívida sao minha 
              ),
              Text(
                'Dívidas Totais: R\$${_totalDividas.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16), // essa também
              ),
              Text(
                'Sobrou: R\$${_calcularSaldo().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _adicionarInvestimento,
                    child: Text('Adicionar Investimento'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _adicionarDivida,
                    child: Text('Adicionar Dívida'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ],
              ), // essas são meus 
              Expanded(
                child: ListView(
                  children: <Widget>[
                    if (_despesas.isNotEmpty) ...[
                      Text(
                        'Despesas:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      for (var despesa in _despesas)
                        ListTile(
                          title: Text(despesa['descricao']),
                          trailing: Text('R\$${despesa['valor'].toStringAsFixed(2)}'),
                        ),
                    ],
                    if (_investimento.isNotEmpty) ...[
                      Text(
                        'Investimentos:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      for (var investimento in _investimento)
                        ListTile(
                          title: Text(investimento['descricao']),
                          trailing: Text('R\$${investimento['valor'].toStringAsFixed(2)}'),
                        ),
                    ],
                    if (_dividas.isNotEmpty) ...[
                      Text(
                        'Dívidas:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      for (var divida in _dividas)
                        ListTile(
                          title: Text(divida['descricao']),
                          trailing: Text('R\$${divida['valor'].toStringAsFixed(2)}'),
                        ), // investimento e Dívida são meus
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
}