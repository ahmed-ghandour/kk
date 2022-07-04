import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  final String title;
  final String body;
  final String? image;
  BoardingModel({
    required this.title,
    required this.body,
    required this.image
});

}
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();
  bool isLast = false;
  void submit()
  {
    CasheHelper.saveData(
        key: 'onBoarding',
        value: true
    ).then((value)
    {
      navigateTo(context, ShopLoginScreen());
    });
  }
  List <BoardingModel> boarding = [
    BoardingModel(title: 'First Title', body: 'First Body', image:'assets/images/3.png'),
    BoardingModel(title: 'Second Title', body: 'Second Body', image:'assets/images/2.png'),
    BoardingModel(title: 'Third Title', body: 'Third Body', image:'assets/images/1.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          TextButton(
              onPressed: submit,
              child: const Text('SKIP',
              style: TextStyle(fontSize: 15),)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                  controller: boardingController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (int index)
                  {
                    if ( index == boarding.length-1)
                      {
                        setState(()
                        {
                          isLast = true;
                        });
                        print('last');
                      }
                    else
                      {
                        setState(()
                        {
                          isLast = false;
                        });
                        print('not last');
                      }
                  },
                  itemBuilder: ( context , index) => buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height:40 ,),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller: boardingController,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      expansionFactor: 3,
                      spacing: 10,
                    ),
                    count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      submit();
                    }
                    else
                      {
                        boardingController.nextPage(
                            duration: const Duration( milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
          child: Image(
              image: AssetImage('${model.image}')
          )),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold
        ),
      ),
    ],
  );
}
