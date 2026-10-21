import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const ADMIN_EMAIL = "narjisstrifali5@gmail.com";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: AuthGate()));
}

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (c, s) {
        if (!s.hasData) return LoginPage();
        if (s.data!.email == ADMIN_EMAIL) return AdminPage();
        return HomePage();
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final e = TextEditingController();
  final p = TextEditingController();
  String m = "";
  login() async { try { await FirebaseAuth.instance.signInWithEmailAndPassword(email: e.text.trim(), password: p.text.trim()); } catch (x) { setState(()=>m=x.toString()); } }
  reg() async { try { await FirebaseAuth.instance.createUserWithEmailAndPassword(email: e.text.trim(), password: p.text.trim()); } catch (x) { setState(()=>m=x.toString()); } }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(padding: EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Hafalati - حفلاتي", style: TextStyle(fontSize:28, fontWeight: FontWeight.bold, color: Colors.pink)),
      TextField(controller: e, decoration: InputDecoration(labelText: "Email")),
      TextField(controller: p, obscureText: true, decoration: InputDecoration(labelText: "Password")),
      Text(m, style: TextStyle(color: Colors.red, fontSize:12)),
      SizedBox(height:16),
      ElevatedButton(onPressed: login, child: Text("دخول"), style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity,48))),
      SizedBox(height:8),
      OutlinedButton(onPressed: reg, child: Text("تسجيل جديد"), style: OutlinedButton.styleFrom(minimumSize: Size(double.infinity,48))),
    ])));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hafalati Feed"), actions: [IconButton(icon: Icon(Icons.logout), onPressed: ()=>FirebaseAuth.instance.signOut())]),
      body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('posts').snapshots(), builder: (c,s){
        if(!s.hasData) return Center(child: CircularProgressIndicator());
        return ListView(children: s.data!.docs.map((d)=>Card(child: ListTile(title: Text(d['title']??'خدمة'), subtitle: Text("${d['price']} MAD - عمولتك 15%")))).toList());
      }),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: ()=>FirebaseFirestore.instance.collection('posts').add({'title':'ميكاب عرايس','price':1000,'created':FieldValue.serverTimestamp()})),
    );
  }
}

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("أدمن نرجس"), backgroundColor: Colors.pink), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("أنت الأدمن!", style: TextStyle(fontSize:24, fontWeight: FontWeight.bold)),
      Text(ADMIN_EMAIL),
      SizedBox(height:20),
      Card(child: ListTile(title: Text("الربح 15%"), subtitle: Text("0 MAD"), leading: Icon(Icons.money))),
      ElevatedButton(onPressed: ()=>FirebaseAuth.instance.signOut(), child: Text("خروج"))
    ])));
  }
}
