class CreateOrderRequest {
  final String customerName;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final List<CreateOrderItem> items;

  CreateOrderRequest({
    required this.customerName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CreateOrderItem {
  final int productId;
  final int quantity;

  CreateOrderItem({required this.productId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'quantity': quantity};
  }
}
