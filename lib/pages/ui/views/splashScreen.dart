part of './../pages.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var duration = Duration(seconds: 2);
    Timer(duration, () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => DrawPad()));
    });

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: double.infinity,
      child: Stack(alignment: Alignment.center, children: [
        Positioned(top: 0, left: 0, child: Image.asset(AppImages.circleTop)),
        Positioned(
            right: 0, bottom: 0, child: Image.asset(AppImages.circleBottom)),
        Center(
            child: Text("Draw Your'e\nSignature",
                style: AppFonts.dancingStyle
                    .copyWith(color: AppColors.redColor, fontSize: 48)))
      ]),
    ));
  }
}
