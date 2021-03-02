import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo/stores/page/page_store.dart';

class CreateAdvertsButton extends StatefulWidget {
  CreateAdvertsButton(this.scrollController);

  final ScrollController scrollController;

  @override
  _CreateAdvertsButtonState createState() => _CreateAdvertsButtonState();
}

class _CreateAdvertsButtonState extends State<CreateAdvertsButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> buttonAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    buttonAnimation = Tween<double>(begin: 0, end: 66).animate(
      CurvedAnimation(parent: controller, curve: Interval(0.4, 0.6)),
    );

    widget.scrollController.addListener(scrollChanged);
  }

  void scrollChanged() {
    final position = widget.scrollController.position;

    if (position.userScrollDirection == ScrollDirection.forward)
      controller.forward();
    else
      controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: buttonAnimation,
      builder: (context, child) => FractionallySizedBox(
        widthFactor: 0.6,
        child: Container(
          height: 50,
          margin: EdgeInsets.only(bottom: buttonAnimation.value),
          child: RaisedButton(
            color: Colors.orange,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Icon(Icons.camera_alt, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Anunciar agora',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            onPressed: () {
              GetIt.I<PageStore>().setPage(1);
            },
          ),
        ),
      ),
    );
  }
}
