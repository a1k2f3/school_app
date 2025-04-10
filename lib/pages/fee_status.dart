import 'package:flutter/material.dart';

class FeeStatusComponent extends StatefulWidget {
  const FeeStatusComponent({super.key});

  @override
  _FeeStatusComponentState createState() => _FeeStatusComponentState();
}

class _FeeStatusComponentState extends State<FeeStatusComponent> {
  // Dummy invoice data. In a real app, you might fetch this from a server.
  List<Invoice> invoiceList = [
    Invoice(invoiceNumber: "INV001", date: "2025-02-22", amount: 500.00, status: "Paid"),
    Invoice(invoiceNumber: "INV002", date: "2025-01-15", amount: 750.00, status: "Pending"),
    Invoice(invoiceNumber: "INV003", date: "2024-12-05", amount: 300.00, status: "Paid"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fee Status'),
      ),
      body: ListView.builder(
        itemCount: invoiceList.length,
        itemBuilder: (context, index) {
          final invoice = invoiceList[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            elevation: 2,
            child: ListTile(
              leading: Icon(
                invoice.status == "Paid" ? Icons.check_circle : Icons.pending,
                color: invoice.status == "Paid" ? Colors.green : Colors.orange,
              ),
              title: Text("Invoice: ${invoice.invoiceNumber}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date: ${invoice.date}"),
                  Text("Amount: \$${invoice.amount.toStringAsFixed(2)}"),
                ],
              ),
              trailing: Text(
                invoice.status,
                style: TextStyle(
                  color: invoice.status == "Paid" ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Invoice {
  final String invoiceNumber;
  final String date;
  final double amount;
  final String status;

  Invoice({
    required this.invoiceNumber,
    required this.date,
    required this.amount,
    required this.status,
  });
}
