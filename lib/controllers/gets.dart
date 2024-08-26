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

  static Future<void> getLastOrders() async {
    try {
      final prefes = await SharedPreferences.getInstance();
      String userId = prefes.getString('userId') ?? '';
      List orders = prefes.getStringList('orders') ?? [];

      // Await the Firestore query to get the collection snapshot
      final lastOrdersCollection =
          FirebaseFirestore.instance.collection('kitchens');
      orders.map((_) {
        final data = lastOrdersCollection.doc(_.toString()).get();

        print('data: $data');
      });
      // print(orders);

      // print(lastOrdersCollection.data());
    } catch (e) {
      print("Error fetching orders: $e");
    }
  }
}
