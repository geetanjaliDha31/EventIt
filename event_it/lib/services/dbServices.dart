// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_it/pages/createEvent.dart';

class DatabaseServices {
  final String? uid;
  DatabaseServices({this.uid});

  //reference for our collections
  final CollectionReference userCollections =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference orgCollections =
      FirebaseFirestore.instance.collection("organization");

  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection("events");

  //updating user data
  Future saveUserData(String Name, String email, String dob, String phone,
      String location, String gender) async {
    return await userCollections.doc(uid).set({
      "Name": Name,
      "email": email,
      "DOB": dob,
      "phone": phone,
      "location": location,
      "gender": gender,
      "events": [],
      "saveEvents": [],
      "interests": [],
      "profilePic": "",
      "userid": uid,
      "isOrg":"false"
    });
  }

  //updating user data
  Future saveOrgData(
      String Name, String email, String phone, String location) async {
    return await orgCollections.doc(uid).set({
      "Name": Name,
      "email": email,
      "phone": phone,
      "location": location,
      "events": [],
      "saveEvents": [],
      "interests": [],
      "profilePic": "",
      "orgid": uid,
      "isOrg": "true"
    });
  }

  Future createEvent(
      String? ename,
      String? edesc,
      bool paid,
      String? efee,
      String? edate,
      String? etime,
      String? eloc,
      String? eaddress,
      String? ebanner,
      ) async {
    // String oname = "";
    // Future getOrgName()async{
    //   DocumentReference documentReference = eventCollection.doc(id);
    //   DocumentSnapshot documentSnapshot = await documentReference.get();
    //   oname = documentSnapshot[
    //     "admin"];
    // return oname;
    // }
    // String oname1 = oname;

    DocumentReference eventDocumentReference = await eventCollection.add({
      //document reference is an object to store document
      "EventName": ename,
      "EventDesc": edesc,
      "orgId": uid,
      "participants": [],
      "eventId": "",
      "EventFee": efee,
      "isEventPaid": paid,
      "EventDate": edate,
      "EventTime": etime,
      "EventBanner": ebanner,
      "EventLocation": eloc,
      "EventAddress": eaddress,
      "recentMessage": "",
      "recentMessageSender": "",
    });

    //update the members
    await eventDocumentReference.update({
      "members": FieldValue.arrayUnion([uid]),
      "eventId": eventDocumentReference.id
    });

    //adding group in admin document
    DocumentReference orgDocumentReference = userCollections.doc(uid);
    return await orgDocumentReference.update({
      "events": FieldValue.arrayUnion(["${eventDocumentReference.id}_$ename"])
    });
    return true;
  }

  //save interests
  Future setUserInterests(List<String> selectedInterests) async {
    try {
      // Reference to the user document in Firestore
      final userDocumentRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Update the 'interests' field with the selected interests
      await userDocumentRef.update({
        'interests': selectedInterests,
      });

      print('User interests updated successfully.');
    } catch (e) {
      print('Error updating user interests: $e');
    }
  }

  Future setOrgInterests(List<String> selectedInterests) async {
    try {
      // Reference to the user document in Firestore
      final orgDocumentRef =
          FirebaseFirestore.instance.collection('organization').doc(uid);

      // Update the 'interests' field with the selected interests
      await orgDocumentRef.update({
        'interests': selectedInterests,
      });

      print('User interests updated successfully.');
    } catch (e) {
      print('Error updating user interests: $e');
    }
  }

  //getting homecards
  Stream<QuerySnapshot> getHomeCards() {
    return eventCollection.snapshots();
  }

  //getting user data
  Future getOrgName(String id) async {
    QuerySnapshot snapshot =
        await orgCollections.where("orgid", isEqualTo: id).get();
    return snapshot;
  }
  //getting user data
  Future getUserName() async {
    QuerySnapshot snapshot =
        await orgCollections.where("userid", isEqualTo: uid).get();
    return snapshot;
  }
  //getting user data
  Future getMemberUsersName(String id) async {
    QuerySnapshot snapshot =
        await userCollections.where("userid", isEqualTo: id).get();
    return snapshot;
  }

