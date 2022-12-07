import 'package:date_time_format/date_time_format.dart';
import 'package:dietationapp/common/helperFunctions/getUserIDhelper.dart';
import 'package:dietationapp/src/apppointmentsSection/providers/appointmentProvider.dart';
import 'package:dietationapp/src/apppointmentsSection/services/appointmentServices.dart';
import 'package:dietationapp/src/apppointmentsSection/widgets/weekdayWidget.dart';
import 'package:dietationapp/src/authenticationsection/services/userServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/button_widget.dart';
import '../../authenticationsection/Models/userModel.dart';
import '../widgets/accessories_widget.dart';

class AvailableTimeSlots extends StatefulWidget {
  const AvailableTimeSlots({Key? key}) : super(key: key);

  @override
  State<AvailableTimeSlots> createState() => _AvailableTimeSlotsState();
}

class _AvailableTimeSlotsState extends State<AvailableTimeSlots> {
  AppointmentServices appointmentServices = AppointmentServices();
  UserServices userServices = UserServices();

  @override
  void initState() {
    context.read<AppointmentProvider>().getCalendarDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, __) {
      return Scaffold(
          bottomSheet: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonButtonWidget(
                  horizontalPadding: 8,
                  backgroundcolor: AppColors.appcolor,
                  text: "Add",
                  textfont: 16,
                  onTap: () {
                    appointmentProvider.updateTimeSlot();
                    //   toNext(context: context, widget: TestWorkWeekCalendar());
                  }),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
          body: StreamProvider.value(
              value: userServices.fetchUserRecord(
                getUserID(),
              ),
              initialData: UserModel(),
              builder: (context, child) {
                UserModel model = context.watch<UserModel>();
                return model.userId == null
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.maybePop(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.appcolor,
                                        )),
                                  ),
                                  Text(
                                    "Add/Edit Availability",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 19,
                                        color: AppColors.blackcolor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "    ",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 23,
                                        color: AppColors.blackcolor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     toNext(context: context, widget: CreateAppointmentSlot());
                                  //     //Navigator.maybePop(context);
                                  //   },
                                  //   child: Container(
                                  //     height: 40,
                                  //     width: 95,
                                  //     decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(11),
                                  //         color: AppColors.appcolor.withOpacity(0.3)),
                                  //     child: Center(
                                  //       child: Row(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           // const Icon(
                                  //           //   Icons.close,
                                  //           //   size: 20,
                                  //           //   color: AppColors.redcolor,
                                  //           // ),
                                  //           // const SizedBox(
                                  //           //   width: 8,
                                  //           // ),
                                  //           Text(
                                  //             "Add New",
                                  //             style: fontW5S12(context)!.copyWith(
                                  //                 fontSize: 14,
                                  //                 color: AppColors.blackcolor,
                                  //                 fontWeight: FontWeight.w500),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 12),
                            //   child: Card(
                            //     elevation: 4,
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(13)),
                            //     color: AppColors.whitecolor,
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: SfDateRangePicker(
                            //         initialSelectedDates: [
                            //           DateTime(2022, 11, 14, 0, 0, 0, 0, 0),
                            //           DateTime(2022, 11, 15, 0, 0, 0, 0, 0)
                            //         ],
                            //         //   initialSelectedDates: appointmentProvider.timslotList,
                            //         initialDisplayDate: DateTime.now(),
                            //         headerStyle: DateRangePickerHeaderStyle(
                            //             backgroundColor: AppColors.appcolor.withOpacity(0.9),
                            //             textAlign: TextAlign.center,
                            //             textStyle: fontW4S12(context)!.copyWith(
                            //                 fontSize: 17, color: AppColors.whitecolor)),
                            //         headerHeight: 50,
                            //
                            //         controller:
                            //             appointmentProvider.datePickerControllerfortimeslot,
                            //         enablePastDates: false,
                            //         enableMultiView: false,
                            //
                            //         showNavigationArrow: true,
                            //         minDate: DateTime.now(),
                            //         viewSpacing: 20,
                            //
                            //         // monthViewSettings:
                            //         //     DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                            //         onSelectionChanged: appointmentProvider.onSelectionChanged,
                            //         navigationDirection:
                            //             DateRangePickerNavigationDirection.horizontal,
                            //         selectionMode: DateRangePickerSelectionMode.single,
                            //         startRangeSelectionColor: AppColors.appcolor,
                            //         endRangeSelectionColor: AppColors.appcolor,
                            //         todayHighlightColor: AppColors.appcolor,
                            //
                            //
                            //         //showActionButtons: true,
                            //         //allowViewNavigation: false,
                            //         view: DateRangePickerView.month,
                            //         selectionRadius: 17,
                            //         rangeSelectionColor: AppColors.appcolor.withOpacity(0.3),
                            //         selectionShape: DateRangePickerSelectionShape.rectangle,
                            //         selectionColor: AppColors.appcolor,
                            //         monthViewSettings: DateRangePickerMonthViewSettings(
                            //           specialDates: [
                            //             DateTime(2022, 11, 14, 0, 0, 0, 0, 0),
                            //             DateTime(2022, 11, 15, 0, 0, 0, 0, 0)
                            //           ],
                            //           // blackoutDates: [
                            //           //   DateTime(2022, 11, 14, 0, 0, 0, 0, 0),
                            //           //   DateTime(2022, 11, 15, 0, 0, 0, 0, 0)
                            //           // ],
                            //           // showWeekNumber: true,
                            //           enableSwipeSelection: false,
                            //           weekNumberStyle: DateRangePickerWeekNumberStyle(
                            //               textStyle: TextStyle(color: AppColors.redcolor)),
                            //           firstDayOfWeek: 1,
                            //           showTrailingAndLeadingDates: true,
                            //           dayFormat: 'EE',
                            //           viewHeaderStyle: DateRangePickerViewHeaderStyle(
                            //
                            //               //    backgroundColor: Color(0xFF7fcd91),
                            //               textStyle: TextStyle(
                            //                   color: AppColors.blackcolor,
                            //                   fontWeight: FontWeight.w500,
                            //                   fontSize: 14,
                            //                   letterSpacing: 5)),
                            //
                            //           //  numberOfWeeksInView: 1
                            //         ),
                            //         toggleDaySelection: true,
                            //
                            //         //showTodayButton: true,
                            //         //   showActionButtons: ,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 12),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         appointmentProvider
                            //                     .datePickerControllerfortimeslot.selectedDate ==
                            //                 null
                            //             ? "Please Select Date"
                            //             : appointmentProvider
                            //                 .datePickerControllerfortimeslot.selectedDate!
                            //                 .format(DateTimeFormats.american)
                            //                 .toString()
                            //                 .replaceAll("12:00 am", ""),
                            //         style: fontW5S12(context)!.copyWith(
                            //             fontSize: 14,
                            //             color: AppColors.blackcolor.withOpacity(0.6),
                            //             fontWeight: FontWeight.w500),
                            //       ),
                            //       InkWell(
                            //         onTap: () {
                            //           toNext(
                            //               context: context,
                            //               widget: const CreateAppointmentSlot());
                            //         },
                            //         child: Text(
                            //           "+ Add Slot Time",
                            //           style: fontW5S12(context)!.copyWith(
                            //               fontSize: 14,
                            //               color: AppColors.appcolor,
                            //               fontWeight: FontWeight.w700),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 15,
                            // ),
                            //

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Available Days",
                                  style: fontW5S12(context)!.copyWith(
                                      fontSize: 15,
                                      color: AppColors.blackcolor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),
                            Consumer<AppointmentProvider>(
                                builder: (context, appointmentProvider, __) {
                              return Wrap(
                                direction: Axis.horizontal,
                                //  runAlignment: WrapAlignment.end,
                                children: [
                                  // ...model.availableDays!.toList()
                                  "Monday",
                                  "Tuesday",
                                  "Wednesday",
                                  "Thursday",
                                  "Friday",
                                  "Saturday",
                                  "Sunday"
                                ]
                                    .map((e) => WeekDaysWidget(
                                          onTap: (value) {
                                            appointmentProvider
                                                .addOrRemoveAvailableDays(
                                                    context, value);
                                          },
                                          text: e,
                                          color: appointmentProvider
                                                  .availableDays
                                                  .contains(e)
                                              ? AppColors.appcolor
                                              : Colors.grey,
                                        ))
                                    .toList(),
                              );
                            }),
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Select Available Time Slots",
                                      style: fontW5S12(context)!.copyWith(
                                          fontSize: 15,
                                          color: AppColors.blackcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // IconButton(onPressed: () {}, icon: Icon(Icons.add))
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            //Text(DateTime.utc(2018, 1, 1, 6, 30).toString()),
                            //   Text(DateTime.parse("").toString()),

                            Consumer<AppointmentProvider>(
                                builder: (context, appointmentProvider, __) {
                              return Wrap(
                                direction: Axis.horizontal,
                                //  runAlignment: WrapAlignment.end,
                                children: [
                                  //   DateTime.parse("2012-02-27 6:00:00 "),

                                  "2012-02-27 13:00:00",
                                  "2012-02-27 13:30:00",
                                  "2012-02-27 14:00:00",
                                  "2012-02-27 14:30:00",
                                  "2012-02-27 15:00:00",
                                  "2012-02-27 15:30:00",
                                  "2012-02-27 16:00:00",
                                  "2012-02-27 16:30:00",
                                  "2012-02-27 17:00:00",
                                  "2012-02-27 17:30:00",
                                  "2012-02-27 18:00:00",
                                  "2012-02-27 18:30:00",
                                  "2012-02-27 19:00:00",
                                  "2012-02-27 19:30:00",
                                  "2012-02-27 20:00:00",
                                  "2012-02-27 20:30:00",
                                  "2012-02-27 21:00:00",
                                  "2012-02-27 21:30:00",
                                  "2012-02-27 22:00:00",
                                  "2012-02-27 22:30:00",
                                  "2012-02-27 23:00:00",
                                  "2012-02-27 23:30:00",
                                  "2012-02-27 24:00:00",
                                  "2012-02-27 24:30:00",
                                  "2012-02-27 01:00:00",
                                  "2012-02-27 01:30:00",
                                  "2012-02-27 02:00:00",
                                  "2012-02-27 02:30:00",
                                  "2012-02-27 03:00:00",
                                  "2012-02-27 03:30:00",
                                  "2012-02-27 04:00:00",
                                  "2012-02-27 04:30:00",
                                  "2012-02-27 05:00:00",
                                  "2012-02-27 05:30:00",
                                  "2012-02-27 06:00:00",
                                  "2012-02-27 06:30:00",
                                  "2012-02-27 07:00:00",
                                  "2012-02-27 07:30:00",
                                  "2012-02-27 08:00:00",
                                  "2012-02-27 08:30:00",
                                  "2012-02-27 09:00:00",
                                  "2012-02-27 09:30:00",
                                  "2012-02-27 10:00:00",
                                  "2012-02-27 10:30:00",
                                  "2012-02-27 11:00:00",
                                  "2012-02-27 11:30:00",
                                  "2012-02-27 12:00:00",
                                  "2012-02-27 12:30:00",

                                  // "6:30 - 7:00 AM",
                                  // "7:00 - 7:30 AM",
                                  // "7:30 - 8:00 AM",
                                  // "8:00 - 8:30 AM",
                                  // "8:30 - 9:00 AM",
                                  // "9:00 - 9:30 AM",
                                  // "9:30 - 10:00 AM",
                                  // "10:00 - 10:30 AM",
                                  // "10:30 - 11:00 AM",
                                  // "11:00 - 11:30 AM",
                                  // "11:30 - 12:00 PM",
                                  // "12:00 - 12:30 PM",
                                  // "12:30 - 1:00 PM",
                                  // "1:00 - 1:30 PM",
                                  // "1:30 - 2:00 PM",
                                  // "2:00 - 2:30 PM",
                                  // "2:30 - 3:00 PM",
                                  // "3:30 - 4:00 PM",
                                  // "4:00 - 4:30 PM",
                                  // "4:30 - 5:00 PM",
                                  // "5:00 - 5:30 PM",
                                  // "5:30 - 6:00 PM",
                                  // "6:00 - 6:30 PM",
                                  // "6:30 - 7:00 PM",
                                  // "7:00 - 7:30 PM",
                                  // "7:30 - 8:00 PM",
                                  // "8:00 - 8:30 PM",
                                  // "8:30 - 9:00 PM",
                                  // "9:00 - 9:30 PM",
                                  // "9:30 - 10:00 PM",
                                  // "10:00 - 10:30 PM",
                                  // "10:30 - 11:00 PM",
                                  // "11:00 - 11:30 PM",
                                  // "11:30 - 12:00 AM",
                                ]
                                    .map((e) => TimeSlotWidget(
                                          onTap: (value) {
                                            appointmentProvider
                                                .addOrRemoveAvailableTimeSlots(
                                                    context, value);
                                          },
                                          text: e,
                                          //  text: e,
                                          // .replaceAll(
                                          //     "February 27,2012 1:27 pm", ""),
                                          color: appointmentProvider
                                                  .availableSlots
                                                  .contains(e)
                                              ? AppColors.appcolor
                                              : Colors.grey,
                                        ))
                                    .toList(),
                              );
                            }),
                            const SizedBox(
                              height: 100,
                            )

                            //   height: 15,
                            // ),
                            // StreamProvider.value(
                            //     value: appointmentServices.streamTimeSlots(
                            //         getUserID(),
                            //         appointmentProvider
                            //             .datePickerControllerfortimeslot.selectedDate
                            //             .toString()),
                            //     initialData: [TimeSlotModel()],
                            //     builder: (context, child) {
                            //       List<TimeSlotModel> timeSlotList =
                            //           context.watch<List<TimeSlotModel>>();
                            //       return timeSlotList.isEmpty
                            //           ? Padding(
                            //               padding: const EdgeInsets.only(top: 20),
                            //               child: Column(
                            //                 children: [
                            //                   //   Lottie.
                            //                   Lottie.network(
                            //                       // height: 50,
                            //                       // width: 50,
                            //                       'https://assets9.lottiefiles.com/temporary_files/PH5YkW.json'),
                            //                   Padding(
                            //                     padding: const EdgeInsets.only(right: 20),
                            //                     child: Text(
                            //                       "No Slot Found ! \n    + Add Slot",
                            //                       style: fontW5S12(context)!.copyWith(
                            //                           fontSize: 14,
                            //                           color: AppColors.lightdarktextcolor,
                            //                           fontWeight: FontWeight.w700),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             )
                            //           // ? const Center(
                            //           //     child: Padding(
                            //           //     padding: EdgeInsets.only(top: 100),
                            //           //     child: Text(
                            //           //         "No Timeslot Found to this Date! \n + Add Slot Time to this date",
                            //           //         style: TextStyle(
                            //           //             // fontFamily: 'Gilroy',
                            //           //             color: AppColors.blackcolor,
                            //           //             // decoration: TextDecoration.underline,
                            //           //             fontWeight: FontWeight.w700,
                            //           //             fontFamily: 'Axiforma',
                            //           //             fontSize: 13)),
                            //           //   ))
                            //           : timeSlotList[0].dateofslot == null
                            //               ? const SpinKitPouringHourGlass(
                            //                   size: 30,
                            //                   color: AppColors.appcolor,
                            //                 )
                            //               : Expanded(
                            //                   flex: 4,
                            //                   child: ListView.builder(
                            //                       itemCount: timeSlotList.length,
                            //                       shrinkWrap: true,
                            //                       padding: EdgeInsets.only(top: 5),
                            //                       itemBuilder: ((context, index) {
                            //                         return Padding(
                            //                           padding: EdgeInsets.only(bottom: 12),
                            //                           child: TimeSlotWidget(
                            //                             timeSlotModel: timeSlotList[index],
                            //                           ),
                            //                         );
                            //                       })),
                            //                 );
                            //     })
                          ],
                        ),
                      );
              }));
    });
  }
}
