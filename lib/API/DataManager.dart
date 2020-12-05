import 'package:cloud_firestore/cloud_firestore.dart';

class DataManager {
  final CollectionReference placesList =
      FirebaseFirestore.instance.collection("places");

  Future getPlacesList() async {
    List itemsList = [];

    try {
      await placesList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
          print("Hey there");
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
      await placesList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
          print("Hey there");
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
      await placesList.where("show_Trending", isEqualTo : true).get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
          print("Hey there Trending");
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
