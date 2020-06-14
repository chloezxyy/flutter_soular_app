import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// to input picture source in explore page 

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Icon icon;
  final Function press;
  const CategoryCard({
    Key key,
    this.svgSrc,
    this.title,
    this.icon,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  // SvgPicture.asset(svgSrc),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    // style: Theme.of(context)
                    //     .textTheme
                    //     .title
                    //     .copyWith(fontSize: 10),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}