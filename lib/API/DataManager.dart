import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataManager {
  final CollectionReference placesList =
      FirebaseFirestore.instance.collection("places");
  final CollectionReference CollectionPlacesList =
      FirebaseFirestore.instance.collection("collection");
  final CollectionReference CategoryPlacesList =
      FirebaseFirestore.instance.collection("Category");
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection("users");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future getPlacesList() async {
    List itemsList = [];

    try {
      await placesList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getTrendingPlacesList() async {
    List itemsList = [];

    try {
      await placesList
          .where("show_Trending", isEqualTo: true)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getCollectionList() async {
    List itemsList = [];
    try {
      await CollectionPlacesList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getCategoryList() async {
    List itemsList = [];
    try {
      await CategoryPlacesList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final User user = await _auth.currentUser;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> addPlaceToFavorite(String place_ID, String uid) async {
    try {
      return await profileList.doc(uid).collection("Favorite").doc().set({
        'place_ID': place_ID,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future getFavoritePlacesList() async {
    List itemsList = [];
    final User user = await _auth.currentUser;
    try {
      await profileList
          .doc(user.uid)
          .collection("Favorite")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> deletePlaceFromFavorite(String place_ID) async {
    final User user = await _auth.currentUser;
    try {
     
      return await profileList
          .doc(user.uid)
          .collection("Favorite")
          .where("place_ID", isEqualTo: place_ID)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference
              .delete()
              .then((value) => print("Document successfully deleted!"));
          // print("Document successfully deleted!");
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future getFavoriteScreenPlacesList() async {
    List itemsLovedList = [];
    List itemsLovedDataList = [];
    List itemsX = [];
    final User user = await _auth.currentUser;
    try {
      await profileList
          .doc(user.uid)
          .collection("Favorite")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          itemsLovedList.add(element.data());
        });
      });

      await placesList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsLovedDataList.add(element.data());
        });
      });
      for (int x = 0; x < itemsLovedList.length; x++) {
        for (int i = 0; i < itemsLovedDataList.length; i++) {
          if (itemsLovedList[x]["place_ID"] ==
              itemsLovedDataList[i]["place_ID"]) {
          
            itemsX.add(itemsLovedDataList[i]);
          }
        }
      }
      return itemsX;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getDetailImagesList(String placeID) async {
    List itemsList = [];
    List itemsImagesList = [];
    try {
      await placesList
          .where("place_ID", isEqualTo: placeID)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs
          ..forEach((element) {
            itemsList.add(element.data());
                  print("sba7 khir * 0");
      print("The place ID List we get is : ${itemsList}");

          });
      });

   
        for (int x = 1; x < itemsList[0]["no_of_images"] + 1; x++) {
          itemsImagesList.add(itemsList[0]["place_image_${x}"]);
        }
      
      print("sba7 khir");
      print("hey : ${itemsImagesList}");
      return itemsImagesList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
