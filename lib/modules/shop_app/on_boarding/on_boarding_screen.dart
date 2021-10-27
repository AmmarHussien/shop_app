import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/login_screen/shop_login_screen.dart';
import 'package:shop_app/shared/compmnant/componanets.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel
{
    late final String image ;
    late final String title ;
    late final String body ;
    BoardingModel({
      required this.title,
      required this.image,
      required this.body,
  });
}
class OnBoardingScreen extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/logo.png',
      title: 'On Board 1 Title',
      body:  'On Board 1 body',
    ),
    BoardingModel(
      image: 'assets/logo.png',
      title: 'On Board 2 Title',
      body:  'On Board 2 body',
    ),
    BoardingModel(
      image: 'assets/logo.png',
      title: 'On Board 3 Title',
      body:  'On Board 3 body',
    ),
  ];

  void submit()
  {
    CacheHelper.saveDate(
        key: 'onBoarding',
        value: true).then((value) {
          if (value) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function:submit,
          text: 'Skip' ,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                  itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                onPageChanged:(int index)
                {
                  if(index == boarding.length - 1 )
                    {
                      setState(() {
                        isLast = true;
                      });
                    }
                  else
                    {
                      setState(() {
                        isLast = false;
                      });
                    }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                      {
                        submit();
                      }
                    else
                      {
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      )
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
            image: AssetImage('${model.image}'),
        ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,

        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,

        ),
      ),
      SizedBox(
        height: 15.0,
      ),
    ],
  );
}
