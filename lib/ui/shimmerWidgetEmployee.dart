import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import 'package:google_fonts/google_fonts.dart';

class ShimmerWidgetMatch extends StatelessWidget {
  const ShimmerWidgetMatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleHead = GoogleFonts.lato(
      fontWeight: FontWeight.w500,
      fontSize: 11,
      color: Color(0xffFFFFFF),
    );

    return Column(
      children: [
        dummyListViewCell1(),
        dummyListViewCell1(),
        dummyListViewCell1(),
        dummyListViewCell1(),
        dummyListViewCell1(),
        dummyListViewCell1(),
      ],
    );
  }
}

Widget dummyListViewCell1() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Container(
      height: 135,
      decoration: BoxDecoration(
        color: Color(0xff252526),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
                top: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 0, top: 0, bottom: 2),
                        child: Shimmer.fromColors(
                          baseColor: Color(0xFF1D1D1D),
                          highlightColor: Color(0XFF3C4042),
                          child: Shimmer.fromColors(
                            baseColor: Color(0xFF1D1D1D),
                            highlightColor: Color(0XFF3C4042),
                            child: Container(
                              width: 100.0,
                              height: 8.0,
                              decoration: BoxDecoration(
                                color: Color(0xff252526),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Color(0xFF1D1D1D),
                          highlightColor: Color(0XFF3C4042),
                          child: Container(
                            width: 80.0,
                            height: 60.0,
                            decoration: new BoxDecoration(
                              color: Color(0xff252526),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 0, top: 0, bottom: 2),
                        child: Shimmer.fromColors(
                          baseColor: Color(0xFF1D1D1D),
                          highlightColor: Color(0XFF3C4042),
                          child: Shimmer.fromColors(
                            baseColor: Color(0xFF1D1D1D),
                            highlightColor: Color(0XFF3C4042),
                            child: Container(
                              width: 100.0,
                              height: 8.0,
                              decoration: BoxDecoration(
                                color: Color(0xff252526),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Color(0xFF1D1D1D),
                          highlightColor: Color(0XFF3C4042),
                          child: Container(
                            width: 80.0,
                            height: 60.0,
                            decoration: new BoxDecoration(
                              color: Color(0xff252526),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Shimmer.fromColors(
              baseColor: Color(0xFF1D1D1D),
              highlightColor: Color(0XFF3C4042),
              child: Container(
                width: double.infinity,
                height: 8.0,
                decoration: BoxDecoration(
                  color: Color(0xff252526),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
