import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gets {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static Future<List<Map<String, dynamic>>> kitchens() async {
    const defaultImageUrl =
        'default_image_url'; // Move to config or env variable

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
          } catch (e) {
            // Handle specific errors
            data['imageUrl'] = defaultImageUrl; // Optional default image
            print('Error fetching image URL for $imagePath: $e');
          }
        } else {
          data['imageUrl'] = defaultImageUrl; // Optional default image
        }

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

  static Future<List<Map<String, dynamic>>> getLastOrders() async {
    const defaultImageUrl =
        'default_image_url'; // Consider moving to config or environment variables
    try {
      final prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('userId') ?? '';
      List<String> orders = prefs.getStringList('orders') ?? [];
      List<Map<String, dynamic>> lastKitchensData = [];

      final lastOrdersCollection =
          FirebaseFirestore.instance.collection('kitchens');

      // Ensure _firebaseStorage is properly initialized
      // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

      for (String orderId in orders) {
        final docSnapshot = await lastOrdersCollection.doc(orderId).get();
        Map<String, dynamic> data =
            docSnapshot.data() as Map<String, dynamic>? ?? {};

        String? imagePath = data['photo'] as String?;
        if (imagePath != null && imagePath.isNotEmpty) {
          try {
            String imageUrl =
                await _firebaseStorage.ref(imagePath).getDownloadURL();
            data['imageUrl'] = imageUrl;
          } catch (e) {
            // Assign default image URL and log the error
            data['imageUrl'] = defaultImageUrl;
            print('Error fetching image URL for $imagePath: $e');
          }
        }
        lastKitchensData.add(data);
      }
      return lastKitchensData;
    } catch (e) {
      print("Error fetching orders: $e");
      return []; // Return an empty list in case of an error
    }
  }

  static Future<List<Map<String, dynamic>>> getMenu(
      {required String kitchen}) async {
    final menuCollection = FirebaseFirestore.instance
        .collection('kitchens')
        .doc(kitchen)
        .collection('menu');
    List<Map<String, dynamic>> menuData = [];
    try {
      final querySnapshot = await menuCollection.get();
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        String imagePath = data["photo"];
        if (imagePath != null && imagePath.isNotEmpty) {
          String imageURL =
              await _firebaseStorage.ref(imagePath).getDownloadURL();
          data['imageUrl'] = imageURL;
        }
        print(doc.id);
        final ingredients =
            menuCollection.doc(doc.id).collection('ingredients');
        List<Map<String, dynamic>> ingredientsData = [];
        try {
          final ingredientsSnapshot = await ingredients.get();
          data['ingredients'] = (ingredientsSnapshot.docs[0].data());
        } catch (e) {
          print("Error fetching orders: $e");
          return [];
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
}
