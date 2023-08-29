import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as uploadImage;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/image_model.dart';

class ItemOnFirestore extends StatefulWidget {
  const ItemOnFirestore(
    BuildContext context, {
    super.key,
    required this.items,
  });

  final CollectionReference<Object?> items;

  @override
  State<ItemOnFirestore> createState() => ItemOnFirestoreState();
}

class ItemOnFirestoreState extends State<ItemOnFirestore> {
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'ko_KR', name: '', decimalDigits: 0);

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descpController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  Future<void> update(DocumentSnapshot docSnapshot) async {
    amountController.text = docSnapshot['amount'];
    descpController.text = docSnapshot['descp'];

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '금액',
                  ),
                ),
                TextField(
                  controller: descpController,
                  decoration: const InputDecoration(
                    labelText: '내용',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String amount = amountController.text;
                      final String descp = descpController.text;
                      widget.items.doc(docSnapshot.id).update({
                        'amount': amount,
                        'descp': descp,
                      });
                      amountController.clear();
                      descpController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('update'))
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> create() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '금액',
                  ),
                ),
                TextField(
                  controller: descpController,
                  decoration: const InputDecoration(
                    labelText: '내용',
                  ),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                    labelText: '카테고리',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String amount = amountController.text;
                      final String descp = descpController.text;
                      final String category = categoryController.text;
                      await widget.items.add({
                        'amount': amount,
                        'descp': descp,
                        'category': category,
                      });
                      amountController.clear();
                      descpController.clear();
                      categoryController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('create'))
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> delete(String productId) async {
    await widget.items.doc(productId).delete();
  }

  final ImagePicker picker = ImagePicker();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  bool isLoading = false;
  Future getFromImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    final File imagefile = File(pickedFile!.path);
    String postId = const Uuid().v4();
    Reference storageReference =
        _firebaseStorage.ref().child('account_image/$postId');

    UploadTask storageUploadTask = storageReference.putFile(imagefile); //파일 업로드
    await storageUploadTask;

    String downloadURL = await storageReference.getDownloadURL();
    postId = const Uuid().v4();

    await getRecognizedText(pickedFile, downloadURL);
  }

  Future getRecognizedText(XFile image, String downloadURL) async {
    const String apiUrl =
        'https://c5ow50d89i.apigw.ntruss.com/custom/v1/21848/74ec55cb84097108fb278ca259460e9cfcde072e550ba9a68e3e5dca84f7b0fc/infer';
    const String secretKey = 'cVhCeGNBVmh6RmxnWVlOTm5Kc2pYU3NrWmpkd3d2ZUk=';

    var requestJson = {
      'version': 'V1',
      'requestId': 'test',
      'timestamp': 0,
      'images': [
        {'name': 'tmp', 'format': 'jpg', 'url': downloadURL}
      ]
    };
    var headers = {
      'Content-Type': 'application/json',
      'X-OCR-SECRET': secretKey
    };
    var response = await http.post(Uri.parse(apiUrl),
        headers: headers, body: jsonEncode(requestJson));

    final ImageModel imageModel = imageModelFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream: widget.items.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot docSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          extentRatio: 0.7,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                delete(docSnapshot.id);
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              label: '삭제',
                            ),
                          ],
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: uploadImage.Image.asset(
                              'assets/accountimages/${streamSnapshot.data!.docs[index]['category']}.png',
                            ),
                          ),
                          title: Text('${formatCurrency.format(
                            num.parse(
                                streamSnapshot.data!.docs[index]['amount']),
                          )}원'),
                          subtitle:
                              Text(streamSnapshot.data!.docs[index]['descp']),
                          trailing: SizedBox(
                            width: 150,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      update(docSnapshot);
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      create();
                                    },
                                    icon: const Icon(Icons.edit)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
    );
  }
}
