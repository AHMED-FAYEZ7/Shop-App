import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}


class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard_1.png',
        title: 'On Board 1 Title',
        body: 'On Boarding 1 Body',
    ),
    BoardingModel(
        image: 'assets/images/onboard_2.png',
        title: 'On Board 2 Title',
        body: 'On Boarding 2 Body',
    ),
    BoardingModel(
        image: 'assets/images/onboard_1.png',
        title: 'On Board 3 Title',
        body: 'On Boarding 3 Body',
    ),
  ];

  bool isLast = false;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true)
        .then((value)
    {
          if(value)
          {
            navigateAndFinish(context, LoginScreen(),);

          }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submit,
            text: 'Skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index)
                {
                  if(index == boarding.length - 1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }else
                  {
                    setState(() {
                      isLast = false;
                    });
                  }

                },
                itemBuilder: (context , index) =>
                    buildOnBoardItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed:()
                  {
                    if(isLast)
                    {
                      submit();
                    }else
                    {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 800,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(model.image),
        ),
      ),
      SizedBox(height: 30,),
      Text(
        model.title,
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      SizedBox(height: 15,),
      Text(
        model.body,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      SizedBox(height: 20,),
    ],
  );
}
