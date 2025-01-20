import 'package:flutter/material.dart';
import 'package:zego_callkit/zego_callkit.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';



class CallInvitationPage extends StatelessWidget {
  const CallInvitationPage({super.key,required this.username,required this.callid,required this.userid});
final String username ;
final String callid;
final String userid;

  @override
  Widget build(BuildContext context) {
    String nameforcall = username;
    return  ZegoUIKitPrebuiltCall(appID: 1309014945, appSign: '5233d0986b2dbe560ea606d00403318b581a96c99ed35cf396ded9b9037ad38e', callID: callid, userID:userid, userName: username, config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
    );
  }
}