# chatagain

Dependencies:

    - cloud_firestore: ^4.5.2
    - image_picker: ^0.8.7+4
    - google_sign_in: ^6.1.0
    - firebase_storage: ^11.1.1
    - firebase_auth: ^4.4.2 - (https://pub.dev/packages/firebase_auth)
    - firebase_core: ^2.10.0

## Farebase notes:

```
void initFireStore() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    firebase.collection('message').doc().set({
      'texto': 'Teremos reunião hoje?',
      'from': 'Roberta',
      'read': false,
    });

    QuerySnapshot snapshot = await firebase.collection('message').get();
    for (var doc in snapshot.docs) {
      log('${doc.id}: ${doc.data().toString()}');
    }

    firebase
        .collection('message')
        .doc('agEpvVmfrF2iNzUH2TBs')
        .snapshots()
        .listen((event) {
      log(event.data().toString());
    });

    DocumentSnapshot docSnapshot =
        await firebase.collection('message').doc('8VuyrSmPRF1RaQKlcVtP').get();
    log(docSnapshot.data().toString());
}
```


Listen for state changes, errors, and completion of the upload.
https://firebase.google.com/docs/storage/flutter/upload-files?authuser=0

```
String imageURL = '';
var snapshot = await task.snapshotEvents.listen(
    (TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
            case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            log("Upload is $progress% complete.");
            break;
            case TaskState.success:
            log('Handle successful uploads on complete');
            imageURL = await task.snapshot.ref.getDownloadURL();
            log('ImageURL: >>>$imageURL<<<');
            break;
            case TaskState.paused:
            log("Upload is paused.");
            break;
            case TaskState.canceled:
            log("Upload was canceled");
            break;
            case TaskState.error:
            log('Handle unsuccessful uploads');
            throw Exception('Handle unsuccessful uploads');
        }
    },
);
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
