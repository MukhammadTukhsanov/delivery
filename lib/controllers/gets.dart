import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

      print("kitchensData: $kitchensData");
      return kitchensData;
    } catch (e) {
      print('Error fetching kitchens: $e');
      return [];
    }
  }
}
