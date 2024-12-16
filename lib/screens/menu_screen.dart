import 'package:flutter/material.dart';
import 'budget_screen.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Principal"),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BudgetPage()),
            );
          },
          icon: const Icon(Icons.account_balance_wallet),
          label: const Text("Controle Financeiro"),
        ),
      ),
    );
  }
}
