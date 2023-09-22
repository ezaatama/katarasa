import 'package:flutter/material.dart';
import 'package:katarasa/models/checkout/shipping_request.dart';

class DataShipping extends StatefulWidget {
  DataShipping({
    super.key,
    // required this.value,
    // required this.groupValue,
    // this.onChanged,
    required this.shipping,
  });

  // String value;
  // String groupValue;
  // void Function(dynamic)? onChanged;
  final Shipping shipping;

  @override
  State<DataShipping> createState() => _DataShippingState();
}

class _DataShippingState extends State<DataShipping> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setStater) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Colors.transparent),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: widget.shipping.items.map((e) {
            return Column(
              children: [
                ListTile(
                  title: Text(e.code),
                  trailing: IconButton(
                    icon: Icon(_showContent
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                    onPressed: () {
                      setState(() {
                        _showContent = !_showContent;
                      });
                    },
                  ),
                ),
                _showContent
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: Text("Type Code"),
                      )
                    : Container()
              ],
            );
          }).toList(),
        ),
      );
    });
  }
}
