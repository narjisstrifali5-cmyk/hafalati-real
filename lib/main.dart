import 'package:flutter/material.dart';

void main() {
  runApp(HafalatiApp());
}

class HafalatiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hafalati Real MVP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink, useMaterial3: true),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  void _login() {
    setState(() => _isLoading = true);
    final email = _emailController.text.trim().toLowerCase();
    
    Future.delayed(Duration(seconds: 1), () {
      setState(() => _isLoading = false);
      if (email == 'narjisstrifali5@gmail.com') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AdminDashboard()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ClientHome()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.pink.shade200, Colors.purple.shade200], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.celebration, size: 60, color: Colors.pink),
                  SizedBox(height: 10),
                  Text('Hafalati - MVP الحقيقي', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text('تطبيق شغال بالكود - ماشي تصويرة', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 20),
                  TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: Icon(Icons.email))),
                  SizedBox(height: 20),
                  _isLoading ? CircularProgressIndicator() : SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _login, style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, padding: EdgeInsets.all(15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text('دخول - تجريب MVP', style: TextStyle(fontSize: 16, color: Colors.white)))),
                  SizedBox(height: 10),
                  Text('دخلي narjisstrifali5@gmail.com باش تمشي للأدمن', style: TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ClientHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hafalati - الخدمات'), backgroundColor: Colors.pink),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _serviceCard('ميكاب احترافي', '500 درهم', Icons.brush, Colors.pink),
          _serviceCard('ديكور حفلات', '1200 درهم', Icons.deck, Colors.purple),
          _serviceCard('تصوير', '800 درهم', Icons.camera_alt, Colors.orange),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم الحجز! هادا MVP خدام ديال بصح'))), label: Text('جرب الحجز'), icon: Icon(Icons.book)),
    );
  }
  Widget _serviceCard(String title, String price, IconData icon, Color color) {
    return Card(margin: EdgeInsets.only(bottom: 12), child: ListTile(leading: CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)), title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(price), trailing: Icon(Icons.arrow_forward_ios, size: 16)));
  }
}

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('لوحة الأدمن - الربح 15%'), backgroundColor: Colors.black87),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(color: Colors.green.shade50, child: ListTile(title: Text('الربح ديالك اليوم'), subtitle: Text('15% من كل حجز'), trailing: Text('450 درهم', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)))),
            SizedBox(height: 20),
            Text('هادا هو الـ Functional MVP - Backend غادي نزيدوه فالمرحلة الجاية مع Firebase', textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen())), child: Text('رجوع')),
          ],
        ),
      ),
    );
  }
}
