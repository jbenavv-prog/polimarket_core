import 'package:flutter/material.dart';
import 'screens/provider_screen.dart';
import 'screens/inventario_screen.dart';
import 'screens/solicitar_producto_screen.dart';
import 'screens/usuarios_screen.dart';
import 'screens/customer_screen.dart';
import 'screens/product_screen.dart';

void main() => runApp(const PoliMarketApp());

class PoliMarketApp extends StatelessWidget {
  const PoliMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoliMarket Core',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      routes: {
        '/proveedores': (_) => const ProviderScreen(),
        '/inventario': (_) => const InventarioScreen(),
        '/solicitar': (_) => const SolicitarProductoScreen(),
        '/usuarios': (_) => const UsuariosScreen(),
        '/clientes': (_) => const CustomerScreen(),
        '/productos': (_) => const ProductScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PoliMarket Core')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menú', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Listar Proveedores'),
              onTap: () => Navigator.pushNamed(context, '/proveedores'),
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Listar Inventario'),
              onTap: () => Navigator.pushNamed(context, '/inventario'),
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Solicitar Producto'),
              onTap: () => Navigator.pushNamed(context, '/solicitar'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Listar Usuarios'),
              onTap: () => Navigator.pushNamed(context, '/usuarios'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Listar Clientes'),
              onTap: () => Navigator.pushNamed(context, '/clientes'),
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Listar Stock'),
              onTap: () => Navigator.pushNamed(context, '/productos'),
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Bienvenido a PoliMarket')),
    );
  }
}
