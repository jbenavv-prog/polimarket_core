import 'package:flutter/material.dart';
import '../models/provider.dart';
import '../services/api_service_providers.dart';

class ProviderScreen extends StatefulWidget {
  const ProviderScreen({super.key});

  @override
  State<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  late Future<List<Provider>> _providers;

  @override
  void initState() {
    super.initState();
    _providers = ApiServiceProviders.fetchProviders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Proveedores')),
      body: FutureBuilder<List<Provider>>(
        future: _providers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay Proveedores'));
          }

          final providers = snapshot.data!;
          return ListView.builder(
            itemCount: providers.length,
            itemBuilder: (context, index) {
              final provider = providers[index];
              return ListTile(
                leading: CircleAvatar(child: Text(provider.provider_id.toString())),
                title: Text(provider.provider_name),
                subtitle: Text(provider.provider_email),
              );
            },
          );
        },
      ),
    );
  }
}
