import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:social_app/shared/componts.dart/constants.dart';
import 'package:social_app/shared/style/colors.dart';
import 'package:social_app/shared/style/icon_broken.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class HomeCall extends StatelessWidget {
  HomeCall({required this.userName, required this.imageUrl});
  final String userName;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    var idCallController = TextEditingController(text: "call Id");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(alignment: Alignment.bottomRight, children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 59,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      radius: 55,
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.green,
                ),
              ]),
              SizedBox(
                height: 40,
              ),
              Text(
                "Video Call",
                style: TextStyle(fontSize: 35),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: idCallController,
                decoration: const InputDecoration(
                  labelText: "call Id",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                color: defaultColorThem,
                child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CallPage(
                                    callID: idCallController.text,
                                    userName: this.userName,
                                  )));
                    },
                    child: const Text(
                      "join now",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID, required this.userName})
      : super(key: key);
  final String callID;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          1855182155, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          "27d26f9175442b6662b6a601833d820258603622d40b8e72a0ee2899cac0b1cc", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: '$uId',
      userName: userName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
