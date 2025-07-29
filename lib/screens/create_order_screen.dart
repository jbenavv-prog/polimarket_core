import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../services/api_service_products.dart';
import '../services/api_service_orders.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  List<Product> _products = [];
  Product? _selectedProduct;
  final TextEditingController _quantityController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await ApiServiceProducts.fetchProducts();
      setState(() {
        _products = products;
        _selectedProduct = products.isNotEmpty ? products.first : null;
        _isLoading = false;
      });
    } catch (e) {
      print('Error al cargar productos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submitOrder() async {
    final quantity = int.tryParse(_quantityController.text);
    if (_selectedProduct == null || quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona un producto y una cantidad válida')),
      );
      return;
    }

    final order = Order(
      product_id: _selectedProduct!.product_id,
      quantity: quantity,
    );

    try {
      final success = await ApiServiceOrders.createOrder(order);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Orden creada con éxito')),
        );
        _quantityController.clear();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al crear la orden')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Orden')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Producto'),
            DropdownButton<Product>(
              isExpanded: true,
              value: _selectedProduct,
              onChanged: (Product? newValue) {
                setState(() {
                  _selectedProduct = newValue;
                });
              },
              items: _products.map((Product product) {
                return DropdownMenuItem<Product>(
                  value: product,
                  child: Text('${product.product_name} (Stock: ${product.product_stock})'),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Cantidad',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _submitOrder,
                child: const Text('Enviar Pedido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
