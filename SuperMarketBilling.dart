import 'dart:io';

class Item {
  int id;
  String name;
  double price;

  Item(this.id, this.name, this.price);
}

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
      print('Item ID:\tName:\t\tPrice:');
      for (var item in cart) {
        print('${item.id}\t\t${item.name}\t\t${item.price}');
      }
      print("--------------------------------------------");
    }
  }
}

class Supermarket {
  List<Item> items;
  List<Customer> customers;

  Supermarket()
      : items = [],
        customers = [];

  void displayItems() {
    if (items.isEmpty) {
      print('No items available.');
    } else {
      print('---------------------------------------------------');
      print('Available Items:');
      print('---------------------------------------------------');
      print('Item ID:\tName:\t\tPrice:');
      for (var item in items) {
        print('${item.id}\t\t${item.name}\t\t${item.price}');
      }
      print('---------------------------------------------------');
    }
  }

  void addSampleItems() {
    items.add(Item(1, 'Apple', 1.99));
    items.add(Item(2, 'Banana', 0.99));
    items.add(Item(3, 'Orange', 1.49));
    items.add(Item(4, 'Mango', 2.99));
  }

  void newCustomer() {
    stdout.write('Welcome! Registering a new Customer!\n\n');
    stdout.write('Assign Customer ID: ');
    int id = int.parse(stdin.readLineSync()!);
    stdout.write('Enter Customer Name: ');
    String name = stdin.readLineSync()!;
    stdout.write('Enter Customer Mobile Number: ');
    String mobileNumber = stdin.readLineSync()!;

    customers.add(Customer(id, name, mobileNumber));
    print('\nNew Customer added successfully!');
  }

  void addItemToCart(Customer customer) {
    displayItems();

    stdout.write('Add an Item by ID: ');
    int itemId = int.parse(stdin.readLineSync()!);
    Item? selectedItem = items.firstWhere((item) => item.id == itemId);

    stdout.write('How many/much? Enter Quantity: ');
    int quantity = int.parse(stdin.readLineSync()!);

    Item newItem =
        Item(selectedItem.id, selectedItem.name, selectedItem.price * quantity);
    customer.cart.add(newItem);

    print('Item added to cart successfully.');
  }

  void applyDiscount(double totalAmount) {
    double discountPercentage = 0.0;

    if (totalAmount >= 500 && totalAmount < 1500) {
      discountPercentage = 0.1;
    } else if (totalAmount >= 1500 && totalAmount < 3500) {
      discountPercentage = 0.2;
    } else if (totalAmount >= 3500 && totalAmount < 6500) {
      discountPercentage = 0.25;
    } else if (totalAmount >= 6500) {
      discountPercentage = 0.3;
    }

    double discountAmount = totalAmount * discountPercentage;
    double discountedAmount = totalAmount - discountAmount;
    print('${discountPercentage * 100} % Discount Applied!');
    print('Discounted Amount: -$discountAmount');
    print("--------------------------------------------");
    print('Final Amount: $discountedAmount');
    print("--------------------------------------------");
  }

  void generateBill(Customer customer) {
    if (customer.cart.isEmpty) {
      print('Customer cart is empty.');
    } else {
      double totalAmount = 0;
      print("--------------------------------------------");
      print('Customer ID: ${customer.id}');
      print('Name: ${customer.name}');
      print('Mobile Number: ${customer.mobileNumber}');
      print("--------------------------------------------");
      print('Items Purchased:');
      print('Item ID:\tName:\t\tPrice:');
      for (var item in customer.cart) {
        print('${item.id}\t\t${item.name}\t\t${item.price}');
        totalAmount += item.price;
      }
      print("--------------------------------------------");
      print('Total Amount: $totalAmount');
      print("--------------------------------------------");
      applyDiscount(totalAmount);
    }
  }

  void searchCustomerById() {
    stdout.write('Enter Customer ID to see all details : ');
    int customerId = int.parse(stdin.readLineSync()!);

    Customer? customer =
        customers.firstWhere((customer) => customer.id == customerId);
    if (customer != null) {
      generateBill(customer);
    } else {
      print('Customer not found.');
    }
  }

  void startBillingSystem() {
    while (true) {
      print(
          '\n\t\t\t\t\t\t==============================================================');
      print(
          '\t\t\t\t\t\t----------------- Supermarket Billing System -----------------');
      print(
          '\t\t\t\t\t\t==============================================================');
      print('\t\t\t\t\t\t1. New Customer');
      print('\t\t\t\t\t\t2. Display Available Items');
      print('\t\t\t\t\t\t3. Add Item to Cart');
      print('\t\t\t\t\t\t4. Display Customer Cart');
      print('\t\t\t\t\t\t5. Generate Bill for Current Customer');
      print('\t\t\t\t\t\t6. Search Customer by ID');
      print('\t\t\t\t\t\t7. Exit');
      print(
          '\t\t\t\t\t\t==============================================================');
      stdout.write('\t\t\t\t\t\tEnter your choice: ');
      int choice = int.parse(stdin.readLineSync()!);
      print(
          '\t\t\t\t\t\t==============================================================\n');

      switch (choice) {
        case 1:
          newCustomer();
          break;
        case 2:
          displayItems();
          break;
        case 3:
          if (customers.isNotEmpty) {
            stdout.write('Enter your Customer ID first! : ');
            int customerId = int.parse(stdin.readLineSync()!);
            Customer? customer =
                customers.firstWhere((customer) => customer.id == customerId);
            if (customer != null) {
              addItemToCart(customer);
            } else {
              print('Customer not found.');
            }
          } else {
            print('No customers available.');
          }
          break;
        case 4:
          if (customers.isNotEmpty) {
            stdout.write('To see your Cart first enter your Customer ID: ');
            int customerId = int.parse(stdin.readLineSync()!);
            Customer? customer =
                customers.firstWhere((customer) => customer.id == customerId);
            if (customer != null) {
              customer.displayCart();
            } else {
              print('Customer not found.');
            }
          } else {
            print('No customers available.');
          }
          break;
        case 5:
          if (customers.isNotEmpty) {
            stdout.write('To get the receipt first enter your Customer ID: ');
            int customerId = int.parse(stdin.readLineSync()!);
            Customer? customer =
                customers.firstWhere((customer) => customer.id == customerId);
            if (customer != null) {
              generateBill(customer);
            } else {
              print('Customer not found.');
            }
          } else {
            print('No customers available.');
          }
          break;
        case 6:
          if (customers.isNotEmpty) {
            searchCustomerById();
          } else {
            print('No customers available.');
          }
          break;
        case 7:
          print('Exiting...');
          return;
        default:
          print('Invalid choice.');
      }

      print('');
    }
  }
}

void main() {
  Supermarket supermarket = Supermarket();
  supermarket.addSampleItems();
  supermarket.startBillingSystem();
}
