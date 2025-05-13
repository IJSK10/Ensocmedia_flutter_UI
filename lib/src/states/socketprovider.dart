import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/src/database/db.dart';
import 'package:project/src/datamodels/receivemessages.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/*final socketProvider = StreamProvider<List<rMessages>>((ref) async* {
  StreamController stream = StreamController();

  SocketService().socket.onerror((err) => print(err));
  SocketService().socket.on('fromServer', (_) => print(_));
  SocketService().socket.disconnect();
  SocketService().socket.on('broadcast', (data) {
    stream.add(data);
    print(data.toString());
  });
  var allmessages = <rMessages>[];
  await for (final message in stream.stream) {
    allmessages = [...allmessages, message];
    yield allmessages;
  }
});*/

/*

final socketProvider = StreamProvider<List<dynamic>>((ref) async* {
  StreamController stream = StreamController();

  SocketService().socket.onerror((err) => print(err));
  SocketService().socket.on('fromServer', (_) => print(_));
  SocketService().socket.disconnect();

  var allmessages = <rMessages>[];

  SocketService().socket.on('messages', (messages) {
    for (var message in messages) {
      print(message);
      allmessages
          .add(rMessages(message['uid'], message['cypher'], message['from']));
    }
  });

  SocketService().socket.on('message', (data) {
    stream.add(data);
    print(data.toString());
  });

  await for (final message in stream.stream) {
    print("message:${message}");
    allmessages
        .add(rMessages(message['uid'], message['cypher'], message['from']));
    yield allmessages;
  }
});
*/
//-----------------WEB PART---------------------------//

class WebWSNotifier extends Notifier<WebSocketChannel> {
  WebSocketChannel _startconnection() {
    WebSocketChannel channel =
        WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));
    return channel;
  }

  @override
  build() {
    WebSocketChannel channel = _startconnection();
    return channel;
  }

  void _handlelostConnection() {
    Future.delayed(const Duration(seconds: 2));
    print("Trying connection to websocket");
    state = _startconnection();
  }
}

final webwsChannelProvider =
    NotifierProvider<WebWSNotifier, WebSocketChannel>(() {
  return WebWSNotifier();
});

final webmessagesProvider = StreamProvider<List<rmessages>>((ref) async* {
  StreamController stream = StreamController();
  var messages = <rmessages>[];
  final channel = ref.watch(webwsChannelProvider);
  channel.stream.listen((message) {
    stream.add(message);
  }, onDone: () {
    ref.watch(webwsChannelProvider.notifier)._handlelostConnection();
  }, onError: (error) {
    print("Error in websocket connection: $error");
    ref.watch(webwsChannelProvider.notifier)._handlelostConnection();
  });

  await for (final message in stream.stream) {
    final newmessage = jsonDecode(message) as Map<String, dynamic>;
    final rmes = rmessages.fromjson(newmessage);
    messages.add(rmes);
    yield messages;
  }
  yield messages;
});

//------------------APP PART --------------------///

class WSNotifier extends Notifier<IOWebSocketChannel> {
  IOWebSocketChannel _startconnection() {
    IOWebSocketChannel channel =
        IOWebSocketChannel.connect(Uri.parse('ws://10.0.2.2:8080'));
    return channel;
  }

  @override
  build() {
    final IOWebSocketChannel channel = _startconnection();
    return channel;
  }

  void _handlelostConnection() {
    Future.delayed(const Duration(seconds: 2));
    state = _startconnection();
  }
}

final wsChannelProvider = NotifierProvider<WSNotifier, IOWebSocketChannel>(() {
  return WSNotifier();
});
/*
final webwsChannelProvider = Provider<WebSocketChannel>((ref) {
  final wsurl = Uri.parse('ws://localhost:8080');
  WebSocketChannel channel = WebSocketChannel.connect(wsurl);
  print("channel connected");

  ref.onDispose(() {
    channel.sink.close();
  });

  void onDone() async {
    await Future.delayed(Duration(seconds: 2));
    channel = WebSocketChannel.connect(wsurl);
  }

  return channel;
});
*/

/*
final wsChannelProvider = Provider<IOWebSocketChannel>((ref) {
  final wsurl = Uri.parse('ws://10.0.2.2:8080');
  final channel = IOWebSocketChannel.connect(wsurl);
  print("channel connected");
  ref.onDispose(() {
    channel.sink.close();
  });
  return channel;
});
*/
final messagesProvider = StreamProvider<List<rmessages>>((ref) async* {
  StreamController stream = StreamController();
  var messages = <rmessages>[];
  final channel = ref.watch(wsChannelProvider);
  channel.stream.listen((message) {
    stream.add(message);
  }, onDone: () {
    ref.watch(wsChannelProvider.notifier)._handlelostConnection();
  }, onError: (error) {
    print("Error in websocket connection: $error");
    ref.watch(wsChannelProvider.notifier)._handlelostConnection();
  });

  await for (final message in stream.stream) {
    final newmessage = jsonDecode(message) as Map<String, dynamic>;
    final rmes = rmessages.fromjson(newmessage);
    messages.add(rmes);
    ChatDatabase.instance.insertrmessage(rmes);
    final count = ChatDatabase.instance.getCount();
    print("count ${count}");
    yield messages;
  }
  yield messages;
});
