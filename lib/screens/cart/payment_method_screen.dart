import 'package:flutter/material.dart';
import 'package:katarasa/models/cart_models.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/accordion_payment.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUI.WHITE,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: ColorUI.BLACK,
              size: 22,
            )),
        title: Text(
          "Metode Pembayaran",
          style: BLACK_TEXT_STYLE.copyWith(
              fontSize: 16, fontWeight: FontUI.WEIGHT_BOLD),
        ),
      ),
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  AccordionPayment(
                      image: "assets/icons/icon_gopay.png",
                      value: "GOPAY",
                      groupValue: methodBank,
                      onChanged: (value) {
                        setState(() {
                          methodBank = value!;
                          debugPrint(value);
                        });
                      },
                      text: "GoPay"),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showContent = !_showContent;
                      });
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 12),
                      leading: Image.asset("assets/icons/icon_tf_bank.png",
                          width: 35, height: 35, fit: BoxFit.cover),
                      minLeadingWidth: 10,
                      title: Text("Transfer Bank",
                          style: BLACK_TEXT_STYLE.copyWith(
                              fontSize: 16,
                              fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                      subtitle: Text("(Otomatis Check)",
                          style: BLACK_TEXT_STYLE.copyWith(
                              fontWeight: FontUI.WEIGHT_LIGHT)),
                      trailing: Icon(
                        // ignore: dead_code

                        _showContent
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        size: 30,
                      ),
                    ),
                  ),
                  _showContent
                      ? Column(
                          children: [
                            AccordionPayment(
                                image: "assets/icons/logo_bca.png",
                                value: "BCA",
                                groupValue: methodBank,
                                onChanged: (value) {
                                  setState(() {
                                    methodBank = value!;
                                    debugPrint(value);
                                  });
                                },
                                text: "Bank Central Asia"),
                            AccordionPayment(
                                image: "assets/icons/logo_mandiri.png",
                                value: "MANDIRI",
                                groupValue: methodBank,
                                onChanged: (value) {
                                  setState(() {
                                    methodBank = value!;
                                    debugPrint(value);
                                  });
                                },
                                text: "Bank Mandiri"),
                            AccordionPayment(
                                image: "assets/icons/logo_bni.png",
                                value: "BNI",
                                groupValue: methodBank,
                                onChanged: (value) {
                                  setState(() {
                                    methodBank = value!;
                                    debugPrint(value);
                                  });
                                },
                                text: "Bank Nasional Indonesia"),
                          ],
                        )
                      : const SizedBox(),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
