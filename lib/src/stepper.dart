import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class StepperDemo extends StatelessWidget {
  StepperDemo({super.key});

  final double radius = 30;
  List<String> images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRu_Z4iHbbb6VCIIZPLHgDNz4d5IurbrcHZ0w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRu_Z4iHbbb6VCIIZPLHgDNz4d5IurbrcHZ0w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRu_Z4iHbbb6VCIIZPLHgDNz4d5IurbrcHZ0w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRu_Z4iHbbb6VCIIZPLHgDNz4d5IurbrcHZ0w&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    OrderStatus orderStatus = OrderStatus.stepperStatus;
    return Directionality(
      textDirection: TextDirection.rtl,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...StepperEnum.values.mapIndexed((i,e) =>
            stepperItem(
              title: e.title,
              showLine:  i < StepperEnum.values.length -1,
              radius: e.radius,
              isActive: StepperEnum.values.indexOf(orderStatus.status) >= i,
            ),
          ).toList(),
          // stepperItem(
          //   title: StepperEnum.first.title,
          //   showLine: StepperEnum.first.showLine,
          //   isActive: orderStatus.status ==StepperEnum.first,
          //   radius: StepperEnum.first.radius,
          // ),
          // stepperItem(
          //   title: StepperEnum.second.title,
          //   showLine: StepperEnum.second.showLine,
          //   isActive: StepperEnum.second.isActive,
          //   radius: StepperEnum.second.radius,
          // ),
          // stepperItem(
          //   title: StepperEnum.third.title,
          //   showLine: StepperEnum.third.showLine,
          //   isActive: StepperEnum.third.isActive,
          //   radius: StepperEnum.third.radius,
          // ),
          // stepperItem(
          //   title: StepperEnum.fourth.title,
          //   showLine: StepperEnum.fourth.showLine,
          //   isActive: StepperEnum.fourth.isActive,
          //   radius: StepperEnum.fourth.radius,
          // ),
        ],
      ),
    );
  }
}

class OrderStatus{
  final StepperEnum status;

  OrderStatus({required this.status});

  static OrderStatus get stepperStatus{
    return OrderStatus(status: StepperEnum.second);
  }

}

class DashedLineVerticalPainter extends CustomPainter {
  final Color color;

  DashedLineVerticalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

enum StepperEnum {
  first(title: 'First', showLine: true, isActive: false, radius: 30),
  second(title: 'Second', showLine: true, isActive: true, radius: 30),
  third(title: 'Third', showLine: true, isActive: true, radius: 30),
  fourth(title: 'Fourth', showLine: false, isActive: true, radius: 30);

  final String title;
  final bool showLine;
  final bool isActive;
  final double? radius;

  const StepperEnum({required this.title, required this.showLine, required this.isActive, required this.radius});
}

Widget stepperItem({required String title, required bool showLine, required bool isActive, required double? radius}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: isActive ? Colors.green : Colors.red,
              child: CircleAvatar(
                maxRadius: radius ?? 30,
                backgroundImage: NetworkImage(isActive
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRu_Z4iHbbb6VCIIZPLHgDNz4d5IurbrcHZ0w&usqp=CAU'
                    : 'https://cdn2.vectorstock.com/i/1000x1000/17/61/wrong-false-icon-design-template-isolated-vector-23961761.jpg'),
              ),
            ),
          ),
          showLine
              ? SizedBox(
                  height: 30,
                  width: 0,
                  child: CustomPaint(
                      size: Size(1, double.infinity),
                      painter: DashedLineVerticalPainter(color: isActive ? Colors.green : Colors.red)),
                )
              : SizedBox(),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: radius ?? 30),
        child: Text(
          title,
          style: TextStyle(color: isActive ? Colors.green : Colors.red),
        ),
      ),
    ],
  );
}
