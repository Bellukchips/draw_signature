part of './../pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Hello\nFriend's",
              style: AppFonts.dancingStyle
                  .copyWith(fontSize: 55, color: AppColors.redColor),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                  child: ListView(
                children: [
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                ],
              ))),
          // Expanded(
          //   flex:2,
          //   child: Stack(
          //     alignment: AlignmentDirectional.bottomCenter,
          //     children: [
          //       Positioned(
          //           bottom: 20,
          //           child:
          //               Text('Versi 1.0', style: TextStyle(color: Colors.grey)))
          //     ],
          //   ),
          // )
        ],
      ),
    ));
  }
}
