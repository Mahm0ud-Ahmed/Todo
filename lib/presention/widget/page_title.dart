import 'package:flutter/material.dart';
import 'package:todo_task/config/style/colors.dart';

import '../../constant.dart';

class PageTitle extends StatefulWidget {
  const PageTitle({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PageTitleState createState() => _PageTitleState();
}

class _PageTitleState extends State<PageTitle> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: _visible ? 0 : -70,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 64,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Align(
          alignment: AlignmentDirectional.center,
          child: Text(
            widget.title,
            style: const TextStyle(
              // color: Colors.grey.shade100,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
      ),
    );
  }
}
