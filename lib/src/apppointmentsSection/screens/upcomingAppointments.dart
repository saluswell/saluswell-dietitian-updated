import 'package:dietationapp/src/apppointmentsSection/screens/appointmenstTab/upcomingTab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../providers/appointmentProvider.dart';
import 'appointmenstTab/completed.dart';
import 'appointmenstTab/pendingForApproval.dart';
import 'availableTimeSlots.dart';

class UpcomingAppointmenrsScreen extends StatefulWidget {
  const UpcomingAppointmenrsScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingAppointmenrsScreen> createState() =>
      _UpcomingAppointmenrsScreenState();
}

class _UpcomingAppointmenrsScreenState
    extends State<UpcomingAppointmenrsScreen> {
  // @override
  // void initState() {
  //   context.read<AppointmentProvider>().getpendingAppointments();
  //   context.read<AppointmentProvider>().getprogressAppointments();
  //   context.read<AppointmentProvider>().getcompletedAppointments();
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Appointments",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 23,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            toNext(
                                context: context,
                                widget: const AvailableTimeSlots());
                            //  toNext(context: context, widget: CalendarScreen());
                          },
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: AppColors.appcolor,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Consumer<AppointmentProvider>(
                builder: (context, appointmentProvider, __) {
              return TabBar(
                  labelStyle: fontW4S12(context)!.copyWith(
                      color: AppColors.lightwhitecolor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                  indicatorPadding: EdgeInsets.only(),
                  indicatorWeight: 2,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: AppColors.appcolor,
                  unselectedLabelColor: AppColors.lightdarktextcolor,
                  padding: EdgeInsets.only(),
                  tabs: const [
                    Tab(
                      text:
                          "Progress",
                    ),
                    // Tab(
                    //   text:
                    //       "Pending",
                    // ),
                    Tab(
                      text:
                          "Completed",
                    )
                  ]);
            }),
            const Expanded(
              child: TabBarView(children: [
                //  ProgressAppointmentTab(),
                UpcomingAppointmentsTab(),
              //  PendingForApprovalAppointmentsTab(),
                CompletedAppointmentsTab(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
