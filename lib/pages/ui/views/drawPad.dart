part of './../pages.dart';

class DrawPad extends StatefulWidget {
  @override
  _DrawPadState createState() => _DrawPadState();
}

class _DrawPadState extends State<DrawPad> {
  // Todo : implement variable for color picker
  //pena color
  Color penColor = AppColors.redAccentColor;
  Color currentpenColor = Colors.black;
  //
  Color backgroundColor = Colors.white;
  Color currentbackgroundColor =  Colors.white;

  // Todo : implement color picker function
  void changePenColor(Color color) {
    setState(() {
      penColor = color;
    });
  }

  void changeBackgroundColor(Color color) {
    setState(() {
      backgroundColor = color;
    });
  }

  @override
  void initState() {
    super.initState();
    Permission.storage.request();
  }

  // Global Key to export widget to image
  GlobalKey _globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    //Todo : implement Signature controller
    final SignatureController _controller = SignatureController(
      penColor: currentpenColor,
      penStrokeWidth: 1,
      exportBackgroundColor: currentbackgroundColor,
    );
    //

    //save image
    Future<void> saveImage() async {
      // Todo : request permission gallery
      try {
        RenderRepaintBoundary boundary =
            _globalKey.currentContext.findRenderObject();
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData.buffer.asUint8List();
       
        await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),
            quality: 80,
            name: "signature_${DateTime.now().millisecondsSinceEpoch}");
        //
        Flushbar(
          title: "Success",
          message: "Success save to gallery",
          backgroundColor: AppColors.redAccentColor,
          flushbarPosition: FlushbarPosition.TOP,
          duration: Duration(seconds: 3),
        )..show(context);
      } catch (e) {
        Flushbar(
          title: "Failed",
          message: "Failed save to gallery",
          backgroundColor: AppColors.redAccentColor,
          flushbarPosition: FlushbarPosition.TOP,
          duration: Duration(seconds: 3),
        )..show(context);
        print(e);
      }
    }

    return Builder(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          height: 100,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
              color: AppColors.redAccentColor,
              borderRadius: BorderRadius.circular(20)),
          width: 250,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.palette, color: Colors.white),
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: const Text('Pick a pena color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: penColor,
                              onColorChanged: changePenColor,
                              showLabel: true,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('Got it'),
                              onPressed: () {
                                setState(() {
                                  currentpenColor = penColor;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Text(
                    'Color',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon:
                        Icon(Icons.format_paint_outlined, color: Colors.white),
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: const Text('Pick a background color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: backgroundColor,
                              onColorChanged: changeBackgroundColor,
                              showLabel: true,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('Got it'),
                              onPressed: () {
                                setState(() {
                                  currentbackgroundColor = backgroundColor;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Text(
                    'Background',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.cleaning_services_outlined,
                        color: Colors.white),
                    onPressed: () {
                      setState(() => _controller.clear());
                    },
                  ),
                  Text(
                    'Clear',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      setState(() {
                        saveImage();
                      });
                    },
                  ),
                  Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          child: Column(
            children: [
              Container(
                color: Colors.black,
                height: 250,
              ),
              Expanded(
                child: RepaintBoundary(
                  key: _globalKey,
                  child: Signature(
                    height: 300,
                    width: double.infinity,
                    controller: _controller,
                    backgroundColor: currentbackgroundColor,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black,
                  height: 250,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
