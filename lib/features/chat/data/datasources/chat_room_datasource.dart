import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/firebase_exception_mapper.dart';
import '../../../auth/data/models/user_model.dart';
import '../models/chat_room_model.dart';
import '../models/message_model.dart';

abstract class ChatRoomDatasource {
  Future<List<ChatRoomModel>> getChatRooms();
  Future<ChatRoomModel> createChatRoom({
    required UserModel currentUser,
    required UserModel targetUser,
  });

  Future<List<MessageModel>> getMessages(String roomId);

  Future<MessageModel> sendMessage({
    required String roomId,
    required String text,
  });
}

@LazySingleton(as: ChatRoomDatasource)
class ChatRoomDataSourceImpl implements ChatRoomDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ChatRoomDataSourceImpl(this._firestore, this._auth);

  @override
  Future<List<ChatRoomModel>> getChatRooms() async {
    try {
      final currentUid = _auth.currentUser!.uid;
      final data = await _firestore
          .collection('chat_rooms')
          .where('participant_ids', arrayContains: currentUid)
          .get();

      return data.docs
          .map(
            (room) => ChatRoomModel.fromJsonId(id: room.id, json: room.data()),
          )
          .toList();
    } on FirebaseException catch (e) {
      e.toAppException();
    } catch (e) {
      throw FirebaseFirestoreException(message: 'Unknown Error');
    }
  }

  String _getChatRoomId(String uid1, String uid2) {
    final sorted = [uid1, uid2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }

  @override
  Future<ChatRoomModel> createChatRoom({
    required UserModel currentUser,
    required UserModel targetUser,
  }) async {
    try {
      final roomId = _getChatRoomId(currentUser.uid, targetUser.uid);
      final roomRef = _firestore.collection('chat_rooms').doc(roomId);
      final roomSnap = await roomRef.get();

      if (!roomSnap.exists) {
        final chatRoom = ChatRoomModel(
          id: roomId,
          participantIds: [currentUser.uid, targetUser.uid],
          participants: [currentUser, targetUser],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await roomRef.set(chatRoom.toJson());
        return chatRoom;
      }
      return ChatRoomModel.fromJsonId(id: roomSnap.id, json: roomSnap.data()!);
    } on FirebaseException catch (e) {
      e.toAppException();
    } catch (e) {
      throw FirebaseFirestoreException(message: 'Unknown Error');
    }
  }

  @override
  Future<List<MessageModel>> getMessages(String roomId) async {
    try {
      final currentUid = _auth.currentUser!.uid;

      final data = await _firestore
          .collection('chat_rooms')
          .doc(roomId)
          .collection('messages')
          .get();
      return data.docs
          .map(
            (message) => MessageModel.fromJson(
              json: message.data(),
              isMe: message.data()['sender_id'] == currentUid,
            ),
          )
          .toList();
    } on FirebaseException catch (e) {
      e.toAppException();
    } catch (e) {
      throw FirebaseFirestoreException(message: 'Unknown Error');
    }
  }

  @override
  Future<MessageModel> sendMessage({
    required String roomId,
    required String text,
  }) async {
    try {
      final currentUid = _auth.currentUser!.uid;
      final roomRef = _firestore.collection("chat_rooms").doc(roomId);
      final batch = _firestore.batch();

      final MessageModel messageModel = MessageModel(
        text: text,
        senderId: currentUid,
        sentAt: DateTime.now(),
        isMe: true,
      );

      final msgRef = roomRef.collection('messages').doc();
      batch.set(msgRef, messageModel.toJson());

      batch.update(roomRef, {
        'last_message': messageModel.toJson(),
        'updated_at': FieldValue.serverTimestamp(),
      });

      await batch.commit();

      return messageModel;
    } on FirebaseException catch (e) {
      e.toAppException();
    } catch (e) {
      throw FirebaseFirestoreException(message: 'Unknown Error');
    }
  }
}
