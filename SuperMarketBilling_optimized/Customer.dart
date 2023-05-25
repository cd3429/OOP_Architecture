import 'Items.dart';

class Customer {
  int id;
  String name;
  String mobileNumber;
  List<Item> cart;

  Customer(this.id, this.name, this.mobileNumber) : cart = <Item>[];

  void displayCart() {
    print("--------------------------------------------");
    print('Customer ID: $id');
    print('Name: $name');
    print('Mobile Number: $mobileNumber');
    print("--------------------------------------------");
    print('Cart:');

    if (cart.isEmpty) {
      print('Cart is empty.');
    } else {
      print('Item ID:\tName:\t\t\tPrice:');
      cart.forEach((item) {
        int quantity = cart.where((i) => i.id == item.id).length;
        print(
            '${item.id}\t\t${item.quantity}x ${item.name}\t\t${item.price * quantity}');
      });
      print("--------------------------------------------");
    }
  }
}
