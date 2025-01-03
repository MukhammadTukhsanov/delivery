import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gets {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static Future<List<Map<String, dynamic>>> getLastOrders() async {
    const defaultImageUrl =
        'https://firebasestorage.googleapis.com/v0/b/yo-lda-a732c.appspot.com/o/qassob.png?alt=media&token=1a123d6f-0af6-476b-8ab2-eac16c5f77ad'; // Consider moving to config or environment variables
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> orders = prefs.getStringList('orders') ?? [];
      List<Map<String, dynamic>> lastKitchensData = [];
      print("orders: ${orders}");

      final lastOrdersCollection =
          FirebaseFirestore.instance.collection('kitchens');

      // Ensure _firebaseStorage is properly initialized
      // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

      // print("storage: $_firebaseStorage");

      for (String orderId in orders) {
        final docSnapshot = await lastOrdersCollection.doc(orderId).get();
        Map<String, dynamic> data = docSnapshot.data() ?? {};

        String? imagePath = data['photo'] as String?;
        if (imagePath != null && imagePath.isNotEmpty) {
          try {
            String imageUrl =
                await _firebaseStorage.ref(imagePath).getDownloadURL();
            data['imageUrl'] = imageUrl;
            data['filter'] = 'kitchens';
          } catch (e) {
            // Assign default image URL and log the error
            data['imageUrl'] = defaultImageUrl;
            print('Error fetching image URL for $imagePath: $e');
          }
        }
        data['kitchenName'] = docSnapshot.id;
        lastKitchensData.add(data);
      }
      return lastKitchensData;
    } catch (e) {
      print("Error fetching orders: $e");
      return []; // Return an empty list in case of an error
    }
  }

  static Future<List<Map<String, dynamic>>> kitchens() async {
    const defaultImageUrl =
        'https://firebasestorage.googleapis.com/v0/b/yo-lda-a732c.appspot.com/o/qassob.png?alt=media&token=1a123d6f-0af6-476b-8ab2-eac16c5f77ad'; // Move to config or env variable

    try {
      QuerySnapshot querySnapshot =
          await _firebaseFirestore.collection('kitchens').get();
      List<Map<String, dynamic>> kitchensData = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String? imagePath = data['photo'] as String?;

        if (imagePath != null && imagePath.isNotEmpty) {
          try {
            String imageUrl =
                await _firebaseStorage.ref(imagePath).getDownloadURL();
            data['imageUrl'] = imageUrl;
            data['kitchenName'] = doc.id;
            data['filter'] = 'kitchens';
          } catch (e) {
            // Handle specific errors
            data['imageUrl'] = defaultImageUrl; // Optional default image
            print('Error fetching image URL for $imagePath: $e');
          }
        } else {
          data['imageUrl'] = defaultImageUrl; // Optional default image
        }
        // data['kitchenName'] = querySnapshot.id;
        kitchensData.add(data);
      }
      return kitchensData;
    } catch (e) {
      print('Error fetching kitchens: $e');
      return [];
    }
  }

  static Future<void> getAndStoreOrderData(String userId) async {
    try {
      // Reference to Firestore collection
      final orderCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders');

      // Retrieve the data
      DocumentSnapshot<Map<String, dynamic>> orderSnapshot =
          await orderCollection.doc('orders').get();
      if (orderSnapshot.exists) {
        List<String> ordersData = orderSnapshot.data()!.entries.map((entry) {
          return '${entry.value}';
        }).toList();
        // Store orders in local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId);
        await prefs.setStringList('orders', ordersData);
      } else {}
    } catch (e) {
      print("Error fetching orders: $e");
    }
  }

  static Future<List<Map<String, dynamic>>> getMenu(
      {required String kitchen, required String filter}) async {
    final menuCollection = FirebaseFirestore.instance
        .collection(filter)
        .doc(kitchen)
        .collection('menu');
    List<Map<String, dynamic>> menuData = [];
    try {
      final querySnapshot = await menuCollection.get();
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        print("menu: ${data}");
        String imagePath = data["photo"];
        if (imagePath.isNotEmpty) {
          String imageURL =
              await _firebaseStorage.ref(imagePath).getDownloadURL();
          data['photo'] = imageURL;
        }
        final ingredients =
            menuCollection.doc(doc.id).collection('ingredients');
        if (filter != 'markets') {
          try {
            final ingredientsSnapshot = await ingredients.get();
            data['ingredients'] = (ingredientsSnapshot.docs[0].data());
          } catch (e) {
            print("Error fetching orders: $e");
            return [];
          }
        }

        menuData.add(data);
      }
      print(menuData);
      return menuData;
    } catch (e) {
      print("Error fetching orders: $e");
      return []; // Return an empty list in case of an error
    }
  }

  static Future<List<Map<String, dynamic>>> getMarkets() async {
    const defaultImageUrl =
        'https://firebasestorage.googleapis.com/v0/b/yo-lda-a732c.appspot.com/o/qassob.png?alt=media&token=1a123d6f-0af6-476b-8ab2-eac16c5f77ad'; // Move to config or env variable

    try {
      QuerySnapshot querySnapshot =
          await _firebaseFirestore.collection('markets').get();
      List<Map<String, dynamic>> marketsData = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String? imagePath = data['photo'] as String?;

        if (imagePath != null && imagePath.isNotEmpty) {
          try {
            String imageUrl =
                await _firebaseStorage.ref(imagePath).getDownloadURL();
            data['imageUrl'] = imageUrl;
            data['kitchenName'] = doc.id;
            data['filter'] = 'markets';
          } catch (e) {
            // Handle specific errors
            data['imageUrl'] = defaultImageUrl; // Optional default image
            print('Error fetching image URL for $imagePath: $e');
          }
        } else {
          data['imageUrl'] = defaultImageUrl; // Optional default image
        }

        marketsData.add(data);
      }
      return marketsData;
    } catch (e) {
      print('Error fetching kitchens: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getMarketProducts(
      {required String market}) async {
    try {
      // Retrieve the document snapshot for the specified market
      QuerySnapshot marketProductsDocument = await _firebaseFirestore
          .collection('markets')
          .doc(market)
          .collection('products')
          .get();

      List<Map<String, dynamic>> productsData = [];
      for (var doc in marketProductsDocument.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        productsData.add(data);
        String imgURL =
            await _firebaseStorage.ref(data['photo']).getDownloadURL();
        data['photo'] = imgURL;
      }
      return productsData;
    } catch (e) {
      print('Error fetching market products: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> mixedAllStores() async {
    Set<Map<String, dynamic>> seen = {};
    List<Map<String, dynamic>> mixedArray = [];
    var kitchensData = await kitchens();
    var marketsData = await getMarkets();

    int maxLength = kitchensData.length > marketsData.length
        ? kitchensData.length
        : marketsData.length;

    for (int i = 0; i < maxLength; i++) {
      if (i < kitchensData.length && seen.add(kitchensData[i])) {
        mixedArray.add(kitchensData[i]);
      }
      if (i < marketsData.length && seen.add(marketsData[i])) {
        mixedArray.add(marketsData[i]);
      }
    }
    print('mixedArray: $mixedArray');
    return mixedArray;
  }
}
