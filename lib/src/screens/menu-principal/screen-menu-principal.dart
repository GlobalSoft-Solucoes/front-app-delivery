import 'package:flutter/material.dart';

class MenuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  @override
  
  Widget build(BuildContext context) {
    String title =  "MenuPrincipal";
    return Scaffold(     
      
      appBar: AppBar(title: Text(title)),
        body: GridView.count(
          padding: EdgeInsets.only(top: 20),
          crossAxisCount: 3,
          children: List.generate(30,(index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: ()=> Navigator.of(context).pushNamed('/Comandas'),                    
                child: Container(                  
                  decoration: BoxDecoration(color: Colors.brown, borderRadius: BorderRadius.circular(16),),
                  child: Center(
                      child: Text(
                    'Mesa ${index + 1}',
                    style: TextStyle(
                      fontSize: 25,                     
                    ),
                  ) //
                  ),
                  ),
                  )
                );
            },
          ),
      ),
      drawer: Drawer(      
        child: ListView(
          
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Comandas'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Produtos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
