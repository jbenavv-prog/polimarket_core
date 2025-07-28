class Provider {
  final int provider_id;
  final String provider_name;
  final String provider_email;

  Provider({required this.provider_id, required this.provider_name, required this.provider_email});

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    provider_id: json['provider_id'] ?? 0,
    provider_name: json['provider_name'] ?? '',
    provider_email: json['provider_email'] ?? '',
  );
}