import 'Customer.dart';
import 'Items.dart';
import 'dart:io';
import 'itemCatalog.dart';

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
      print('Item ID:\tName:\t\t\tPrice:');
      items.forEach((item) {
        print('${item.id}\t\t1x ${item.name}\t\t${item.price}');
      });
      print('---------------------------------------------------');
    }
  }

  void addSampleItems() {
    itemCatalog(items);
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
    Item? selectedItem;
    items.forEach((item) {
      if (item.id == itemId) {
        selectedItem = item;
      }
    });

    if (selectedItem == null) {
      print('Item not found.');
      return;
    }

    stdout.write('How many/much? Enter Quantity: ');
    int quantity = int.parse(stdin.readLineSync()!);

    Item newItem = Item(selectedItem!.id, selectedItem!.name,
        selectedItem!.price * quantity, quantity);
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

  void customerInfo(Customer customer) {
    print("--------------------------------------------");
    print('Customer ID: ${customer.id}');
    print('Name: ${customer.name}');
    print('Mobile Number: ${customer.mobileNumber}');
    print("--------------------------------------------");
  }

  void generateBill(Customer customer) {
    if (customer.cart.isEmpty) {
      customerInfo(customer);
      print('Customer cart is empty.');
    } else {
      double totalAmount = 0;
      print("--------------------------------------------");
      print('Customer ID: ${customer.id}');
      print('Name: ${customer.name}');
      print('Mobile Number: ${customer.mobileNumber}');
      print("--------------------------------------------");
      print('Items Purchased:');
      print('Item ID:\tName:\t\t\tPrice:');
      customer.cart.forEach((item) {
        int quantity = customer.cart.where((i) => i.id == item.id).length;
        print(
            '${item.id}\t\t${item.quantity}x ${item.name}\t\t${item.price * quantity}');
        totalAmount += item.price * quantity;
      });
      print("--------------------------------------------");
      print('Total Amount: $totalAmount');
      print("--------------------------------------------");
      applyDiscount(totalAmount);
    }
  }

  void searchCustomerById() {
    stdout.write('Enter Customer ID to see all details : ');
    int customerId = int.parse(stdin.readLineSync()!);

    Customer? customer;
    customers.forEach((c) {
      if (c.id == customerId) {
        customer = c;
      }
    });

    if (customer != null) {
      generateBill(customer!);
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
      print('\t\t\t\t\t\t7. Display all Customers');
      print('\t\t\t\t\t\t8. Exit');
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
            stdout.write('Enter Customer ID: ');
            int customerId = int.parse(stdin.readLineSync()!);

            Customer? customer;
            customers.forEach((c) {
              if (c.id == customerId) {
                customer = c;
              }
            });

            if (customer != null) {
              addItemToCart(customer!);
            } else {
              print('Customer not found.');
            }
          } else {
            print('No customers available. Please add a new customer first.');
          }
          break;
        case 4:
          if (customers.isNotEmpty) {
            stdout.write('Enter Customer ID: ');
            int customerId = int.parse(stdin.readLineSync()!);

            Customer? customer;
            customers.forEach((c) {
              if (c.id == customerId) {
                customer = c;
              }
            });

            if (customer != null) {
              customer?.displayCart();
            } else {
              print('Customer not found.');
            }
          } else {
            print('No customers available. Please add a new customer first.');
          }
          break;
        case 5:
          if (customers.isNotEmpty) {
            stdout.write('Enter Customer ID: ');
            int customerId = int.parse(stdin.readLineSync()!);

            Customer? customer;
            customers.forEach((c) {
              if (c.id == customerId) {
                customer = c;
              }
            });

            if (customer != null) {
              generateBill(customer!);
            } else {
              print('Customer not found.');
            }
          } else {
            print('No customers available. Please add a new customer first.');
          }
          break;
        case 6:
          if (customers.isNotEmpty) {
            searchCustomerById();
          } else {
            print('No customers available. Please add a new customer first.');
          }
          break;
        case 7:
          if (customers.isNotEmpty) {
            print("--------------------------------------------");
            print('All Customers:');
            print("--------------------------------------------");
            print("Customer ID\tName\t\tMobile Number");
            customers.forEach((customer) {
              print(
                  '${customer.id}\t\t${customer.name}\t\t${customer.mobileNumber}');
            });
            print("--------------------------------------------");
          } else {
            print('No customers available.');
          }
          break;
        case 8:
          print('Thank you for visiting!');
          return;
        default:
          print('Invalid choice. Please try again.');
          break;
      }
    }
  }
}
