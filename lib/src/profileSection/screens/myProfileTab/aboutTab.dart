import 'package:dietationapp/common/utils/themes.dart';
import 'package:dietationapp/src/profileSection/screens/aboutTabs/bankingInformationTab.dart';
import 'package:dietationapp/src/profileSection/screens/aboutTabs/personal_informationTab.dart';
import 'package:dietationapp/src/profileSection/screens/aboutTabs/professionalInformationTab.dart';
import 'package:flutter/material.dart';

import '../../../../common/utils/appcolors.dart';

class AboutUserProfileTabScreen extends StatelessWidget {
  const AboutUserProfileTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
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
                tabs: [
                  Tab(
                    text: "Personal",
                  ),
                  Tab(
                    text: "Professional",
                  ),
                  Tab(
                    text: "Banking",
                  )
                ]),
            Expanded(
              child: TabBarView(children: [
                PersonalInformation(),
                ProfessionalInformation(),
                BankingInformation(),
                // ReviewListTabScreen(),
                // AboutUserProfileTabScreen()
              ]),
            )
          ],
        ),
      ),
    );
  }
}
