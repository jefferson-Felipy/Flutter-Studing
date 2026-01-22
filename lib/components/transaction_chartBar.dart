import 'package:flutter/material.dart';

class TransactionChartbar extends StatelessWidget {
  final double valueChart;
  final double percentage;
  final String day;

  const TransactionChartbar({
    super.key,
    required this.valueChart,
    required this.percentage,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          child: Column(
            children: [
              //Valor_
              SizedBox(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text(valueChart.toStringAsFixed(2))),
              ),

              //Barras_
              SizedBox(
                height: constraints.maxHeight * 0.7,
                width: 18,
                child: Stack(
                  alignment: AlignmentGeometry.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1),
                      ),
                    ),

                    FractionallySizedBox(
                      heightFactor: percentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Letras
              SizedBox(height: constraints.maxHeight * 0.15, child: Text(day)),
            ],
          ),
        );
      },
    );
  }
}
