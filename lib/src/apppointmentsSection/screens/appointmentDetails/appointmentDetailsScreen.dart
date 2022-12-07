import 'package:date_time_format/date_time_format.dart';
import 'package:dietationapp/common/helperFunctions/getUserIDhelper.dart';
import 'package:dietationapp/common/helperFunctions/navigatorHelper.dart';
import 'package:dietationapp/common/utils/appcolors.dart';
import 'package:dietationapp/src/apppointmentsSection/models/appointmetntNewModel.dart';
import 'package:dietationapp/src/reviewsSection/screens/givereviewScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../common/utils/firebaseUtils.dart';
import '../../../../common/utils/themes.dart';
import '../../../VideoCallingSection/screens/homesignalling.dart';
import '../../../VideoCallingSection/screens/zego_simple_join_video_call.dart';
import '../../../chatSection/screens/messages.dart';
import '../../../notesSection/soapNotes/screens/add_soap_note.dart';
import '../../../notesSection/soapNotes/screens/soapNotesList.dart';
import '../../providers/appointmentProvider.dart';
import '../videoCallingAgora/videoCalling.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final AppointmentModelNew appointmentModelNew;

  const AppointmentDetailsScreen({Key? key, required this.appointmentModelNew})
      : super(key: key);

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      updateValues();
    });

    super.initState();
  }

  updateValues() {
    //if (DateTime.now()
    //.isBefore(widget.appointmentModel.combineDateTime!.toDate())) {
    context.read<AppointmentProvider>().updateDayHoursMinutes(
        widget.appointmentModelNew.combineDateTime!.toDate());
    // } else {
    //   context.read<AppointmentProvider>().stopTimer();
    // }
  }

  @override
  void dispose() {
    // print("stop timer");
    context.read<AppointmentProvider>().stopTimer();
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appointmentProvider = Provider.of<AppointmentProvider>(context);
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days =
        strDigits(appointmentProvider.myDuration!.inDays.remainder(31));

    // Step 7
    final hours =
        strDigits(appointmentProvider.myDuration!.inHours.remainder(24));
    final minutes =
        strDigits(appointmentProvider.myDuration!.inMinutes.remainder(60));
    final seconds =
        strDigits(appointmentProvider.myDuration!.inSeconds.remainder(60));

    return Scaffold(
      floatingActionButton: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.appointmentModelNew.appointmentStatus ==
                FirebaseUtils.progress)
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (DateTime.now().isAfter(widget
                            .appointmentModelNew.combineDateTime!
                            .toDate())) {
                          toNext(
                              context: context,
                              widget: ZegoSimpleJoinVideoCallPage(
                                patientID: widget.appointmentModelNew.patientId
                                    .toString(),
                                myUserID: widget.appointmentModelNew.dietitianId
                                    .toString(),
                                callID: widget.appointmentModelNew.patientId
                                    .toString(),
                              ));
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.whitecolor,
                                  title: Text(
                                    "you are early here for appointment",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 14,
                                        color: AppColors.blackcolor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  content: Text(
                                    "Appointment will begin on  your specified time",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 15,
                                        color: AppColors.blackcolor,
                                        overflow: TextOverflow.visible,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  actions: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: AppColors.appcolor),
                                        child: Center(
                                          child: Text(
                                            "ok",
                                            style: fontW5S12(context)!.copyWith(
                                                fontSize: 16,
                                                color: AppColors.whitecolor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.appcolor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        height: 60,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Join Video",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 16,
                                  color: AppColors.whitecolor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        if (DateTime.now().isAfter(widget
                            .appointmentModelNew.combineDateTime!
                            .toDate())) {
                          appointmentProvider
                              .updateAppointmentFromProgressToCompleted(
                                  widget.appointmentModelNew,
                                  widget.appointmentModelNew.appointmentId
                                      .toString());
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.whitecolor,
                                  title: Text(
                                    "Appointment Alert",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 14,
                                        color: AppColors.blackcolor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  content: Text(
                                    "You cannot complete appointment before appointment time",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 15,
                                        color: AppColors.blackcolor,
                                        overflow: TextOverflow.visible,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  actions: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: AppColors.appcolor),
                                        child: Center(
                                          child: Text(
                                            "ok",
                                            style: fontW5S12(context)!.copyWith(
                                                fontSize: 16,
                                                color: AppColors.whitecolor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.appcolor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        height: 60,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Complete Appointment",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 16,
                                  color: AppColors.whitecolor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.appointmentModelNew.appointmentStatus ==
                    FirebaseUtils.completed &&
                widget.appointmentModelNew.isReviewGivenByDietitian == false)
              Padding(
                padding: const EdgeInsets.only(left: 29),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          toNext(
                              context: context,
                              widget: GiveReviewScreen(
                                appointmentModelNew: widget.appointmentModelNew,
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.appcolor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          height: 60,
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Give Review",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 16,
                                    color: AppColors.whitecolor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.whitecolor,
        elevation: 4,
        centerTitle: true,
        title: Text(
          "Appointment Details",
          style: fontW5S12(context)!.copyWith(
              fontSize: 16,
              color: AppColors.blackcolor,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.maybePop(context);
              appointmentProvider.stopTimer();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.blackcolor,
            )),
        actions: [
          IconButton(
              onPressed: () {
                if (DateTime.now().isAfter(
                    widget.appointmentModelNew.combineDateTime!.toDate())) {
                  toNext(
                      context: context,
                      widget: MessagesView(
                        name: widget.appointmentModelNew.patientName.toString(),
                        myID: getUserID(),
                        image: widget.appointmentModelNew.patientProfilePic
                            .toString(),
                        receiverID:
                            widget.appointmentModelNew.patientId.toString(),
                      ));
                  // toNext(
                  //     context: context,
                  //     widget: ZegoSimpleJoinVideoCallPage(
                  //       dietitanID:
                  //       widget.appointmentModel.dietitianId.toString(),
                  //       myUserID:
                  //       widget.appointmentModel.patientId.toString(),
                  //       callID: widget.appointmentModel.patientId.toString(),
                  //     ));
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.whitecolor,
                          title: Text(
                            "you are early here for message",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 14,
                                color: AppColors.blackcolor,
                                fontWeight: FontWeight.w600),
                          ),
                          content: Text(
                            "Message option will open on  your specified appointment time",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 15,
                                color: AppColors.blackcolor,
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.w400),
                          ),
                          actions: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: AppColors.appcolor),
                                child: Center(
                                  child: Text(
                                    "ok",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 16,
                                        color: AppColors.whitecolor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      });
                }
              },
              icon: const Icon(
                Icons.chat,
                color: AppColors.appcolor,
              )),
          // IconButton(
          //     onPressed: () {
          //       toNext(
          //           context: context,
          //           widget: MessagesView(
          //             name: appointmentModelNew.patientName.toString(),
          //             myID: getUserID(),
          //             image: appointmentModelNew.patientProfilePic.toString(),
          //             receiverID: appointmentModelNew.patientId.toString(),
          //           ));
          //     },
          //     icon: const Icon(
          //       Icons.chat,
          //       color: AppColors.appcolor,
          //     )),
          IconButton(
              onPressed: () {
                toNext(
                    context: context,
                    widget: SoapNotesList(
                      appointmentID:
                          widget.appointmentModelNew.appointmentId.toString(),
                      patientID:
                          widget.appointmentModelNew.patientId.toString(),
                      dietitianID:
                          widget.appointmentModelNew.dietitianId.toString(),
                    ));
              },
              icon: Icon(
                Icons.note_add,
                color: AppColors.appcolor,
              )),
          // PopupMenuButton(
          //     // enabled: true,
          //     icon: const Icon(
          //       Icons.more_vert_outlined,
          //       color: AppColors.appcolor,
          //     ),
          //     onSelected: (select) {
          //       if (select == 0) {}
          //     },
          //
          //     // icon: IconButton(
          //     //     onPressed: () {}, icon: Icon(Icons.more_vert_outlined,color: AppColors.appcolor,)),
          //     color: AppColors.whitecolor,
          //     itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          //           PopupMenuItem(
          //             enabled: false,
          //             value: 0,
          //             onTap: () {},
          //             child: Text(
          //               "Soap Notes",
          //               style: fontW5S12(context)!.copyWith(
          //                   fontSize: 14,
          //                   color: AppColors.blackcolor,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //           PopupMenuItem(
          //             value: 1,
          //             // onTap: (){
          //             //   toNext(context: context, widget: AddSoapNote());
          //             // },
          //             child: Text(
          //               "Meal Plans",
          //               style: fontW5S12(context)!.copyWith(
          //                   fontSize: 14,
          //                   color: AppColors.blackcolor,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //           PopupMenuItem(
          //             value: 2,
          //             // onTap: (){
          //             //   toNext(context: context, widget: AddSoapNote());
          //             // },
          //
          //             child: Text(
          //               "Care Plan",
          //               style: fontW5S12(context)!.copyWith(
          //                   fontSize: 14,
          //                   color: AppColors.blackcolor,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //         ])
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            DateTime.now().isBefore(
                    widget.appointmentModelNew.combineDateTime!.toDate())
                ? Text(
                    "Appointment will begin in : ",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 16,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w600),
                  )
                : Text(
                    "",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 1,
                        color: AppColors.redcolor,
                        fontWeight: FontWeight.w600),
                  ),
            const SizedBox(
              height: 10,
            ),
            if (widget.appointmentModelNew.appointmentStatus ==
                FirebaseUtils.progress)
              DateTime.now().isBefore(
                      widget.appointmentModelNew.combineDateTime!.toDate())
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                days,
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 20,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Days",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.appcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                hours,
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 20,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Hours",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.appcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                minutes,
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 20,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Minutes",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.appcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                seconds,
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 20,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Seconds",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.appcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "00",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 20,
                                    color: AppColors.redcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Days",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.appcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "00",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 20,
                                    color: AppColors.redcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Hours",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.appcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "00",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 20,
                                    color: AppColors.redcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Minutes",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.appcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "00",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 20,
                                    color: AppColors.redcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Seconds",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.appcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Appointment DateTime",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 13,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.appointmentModelNew.combineDateTime!
                        .toDate()
                        .format(DateTimeFormats.american)
                        .toString()
                        .replaceAll("12:00 am", ""),
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 13,
                        color: AppColors.blackcolor.withOpacity(0.6),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Patient Details",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 14,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 12,
                              color: AppColors.blackcolor.withOpacity(0.6),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.appointmentModelNew.patientName.toString(),
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 12,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Height",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 12,
                              color: AppColors.blackcolor.withOpacity(0.6),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${widget.appointmentModelNew.patientQuestionareModel!.height} Inches",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 12,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Weight",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 12,
                              color: AppColors.blackcolor.withOpacity(0.6),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${widget.appointmentModelNew.patientQuestionareModel!.weight} lbs",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 12,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Activity Level",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 12,
                              color: AppColors.blackcolor.withOpacity(0.6),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${widget.appointmentModelNew.patientQuestionareModel!.activityLevelList![0].toString()}",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 12,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Want to Achieve",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 14,
                        color: AppColors.blackcolor.withOpacity(0.9),
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: SizedBox(
                            height: 50,
                            // width: 300,
                            child: ListView.builder(
                                itemCount: widget
                                    .appointmentModelNew
                                    .patientQuestionareModel!
                                    .wantToAchieveList!
                                    .length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  return Card(
                                    elevation: 4,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Text(
                                          "${widget.appointmentModelNew.patientQuestionareModel!.wantToAchieveList![index]}",
                                          style: fontW5S12(context)!.copyWith(
                                              fontSize: 11,
                                              color: AppColors.blackcolor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      height: 150,
                      width: 400,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                            side: const BorderSide(
                                width: 2, color: AppColors.appcolor)),
                        color: AppColors.lightwhitecolor,
                        elevation: 4,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.appointmentModelNew.payementPlansModel!
                                  .visitType
                                  .toString(),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 17,
                                  color: AppColors.blackcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 15,
                                        color: AppColors.blackcolor
                                            .withOpacity(0.6),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "\$${widget.appointmentModelNew.payementPlansModel!.visitPrice}",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 15,
                                        color:
                                            AppColors.appcolor.withOpacity(0.9),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Time Duration",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 15,
                                        color: AppColors.blackcolor
                                            .withOpacity(0.6),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    widget
                                                .appointmentModelNew
                                                .payementPlansModel!
                                                .timeDuration ==
                                            null
                                        ? "60"
                                        : "${widget.appointmentModelNew.payementPlansModel!.timeDuration} Minutes",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 15,
                                        color:
                                            AppColors.appcolor.withOpacity(0.9),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
