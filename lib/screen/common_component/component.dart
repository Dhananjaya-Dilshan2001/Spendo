import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendo/core/bloc/bloc/user_bloc.dart';
import 'package:spendo/screen/color&theme.dart';

class MyWidget1 extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final double amountFontSize;
  const MyWidget1({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.amountFontSize,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(fontSize: width * 0.03, color: color)),
        Text(
          amount,
          style: TextStyle(
            fontSize: amountFontSize,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class MyWidget2 extends StatefulWidget {
  final String title;
  final Color color;
  final double amountFontSize;
  final bool switchValue;
  final VoidCallback? onChanged;

  const MyWidget2({
    super.key,
    required this.title,
    required this.color,
    required this.amountFontSize,
    required this.switchValue,
    this.onChanged,
  });

  @override
  State<MyWidget2> createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Switch(
          value: widget.switchValue,
          onChanged: (bool value) {
            setState(() {
              widget.onChanged?.call();
            });
          },
          activeColor: widget.color,
        ),
        Text(
          widget.title,
          style: TextStyle(fontSize: width * 0.03, color: widget.color),
        ),
      ],
    );
  }
}

class MyDropdownButton extends StatefulWidget {
  final bool isCategory;
  final VoidCallback? onChanged;
  final List<String> items;
  const MyDropdownButton({
    super.key,
    required this.items,
    this.onChanged,
    required this.isCategory,
  });

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  late String dropdownValue;
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return DropdownButton<String>(
            menuWidth: width * 0.3,
            menuMaxHeight: width * 0.5,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            selectedItemBuilder:
                (context) =>
                    widget.items
                        .map(
                          (e) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.color5,
                              border: Border.all(color: AppColors.color1),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              e,
                              style: const TextStyle(
                                color: AppColors.color1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                        .toList(),
            value: dropdownValue,
            borderRadius: BorderRadius.circular(8),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(height: 1, color: Colors.deepPurpleAccent),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;

                if (widget.isCategory) {
                  state.setDisplayedTransactionByCategory(dropdownValue);
                } else {
                  state.displayTransactionListAccordingState(dropdownValue);
                }
                widget.onChanged?.call();
              });
            },
            dropdownColor: AppColors.color5,
            items:
                widget.items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }).toList(),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
