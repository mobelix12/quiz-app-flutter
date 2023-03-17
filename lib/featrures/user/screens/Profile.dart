import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indexed/indexed.dart';
import 'package:quizz_app/assets/colors.dart';
import 'package:quizz_app/featrures/repositories/user_repo.dart';
import 'package:quizz_app/featrures/user/home/widgets/Badges.dart';
import 'package:quizz_app/featrures/user/home/widgets/CircleTabIndicator.dart';
import 'package:quizz_app/featrures/user/home/widgets/Statistics.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../home/widgets/UserDetails.dart';
import '../home/widgets/UserStats.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String circleAsset = 'lib/assets/svg/circle.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: Device.get().isIphoneX
                    ? const EdgeInsets.symmetric(vertical: 50)
                    : const EdgeInsets.symmetric(vertical: 40),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.chevron_left,
                        size: 32,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.settings,
                        size: 25,
                        color: Colors.white,
                      )
                    ]),
              ),
              Positioned(
                  left: -70,
                  top: 40,
                  child: Transform.scale(
                    scale: 1.3,
                    child: SvgPicture.asset(circleAsset),
                  )),
              Positioned(
                  right: -30,
                  top: -40,
                  child: Transform.scale(
                    scale: 0.9,
                    child: SvgPicture.asset(circleAsset),
                  )),
              Positioned(
                  right: -50,
                  bottom: 20,
                  child: Transform.scale(
                    scale: 1,
                    child: SvgPicture.asset(circleAsset),
                  )),
              Positioned(
                  left: -20,
                  bottom: 100,
                  child: Transform.scale(
                    scale: 1,
                    child: SvgPicture.asset(circleAsset),
                  )),
              Indexer(
                children: [
                  Indexed(
                    index: 100,
                    child: Positioned(
                      left: Device.screenWidth / 2 - 45,
                      top: 120,
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          child: Container(
                            height: 90,
                            width: 90,
                            color: Colors.white,
                            child: state.isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                    backgroundColor: ColorConstants.darkViolet,
                                  )
                                : Image.memory(
                                    base64Decode(state.avatar),
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                          )),
                    ),
                  ),
                  Indexed(
                      index: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 170),
                        child: Container(
                          padding: const EdgeInsets.only(top: 50),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                state.isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                        backgroundColor:
                                            ColorConstants.darkViolet,
                                      )
                                    : Text(
                                        state.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                      ),
                                const Statistics(),
                                DefaultTabController(
                                  length: 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TabBar(
                                          indicator: CircleTabIndicator(
                                              color: ColorConstants.violet,
                                              radius: 3),
                                          labelColor: ColorConstants.violet,
                                          labelStyle: const TextStyle(
                                              fontWeight: FontWeight.w700),
                                          unselectedLabelColor:
                                              Colors.grey.withOpacity(0.7),
                                          indicatorSize:
                                              TabBarIndicatorSize.tab,
                                          tabs: const [
                                            Tab(
                                              height: 50,
                                              text: "Badge",
                                            ),
                                            Tab(height: 50, text: "Stats"),
                                            Tab(height: 50, text: "Details"),
                                          ]),
                                      SizedBox(
                                        height: Device.get().isTablet
                                            ? Device.height / 3
                                            : Device.height / 8,
                                        child: const TabBarView(children: [
                                          Badges(),
                                          UserStats(),
                                          UserDetails(),
                                        ]),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                        ),
                      ))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
