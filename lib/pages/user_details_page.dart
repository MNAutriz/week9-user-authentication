import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/credential_model.dart';
import '../providers/credential_provider.dart';
import 'login.dart';

// UserDetailsPage widget for displaying user details
class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key});
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot?> credStream = context.watch<CredProvider>().users;
    return StreamBuilder(
      stream: credStream, 
      builder: (context, snapshot) {
        if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const LoginPage();
          } else { 
            String compareID = context.read<CredProvider>().currentID;
            String firstName = "firstName";
            String lastName = "lastName";

            for (int i = 0; i < snapshot.data!.docs.length.round(); i++) {
              Credential cred = Credential.fromJson(
                  snapshot.data?.docs[i].data() as Map<String, dynamic>);
              
              if(cred.userId == compareID) { 
                firstName = cred.firstName;
                lastName = cred.lastName;
                break; 
              }
            }     

            return Scaffold(
              appBar: AppBar(
                title: const Text("Details Page"),
              ),
              body: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height:200,
                      child: Row( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: 
                          [ Center(child: Icon(Icons.person, size: 200, color: Color.fromARGB(255, 51, 48, 48))) ]
                        ),
                    ),
                  ),
                  SizedBox(
                    height:200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("$firstName $lastName", style: const TextStyle(fontSize: 23, color: Colors.black)),
                          ],
                        )
                      ],
                    ),
                  )
                ]
              ),
            );
         }      
      },
    ); 
  }
}
