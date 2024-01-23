import 'package:chat_app/features/auth/presentation/view/login_view/login_view.dart';
import 'package:chat_app/features/home/presentation/view/chat_view/chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        scrolledUnderElevation: 0.6,
        actions: [
          IconButton(
            onPressed: () {
              _signOut(
                onSucess: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: _buildUsersList(),
    );
  }

  Widget _buildUsersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorWidget();
        }
        if (snapshot.hasData) {
          return _buildUserListView(snapshot.data!);
        }
        return _buildLoadingWidget();
      },
    );
  }

  Widget _buildUserListView(QuerySnapshot<Object?> snapshot) {
    return ListView(
      children: snapshot.docs.map((doc) {
        return UserItemView(document: doc);
      }).toList(),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Text("Oops, There's an Error"),
    );
  }

  Future<void> _signOut({required Function() onSucess}) async {
    try {
      await FirebaseAuth.instance.signOut();
      onSucess();
    } catch (e) {
      debugPrint("Error during sign out: $e");
    }
  }
}

class UserItemView extends StatelessWidget {
  const UserItemView({super.key, required this.document});

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    final data = document.data() as Map<String, dynamic>? ?? {};
    if (_isCurrentUserAccount(data)) {
      return const SizedBox();
    }
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatView(
            receiverEmail: data['email'],
            receiverUid: data['uid'],
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.person)),
            const SizedBox(width: 15),
            _buildUserData(data),
            const Spacer(),
            Text(data['time'] ?? ""),
          ],
        ),
      ),
    );
  }

  bool _isCurrentUserAccount(Map<String, dynamic> data) {
    final String? userId = data['uid'];
    return userId == FirebaseAuth.instance.currentUser?.uid;
  }

  Widget _buildUserData(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data['email'] ?? "",
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          data['last_message'] ?? "",
          style: TextStyle(fontSize: 15, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
