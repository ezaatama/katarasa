import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

showActionDialog(BuildContext context,
    {required String title,
    required Function() tapBatalkan,
    required Function() tapTidakBatal}) {
  return showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: ColorUI.BLACK.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
            scale: Tween<double>(end: 1.0, begin: 0).animate(CurvedAnimation(
                parent: animation,
                curve: const Interval(0.00, 0.50, curve: Curves.linear))),
            child: child);
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return ActionDialog(
            title: title,
            tapBatalkanTransaksi: tapBatalkan,
            tapTidakBatal: tapTidakBatal);
      });
}

class ActionDialog extends StatelessWidget {
  const ActionDialog(
      {Key? key,
      required this.title,
      required this.tapBatalkanTransaksi,
      required this.tapTidakBatal})
      : super(key: key);
  final String title;
  final Function() tapBatalkanTransaksi;
  final Function() tapTidakBatal;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(true),
        child: Dialog(
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(24, 20, 20, 40),
                decoration: BoxDecoration(
                    color: ColorUI.WHITE,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(title,
                        textAlign: TextAlign.center,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontSize: 16,
                            fontWeight: FontUI.WEIGHT_LIGHT,
                            color: ColorUI.BLACK.withOpacity(0.80))),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: tapBatalkanTransaksi,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ColorUI.WHITE,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ColorUI.GREY.withOpacity(.30)),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          child: Text(
                            'Hapus',
                            textAlign: TextAlign.center,
                            style: RED_TEXT_STYLE.copyWith(
                              fontSize: 14,
                              fontWeight: FontUI.WEIGHT_MEDIUM,
                              letterSpacing: 1.15,
                            ),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: tapTidakBatal,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ColorUI.WHITE,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ColorUI.GREY.withOpacity(.30)),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          child: Text(
                            'Tidak',
                            style: BLACK_TEXT_STYLE.copyWith(
                              fontSize: 14,
                              fontWeight: FontUI.WEIGHT_MEDIUM,
                              letterSpacing: 1.15,
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
