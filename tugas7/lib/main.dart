import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isSelected1 = true;
  bool isSelected2 = false;
  bool isChooseAllSelected = false;
  double totalPayment = 50000000;
  bool showDetail1 = false;
  bool showDetail2 = false;

  void updateTotalPayment() {
    totalPayment = (isSelected1 ? 50000000 : 0) + (isSelected2 ? 4500000 : 0);
  }

  void toggleChooseAll(bool? value) {
    setState(() {
      isChooseAllSelected = value!;
      isSelected1 = value;
      isSelected2 = value;
      updateTotalPayment();
    });
  }

  void updateChooseAllState() {
    setState(() {
      isChooseAllSelected = isSelected1 && isSelected2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Checkout'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[800]),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Perlu diketahui, proses verifikasi transaksi dapat memakan waktu hingga 1x24 jam.',
                      style: TextStyle(color: Colors.blue[800]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Choose All', style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Checkbox(
                  value: isChooseAllSelected,
                  onChanged: toggleChooseAll,
                ),
              ],
            ),
            buildBillItem(
              context: context,
              name: 'Garuda Indonesia',
              isSelected: isSelected1,
              amount: 50000000,
              dueDate: '16 Feb 2024',
              showDetail: showDetail1,
              imageUrl: 'https://tse3.mm.bing.net/th?id=OIP.ZAkeNlw66Cpn8PKC-ypQsAHaE0&pid=Api&P=0&h=220',
              detailText: [
                'Maskapai Penerbangan: Garuda Indonesia',
                'ID Pelanggan: 1109837800',
                'Paket Layanan: First Class',
                'Lokasi: YIA (Yogyakarta) - Phuket (Thailand)',
                'Jadwal Keberangkatan: 16 Feb 2024, 10:00 AM',
                'Kursi Duduk: 1A'
              ],
              onChanged: (bool? value) {
                setState(() {
                  isSelected1 = value!;
                  updateTotalPayment();
                  updateChooseAllState();
                });
              },
              onToggleDetail: () {
                setState(() {
                  showDetail1 = !showDetail1;
                });
              },
            ),
            buildBillItem(
              context: context,
              name: 'Lion Air',
              isSelected: isSelected2,
              amount: 4500000,
              dueDate: '20 Feb 2024',
              showDetail: showDetail2,
              imageUrl: 'https://tse3.mm.bing.net/th?id=OIP.1ya9FSskXWuvu3XDmEO5NwHaHa&pid=Api&P=0&h=220',
              detailText: [
                'Maskapai Penerbangan: Lion Air',
                'ID Pelanggan: 11067893567',
                'Paket Layanan: Economy Class',
                'Lokasi: Soekarno-Hatta (Jakarta) - YIA (Yogyakarta)',
                'Jadwal Keberangkatan: 20 Feb 2024, 2:00 PM',
                'Kursi Duduk: 22B'
              ],
              onChanged: (bool? value) {
                setState(() {
                  isSelected2 = value!;
                  updateTotalPayment();
                  updateChooseAllState();
                });
              },
              onToggleDetail: () {
                setState(() {
                  showDetail2 = !showDetail2;
                });
              },
            ),
            SizedBox(height: 16.0),
            Divider(),
            ListTile(
              title: Text('Transaction History', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Aksi saat "Transaction History" ditekan
              },
            ),
            Spacer(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.receipt_long, color: Colors.blue[800]),
                    SizedBox(width: 8.0),
                    Text('Total Pembayaran'),
                  ],
                ),
                Text(
                  'Rp${totalPayment.toStringAsFixed(0)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding: EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: Text('PAY NOW', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBillItem({
    required BuildContext context,
    required String name,
    required bool isSelected,
    required double amount,
    required String dueDate,
    required bool showDetail,
    required String imageUrl,
    required List<String> detailText,
    required ValueChanged<bool?> onChanged,
    required VoidCallback onToggleDetail,
  }) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Image.network(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.contain,  // Menggunakan BoxFit.contain agar gambar tidak terpotong
            ),
            title: Text('$name\nRp${amount.toStringAsFixed(0)}'),
            subtitle: Text('Due date on $dueDate'),
            trailing: Checkbox(
              value: isSelected,
              onChanged: onChanged,
            ),
          ),
          if (showDetail)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: detailText.map((text) {
                  var parts = text.split(': ');
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(parts[0] + ':'),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(parts[1]),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          TextButton(
            onPressed: onToggleDetail,
            child: Text(showDetail ? 'Hide Details' : 'See Details'),
          ),
        ],
      ),
    );
  }
}