  // Future getOrg(String orgid) async {
  //   DocumentReference documentReference = orgCollections.doc(orgid);
  //   DocumentSnapshot documentSnapshot = await documentReference.get();
  //   return documentSnapshot["Name"]; //A DocumentSnapshot contains data from a document.The data can be extracted with data() or get(<field>) to get a specific field.
  // }
  Future<String> getOrg(String orgid) async {
    try {
      DocumentReference documentReference = orgCollections.doc(orgid);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Check if the "Name" field exists
        dynamic nameField = documentSnapshot["Name"];
        if (nameField != null) {
          print("yes");
          // return nameField.toString();
          return documentSnapshot["Name"];
        }
      }

      // Return null if the document or field doesn't exist
      return documentSnapshot["Name"];
    } catch (e) {
      print("Error fetching org name: $e");
      return "null";
    }
  }
  Future<String> getUser(String id) async {
    try {
      DocumentReference documentReference = userCollections.doc(id);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Check if the "Name" field exists
        dynamic nameField = documentSnapshot["Name"];
        if (nameField != null) {
          print("yes");
          // return nameField.toString();
          return documentSnapshot["Name"];
        }
      }

      // Return null if the document or field doesn't exist
      return documentSnapshot["Name"];
    } catch (e) {
      print("Error fetching org name: $e");
      return "null";
    }
  }
  Future<String> getGender(String id) async {
    try {
      DocumentReference documentReference = userCollections.doc(id);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Check if the "Name" field exists
        dynamic nameField = documentSnapshot["gender"];
        if (nameField != null) {
          print("yes");
          // return nameField.toString();
          return documentSnapshot["gender"];
        }
      }

      // Return null if the document or field doesn't exist
      return documentSnapshot["gender"];
    } catch (e) {
      print("Error fetching org name: $e");
      return "null";
    }
  }
  Future<String> getLoc(String id) async {
    try {
      DocumentReference documentReference = userCollections.doc(id);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Check if the "Name" field exists
        dynamic nameField = documentSnapshot["location"];
        if (nameField != null) {
          print("yes");
          // return nameField.toString();
          return documentSnapshot["location"];
        }
      }

      // Return null if the document or field doesn't exist
      return documentSnapshot["location"];
    } catch (e) {
      print("Error fetching org name: $e");
      return "null";
    }
  }
  Future<String> getEmail(String id) async {
    try {
      DocumentReference documentReference = userCollections.doc(id);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Check if the "Name" field exists
        dynamic nameField = documentSnapshot["email"];
        if (nameField != null) {
          print("yes");
          // return nameField.toString();
          return documentSnapshot["email"];
        }
      }

      // Return null if the document or field doesn't exist
      return documentSnapshot["email"];
    } catch (e) {
      print("Error fetching org name: $e");
      return "null";
    }
  }
  Future<String> getDob(String id) async {
    try {
      DocumentReference documentReference = userCollections.doc(id);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Check if the "Name" field exists
        dynamic nameField = documentSnapshot["DOB"];
        if (nameField != null) {
          print("yes");
          // return nameField.toString();
          return documentSnapshot["DOB"];
        }
      }

      // Return null if the document or field doesn't exist
      return documentSnapshot["DOB"];
    } catch (e) {
      print("Error fetching org name: $e");
      return "null";
    }
  }

  

  Future<String> isOrg(String orgid) async {
    try {
      DocumentReference documentReference = orgCollections.doc(orgid);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Check if the "Name" field exists
        dynamic nameField = documentSnapshot["isOrg"];
        if (nameField != null) {
          print("yes");
          // return nameField.toString();
          return documentSnapshot["isOrg"];
        }
      }

      // Return null if the document or field doesn't exist
      return documentSnapshot["isOrg"];
    } catch (e) {
      print("Error fetching org name: $e");
      return "null";
    }
  }

  Future<void> saveEventToUser(String eventCardId) async {
    try {
      print(eventCardId);
      // Get reference to the user document
      DocumentReference userRef = userCollections.doc(uid);

      // Fetch the current user document
      DocumentSnapshot userSnapshot = await userRef.get();

      // Check if the user document exists
      if (userSnapshot.exists) {
        // Get the current saved events array or initialize an empty array
        List<dynamic> saveEvents = userSnapshot['saveEvents'] ?? [];

        // Check if the event card ID is not already in the saved events array
        if (!saveEvents.contains(eventCardId)) {
          // Append the event card ID to the saved events array
          saveEvents.add(eventCardId);

          // Update the user document with the new saved events array
          await userRef.update({'saveEvents': saveEvents});

          print('Event saved successfully!');
        } else {
          print('Event is already saved.');
          saveEvents.remove(eventCardId);
          await userRef.update({'saveEvents': saveEvents});
          print('Event removed successfully!');
        }
      } else {
        print('User not found.');
      }
    } catch (e) {
      print('Error saving event to user: $e');
    }
  }

  Future<void> removeEventFromUser(String eventCardId) async {
    try {
      // Get reference to the user document
      DocumentReference userRef = userCollections.doc(uid);

      // Fetch the current user document
      DocumentSnapshot userSnapshot = await userRef.get();

      // Check if the user document exists
      if (userSnapshot.exists) {
        // Get the current saved events array or initialize an empty array
        List<dynamic> saveEvents = userSnapshot['saveEvents'] ?? [];

        // Check if the event card ID is in the saved events array
        if (saveEvents.contains(eventCardId)) {
          // Remove the event card ID from the saved events array
          saveEvents.remove(eventCardId);

          // Update the user document with the updated saved events array
          await userRef.update({'saveEvents': saveEvents});

          print('Event removed successfully!');
        } else {
          print('Event is not in the saved list.');
        }
      } else {
        print('User not found.');
      }
    } catch (e) {
      print('Error removing event from user: $e');
    }
  }

  Future<List<dynamic>> fetchArrayField() async {
  try {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      List<dynamic> yourArray = data['savedEvents'] ?? []; // Extracting the array field or defaulting to an empty array if it doesn't exist
      print(yourArray);
      return yourArray;
    } else {
      print("Document does not exist");
      return [];
    }
  } catch (error) {
    print("Error fetching array field: $error");
    return [];
  }
}

  //searching events
  searchByName(String eventName) async {
    return eventCollection.where("EventName", isEqualTo: eventName).get();
  }
  getGroupMembers(String groupId) async {
    return eventCollection.doc(groupId).snapshots();
  }

