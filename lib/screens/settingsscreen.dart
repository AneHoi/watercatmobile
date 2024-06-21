import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watercat/screens/small_widget_helpers/navigatorbar.dart';
import 'package:watercat/screens/small_widget_helpers/screenlayout.dart';

import '../bloc/blochomepage/homepagecubit.dart';
import '../bloc/blochomepage/homepagestate.dart';
import '../broardcastwschannel.dart';
import 'userscreen.dart';

const textStyle = TextStyle(fontSize: 20);

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const boxColor = Color.fromARGB(255, 183, 206, 241);
    const paddingSize = 10.0;
    const marginSize = 17.0;
    return getLayout(
        SettingContent(
            boxColor: boxColor,
            paddingSize: paddingSize,
            marginSize: marginSize),
        "Settings",
        context);
  }
}

class SettingContent extends StatelessWidget {
  const SettingContent({
    super.key,
    required this.boxColor,
    required this.paddingSize,
    required this.marginSize,
  });

  final Color boxColor;
  final double paddingSize;
  final double marginSize;

  @override
  Widget build(BuildContext context) {
    final TextEditingController timeController = TextEditingController();

    return BlocProvider(
        create: (context) => HomepageCubit(context.read<BroadcastWsChannel>()),
        child: BlocConsumer<HomepageCubit, HomepageState>(
            listener: (context, state) {
            }, builder: (context, state) {

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 800),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: getBoxColorLight(),
                  ),
                  color: boxColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.all(paddingSize),
              margin: EdgeInsets.all(marginSize),
              height: 75,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Keep turned on for: ", style: textStyle),
                        Flexible(
                          child: TextField(
                            controller: timeController,
                            decoration: InputDecoration(
                              hintText: "5", // Placeholder text
                            ),
                            keyboardType: TextInputType.number,
                            // Only numbers can be entered
                          ),
                        ),
                        Text(" min", style: textStyle),
                        const Spacer(),
                        //spaces the Text element and the Arrow as far from each other as possible
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () async {
                            await context.read<HomepageCubit>().changeRequestedOnTime(int.parse(timeController.text));
                          },
                        )
                      ])),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 800),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: getBoxColorLight(),
                  ),
                  color: boxColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.all(paddingSize),
              margin: EdgeInsets.all(marginSize),
              height: 75,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("User information", style: textStyle),
                    const Spacer(),
                    //spaces the Text element and the Arrow as far from each other as possible
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        goToPage(context, UserScreen.new);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
            }
            )
    );
  }
}
