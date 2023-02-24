import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:jitsi_meet_wrapper_example/PAGE/add_data/addinfo.dart';

import 'config.dart';

class Meeting extends StatefulWidget {
  const Meeting({Key? key}) : super(key: key);

  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "มามา");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final tokenText = TextEditingController();
  final userDisplayNameText = TextEditingController(text: "Plugin Test User");
  final userEmailText = TextEditingController(text: "fake@email.com");
  final userAvatarUrlText = TextEditingController();
  bool isAudioMuted = true;
  bool isAudioOnly = false;
  bool isVideoMuted = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xFFDC294E),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_hospital_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  textstyle(
                    text: "ฉุกเฉิน",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              )
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Column(
                  children: [
                    SizedBox(
                      height: 290,
                      width: 290,
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 255, 208, 217),
                        radius: 10,
                        child: SizedBox(
                          height: 240,
                          width: 240,
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(249, 120, 146, 1),
                            radius: 10,
                            child: SizedBox(
                              height: 212,
                              width: 212,
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/mhor.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    textstyle(
                      text: "กำลังติดต่อโรงพยาบาล",
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textstyle(
                      text: "กรุรารอสักครู่",
                      fontSize: 20,
                      color: Color(0xFF8A8A8A),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    height: 50,
                    width: 330,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          offset: Offset(0, 3),
                          blurRadius: 7,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFDC294E),
                          Color.fromARGB(255, 213, 13, 53),
                        ],
                      ),
                    ),
                    child: TextButton(
                      onPressed: () => _joinMeeting(),
                      child: textstyle(
                        text: "ติดต่อด่วน",
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value!;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value!;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value!;
    });
  }

  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    Map<FeatureFlag, Object> featureFlags = {};

    // Define meetings options here
    var options = JitsiMeetingOptions(
      roomNameOrUrl: roomText.text,
      serverUrl: serverUrl,
      subject: subjectText.text,
      token: tokenText.text,
      isAudioMuted: isAudioMuted,
      isAudioOnly: isAudioOnly,
      isVideoMuted: isVideoMuted,
      userDisplayName: userDisplayNameText.text,
      userEmail: userEmailText.text,
      featureFlags: featureFlags,
    );

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
            "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: $email, name: $name, role: $role, "
            "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
            "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),
    );
  }
}