//USED FUNCTIONS

  //getting user data
  Future getUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollections.where("email", isEqualTo: email).get();
    return snapshot;
  }

  //getting user groups
  getUserGroups() async {
    return userCollections.doc(uid).snapshots(); // snapshot: list of document
  }
  getUserGroups2() async {
    DocumentSnapshot documentSnapshot = await userCollections // Replace 'your_collection' with your collection name
        .doc(uid) // Provide the document ID here
        .get(); // snapshot: list of document
        return documentSnapshot;
  }

  

  //creating a group
  Future createGroup(String userName, String id, String groupName1) async {
    DocumentReference groupDocumentReference = await eventCollection.add({
      //document reference is an object to store document
      "groupName": groupName1,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });

    //update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${id}_$userName"]),
      "groupId": groupDocumentReference.id
    });

    //adding group in admin document
    DocumentReference userDocumentReference = userCollections.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName1"])
    });

    return true;
  }

  //getting chats
  getChat(String groupId) async {
    return eventCollection
        .doc(groupId)
        .collection("message")
        .orderBy("time")
        .snapshots();
  }

  //getting admin
  Future getAdmin(String groupId) async {
    DocumentReference documentReference = eventCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    return documentSnapshot[
        "admin"]; //A DocumentSnapshot contains data from a document.The data can be extracted with data() or get(<field>) to get a specific field.
  }

  //getting group members


  //function to check if user joined a group
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollections.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> events = documentSnapshot["events"];
    if (events.contains("${groupId}")) {
      return true;
    } else {
      return false;
    }
  }

  Future toggleGroupJoin(
      String eventId, String eventName, String userName) async {
    DocumentReference userdocumentReference = userCollections.doc(uid);
    DocumentReference groupdocumentReference = eventCollection.doc(eventId);

    DocumentSnapshot userSnapshot = await userdocumentReference.get();
    List<dynamic> event = userSnapshot["events"];
    if (event.contains("${eventId}_$eventName")) {
      await userdocumentReference.update({
        "events": FieldValue.arrayRemove(["${eventId}_$eventName"])
      });
      await groupdocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userdocumentReference.update({
        "events": FieldValue.arrayUnion(["${eventId}_$eventName"])
      });
      await groupdocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  sendMessage2(String eventId, Map<String, dynamic> chatMap) {

    eventCollection.doc(eventId).collection("message").add(chatMap);
    eventCollection.doc(eventId).update({
      "recentMessage": chatMap["message"],
      "recentMessageSender": chatMap["senderId"],
      "recentMessageTime": chatMap["time"].toString(),
    });
  }
  addSaveEvent(String eventId, Map<String, dynamic> chatMap) {
    print("hello");print(uid);
    eventCollection.doc(uid).collection("savedEvents").add(chatMap);
    eventCollection.doc(uid).update({
      "eventId": chatMap["eventId"],
      "EventAddress": chatMap["EventAddress"],
      "EventName": chatMap["EventName"],
      "EventDate": chatMap["EventDate"],
      "EventTime": chatMap["EventTime"],
      "EventDesc": chatMap["EventDesc"],
      "EventFee": chatMap["EventFee"],
      "isEventPaid": chatMap["isEventPaid"],
      "orgId": chatMap["orgId"],
      "EventBanner": chatMap["EventBanner"],
      
    });
  }

   Future<String> getEventName(String id) async {
    try {
      DocumentReference documentReference = orgCollections.doc(id);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Check if the "Name" field exists
        dynamic nameField = documentSnapshot["EventName"];
        if (nameField != null) {
          // return nameField.toString();
          return documentSnapshot["EventName"];
        }
      }

      // Return null if the document or field doesn't exist
      return documentSnapshot["EventName"];
    } catch (e) {
      print("Error fetching event name: $e");
      return "null";
    }
  }
   Future<String> getEventBanner(String id) async {
    try {
      DocumentReference documentReference = orgCollections.doc(id);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Check if the "Name" field exists
        dynamic nameField = documentSnapshot["EventBanner"];
        if (nameField != null) {
          // return nameField.toString();
          return documentSnapshot["EventBanner"];
        }
      }

      // Return null if the document or field doesn't exist
      return documentSnapshot["EventBanner"];
    } catch (e) {
      print("Error fetching event name: $e");
      return "null";
    }
  }
   Future<String> getEventOrgId(String id) async {
    try {
      DocumentReference documentReference = orgCollections.doc(id);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Check if the "Name" field exists
        dynamic nameField = documentSnapshot["orgId"];
        if (nameField != null) {
          // return nameField.toString();
          return documentSnapshot["orgId"];
        }
      }

      // Return null if the document or field doesn't exist
      return documentSnapshot["orgId"];
    } catch (e) {
      print("Error fetching event name: $e");
      return "null";
    }
  }
   Future<String> getSavedEvents() async {
    try {
      DocumentReference documentReference = userCollections.doc(uid);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Check if the "Name" field exists
        dynamic nameField = documentSnapshot["saveEvents"];
        if (nameField != null) {
          // return nameField.toString();
          // return documentSnapshot["saveEvents"];
          return nameField;
        }
      }

      // Return null if the document or field doesn't exist
      // return documentSnapshot["saveEvents"];
                return documentSnapshot["saveEvents"];

    } catch (e) {
      print("Error fetching event name: $e");
      return "null";
    }
  }
}
