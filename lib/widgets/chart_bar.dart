import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BarChart extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentage;

  BarChart(this.label, this.spendingAmount, this.spendingPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
            SizedBox(height: constraints.maxHeight *0.05),
            Container(
              height: constraints.maxHeight *0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight *0.05,
            ),
            Container(height: constraints.maxHeight * 0.15 ,child: FittedBox(child: Text(label))),
          ],
        );
      },
    );
  }
}
