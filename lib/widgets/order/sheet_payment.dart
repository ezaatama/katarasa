import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/order/detail_order/detail_order_cubit.dart';
import 'package:katarasa/data/payment/method/method_payment_cubit.dart';
import 'package:katarasa/data/payment/payment_token/payment_cubit.dart';
import 'package:katarasa/data/profile/data_profile/profile_cubit.dart';
import 'package:katarasa/models/payment/methode_pay_request.dart';
import 'package:katarasa/models/payment/payment_snap_before_token.dart';
import 'package:katarasa/models/payment/payment_snap_update.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/image.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/make_dismiss.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';
import 'package:katarasa/widgets/shipping/custom_expand_items.dart';

void sheetPembayaran(context, String orderId) {
  showModalBottomSheet(
      barrierColor: ColorUI.BLACK.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStater) {
          return makeDismiss(context,
              child: DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.3,
                  maxChildSize: 0.6,
                  builder: (context, controller) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: const BoxDecoration(
                          color: ColorUI.WHITE,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          )),
                      child: Stack(
                        children: [
                          ScrollConfiguration(
                            behavior: const MaterialScrollBehavior()
                                .copyWith(overscroll: false),
                            child: ListView(
                              shrinkWrap: true,
                              controller: controller,
                              primary: false,
                              children: [
                                ...notchBottomSheet("Metode Pembayaran"),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 70, left: 16, right: 16, bottom: 16),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                BlocBuilder<MethodPaymentCubit,
                                        MethodPaymentState>(
                                    builder: (context, state) {
                                  if (state is MethodPaymentLoading) {
                                    return const Center(
                                        child: LoaderIndicator());
                                  } else if (state is MethodPaymentLoaded) {
                                    return Column(
                                        children:
                                            state.methodLoaded.map((data) {
                                      return StatefulBuilder(
                                          builder: (context, setStaters) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: const BoxDecoration(
                                                color: Colors.transparent),
                                            child: CustomExpandableItem(
                                                header: Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 8),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 15),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors
                                                                .transparent),
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          data.paymentTypeLabel,
                                                          style: BLACK_TEXT_STYLE
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight: FontUI
                                                                      .WEIGHT_SEMI_BOLD),
                                                        ),
                                                        SelectMethod.selectItem ==
                                                                data
                                                                    .idPaymentMethodCategory
                                                            ? const Icon(Icons
                                                                .keyboard_arrow_down_rounded)
                                                            : const Icon(Icons
                                                                .keyboard_arrow_right_rounded)
                                                      ],
                                                    )),
                                                expandedChild: BlocBuilder<
                                                        DetailOrderCubit,
                                                        DetailOrderState>(
                                                    builder: (context, state) {
                                                  if (state
                                                      is DetailOrderLoaded) {
                                                    final grandTotal = state
                                                        .detailOrderLoaded
                                                        .total;
                                                    final paymentId = state
                                                        .detailOrderLoaded
                                                        .orderPaymentRecent
                                                        .paymentId;

                                                    return BlocBuilder<
                                                        ProfileCubit,
                                                        ProfileState>(
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is ProfileLoaded) {
                                                          final email = state
                                                              .dataProfile
                                                              .email;
                                                          final name = state
                                                              .dataProfile.name;
                                                          return Column(
                                                            children: data
                                                                .subPayment
                                                                .map((subPay) {
                                                              return BlocConsumer<
                                                                      PaymentCubit,
                                                                      PaymentState>(
                                                                  listener:
                                                                      (context,
                                                                          state) {
                                                                if (state
                                                                    is PaymentSnapSuccess) {
                                                                  SelectMethod
                                                                          .tokenPayment =
                                                                      state
                                                                          .paySnapSuccess
                                                                          .token;

                                                                  navigateToRedirectUrl(state
                                                                          .paySnapSuccess
                                                                          .redirectUrl)
                                                                      .then(
                                                                          (value) {
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                } else if (state
                                                                    is PaymentSnapError) {
                                                                  showToast(
                                                                      text: state
                                                                          .errPaySnap,
                                                                      state: ToastStates
                                                                          .ERROR);
                                                                }
                                                              }, builder:
                                                                      (context,
                                                                          state) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (SelectMethod
                                                                            .selectSubPay ==
                                                                        subPay
                                                                            .paymentSub) {
                                                                      SelectMethod
                                                                              .selectSubPay =
                                                                          "no select";
                                                                    } else {
                                                                      SelectMethod
                                                                              .selectSubPay =
                                                                          subPay
                                                                              .paymentSub;
                                                                      SelectMethod
                                                                              .selectSubPayLabel =
                                                                          subPay
                                                                              .paymentSubLabel;
                                                                      SelectMethod
                                                                              .selectSubPayType =
                                                                          subPay
                                                                              .paymentType;
                                                                      SelectMethod
                                                                              .selectSubPayFee =
                                                                          subPay
                                                                              .fee
                                                                              .toString();
                                                                      SelectMethod
                                                                              .selectSubPayForm =
                                                                          subPay
                                                                              .paymentForm;
                                                                      PaySnapBeforeToken payload = PaySnapBeforeToken(
                                                                          email:
                                                                              email,
                                                                          name:
                                                                              name,
                                                                          paymentSub: SelectMethod
                                                                              .selectSubPay,
                                                                          grandTotal:
                                                                              grandTotal,
                                                                          paymentId:
                                                                              paymentId);
                                                                      context.read<PaymentCubit>().postPaySnapToken(
                                                                          context,
                                                                          payload,
                                                                          orderId,
                                                                          "1");
                                                                    }
                                                                    setStater(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            10),
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            25,
                                                                        right:
                                                                            15),
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              8),
                                                                      decoration: SelectMethod.selectSubPay ==
                                                                              subPay
                                                                                  .paymentSub
                                                                          ? BoxDecoration(
                                                                              color: ColorUI.BROWN.withOpacity(.20),
                                                                              border: Border.all(color: ColorUI.BROWN, width: 1),
                                                                              borderRadius: BorderRadius.circular(10))
                                                                          : null,
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Text(
                                                                              subPay.paymentSubLabel,
                                                                              style: BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_MEDIUM),
                                                                            ),
                                                                          ),
                                                                          //gambar pakai dummy karna error dari API
                                                                          StdImage(
                                                                              imageUrl: "https://img2.pngdownload.id/20180402/vww/kisspng-payment-paysafe-group-plc-credit-card-information-payment-5ac209b87fc258.7604918915226659125233.jpg",
                                                                              // subPay.icon,
                                                                              fit: BoxFit.contain,
                                                                              width: MediaQuery.of(context).size.width * .150,
                                                                              height: MediaQuery.of(context).size.height * .040),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                            }).toList(),
                                                          );
                                                        }
                                                        return const SizedBox();
                                                      },
                                                    );
                                                  }
                                                  return const SizedBox();
                                                }),
                                                isExpanded: SelectMethod
                                                        .selectItem ==
                                                    data.idPaymentMethodCategory,
                                                onTap: () {
                                                  setStater(() {
                                                    if (SelectMethod
                                                            .selectItem ==
                                                        data.idPaymentMethodCategory) {
                                                      SelectMethod.selectItem =
                                                          "no select";
                                                    } else {
                                                      SelectMethod.selectItem =
                                                          data.idPaymentMethodCategory;
                                                      SelectMethod
                                                              .selectPayType =
                                                          data.paymentType;
                                                      SelectMethod
                                                              .selectPayTypeLabel =
                                                          data.paymentTypeLabel;
                                                    }
                                                  });
                                                }));
                                      });
                                    }).toList());
                                  }
                                  return const SizedBox();
                                })
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }));
        });
      });
}

void sheetPembayaranUpdate(context, String orderId) {
  showModalBottomSheet(
      barrierColor: ColorUI.BLACK.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStater) {
          return makeDismiss(context,
              child: DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.3,
                  maxChildSize: 0.6,
                  builder: (context, controller) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: const BoxDecoration(
                          color: ColorUI.WHITE,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          )),
                      child: Stack(
                        children: [
                          ScrollConfiguration(
                            behavior: const MaterialScrollBehavior()
                                .copyWith(overscroll: false),
                            child: ListView(
                              shrinkWrap: true,
                              controller: controller,
                              primary: false,
                              children: [
                                ...notchBottomSheet("Metode Pembayaran"),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 70, left: 16, right: 16, bottom: 16),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                BlocBuilder<MethodPaymentCubit,
                                        MethodPaymentState>(
                                    builder: (context, state) {
                                  if (state is MethodPaymentLoading) {
                                    return const Center(
                                        child: LoaderIndicator());
                                  } else if (state is MethodPaymentLoaded) {
                                    return Column(
                                        children:
                                            state.methodLoaded.map((data) {
                                      return StatefulBuilder(
                                          builder: (context, setStaters) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: const BoxDecoration(
                                                color: Colors.transparent),
                                            child: CustomExpandableItem(
                                                header: Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 8),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 15),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors
                                                                .transparent),
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          data.paymentTypeLabel,
                                                          style: BLACK_TEXT_STYLE
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight: FontUI
                                                                      .WEIGHT_SEMI_BOLD),
                                                        ),
                                                        SelectMethod.selectItem ==
                                                                data
                                                                    .idPaymentMethodCategory
                                                            ? const Icon(Icons
                                                                .keyboard_arrow_down_rounded)
                                                            : const Icon(Icons
                                                                .keyboard_arrow_right_rounded)
                                                      ],
                                                    )),
                                                expandedChild: BlocBuilder<
                                                        DetailOrderCubit,
                                                        DetailOrderState>(
                                                    builder: (context, state) {
                                                  if (state
                                                      is DetailOrderLoaded) {
                                                    final items = state
                                                        .detailOrderLoaded
                                                        .items;
                                                    final grandTotal = state
                                                        .detailOrderLoaded
                                                        .total;

                                                    return ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: items.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Column(
                                                            children: data
                                                                .subPayment
                                                                .map((subPay) {
                                                              return BlocConsumer<
                                                                      PaymentCubit,
                                                                      PaymentState>(
                                                                  listener:
                                                                      (context,
                                                                          state) {
                                                                if (state
                                                                    is PaymentSnapUpdateSuccess) {
                                                                  SelectMethod
                                                                          .tokenPayment =
                                                                      state
                                                                          .paySnapUpdSuccess
                                                                          .token;
                                                                  Navigator.pop(
                                                                      context);
                                                                } else if (state
                                                                    is PaymentSnapUpdateError) {
                                                                  showToast(
                                                                      text: state
                                                                          .errUpdPaySnap,
                                                                      state: ToastStates
                                                                          .ERROR);
                                                                }
                                                              }, builder:
                                                                      (context,
                                                                          state) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (SelectMethod
                                                                            .selectSubPay ==
                                                                        subPay
                                                                            .paymentSub) {
                                                                      SelectMethod
                                                                              .selectSubPay =
                                                                          "no select";
                                                                    } else {
                                                                      SelectMethod
                                                                              .selectSubPay =
                                                                          subPay
                                                                              .paymentSub;
                                                                      SelectMethod
                                                                              .selectSubPayLabel =
                                                                          subPay
                                                                              .paymentSubLabel;
                                                                      SelectMethod
                                                                              .selectSubPayType =
                                                                          subPay
                                                                              .paymentType;
                                                                      SelectMethod
                                                                              .selectSubPayFee =
                                                                          subPay
                                                                              .fee
                                                                              .toString();
                                                                      SelectMethod
                                                                              .selectSubPayForm =
                                                                          subPay
                                                                              .paymentForm;

                                                                      PaySnapUpdateData payload = PaySnapUpdateData(
                                                                          paymentFee: SelectMethod
                                                                              .selectSubPayFee,
                                                                          paymentForm: SelectMethod
                                                                              .selectSubPayForm,
                                                                          paymentSub: SelectMethod
                                                                              .selectSubPay,
                                                                          paymentSubLabel: SelectMethod
                                                                              .selectSubPayLabel,
                                                                          paymentType: SelectMethod
                                                                              .selectPayType,
                                                                          paymentTypeLabel: SelectMethod
                                                                              .selectPayTypeLabel,
                                                                          fee: SelectMethod
                                                                              .selectSubPayFee,
                                                                          idInvoice: items[index]
                                                                              .id,
                                                                          orderCode:
                                                                              "",
                                                                          orderId:
                                                                              orderId,
                                                                          token: SelectMethod
                                                                              .tokenPayment,
                                                                          totalPembayaran:
                                                                              grandTotal);

                                                                      context
                                                                          .read<
                                                                              PaymentCubit>()
                                                                          .postPaySnapUpdate(
                                                                              context,
                                                                              payload);
                                                                    }
                                                                    setStater(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            10),
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            25,
                                                                        right:
                                                                            15),
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              8),
                                                                      decoration: SelectMethod.selectSubPay ==
                                                                              subPay
                                                                                  .paymentSub
                                                                          ? BoxDecoration(
                                                                              color: ColorUI.BROWN.withOpacity(.20),
                                                                              border: Border.all(color: ColorUI.BROWN, width: 1),
                                                                              borderRadius: BorderRadius.circular(10))
                                                                          : null,
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Text(
                                                                              subPay.paymentSubLabel,
                                                                              style: BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_MEDIUM),
                                                                            ),
                                                                          ),
                                                                          //gambar pakai dummy karna error dari API
                                                                          StdImage(
                                                                              imageUrl: "https://img2.pngdownload.id/20180402/vww/kisspng-payment-paysafe-group-plc-credit-card-information-payment-5ac209b87fc258.7604918915226659125233.jpg",
                                                                              // subPay.icon,
                                                                              fit: BoxFit.contain,
                                                                              width: MediaQuery.of(context).size.width * .150,
                                                                              height: MediaQuery.of(context).size.height * .040),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                            }).toList(),
                                                          );
                                                        });
                                                  }
                                                  return const SizedBox();
                                                }),
                                                isExpanded: SelectMethod
                                                        .selectItem ==
                                                    data.idPaymentMethodCategory,
                                                onTap: () {
                                                  setStater(() {
                                                    if (SelectMethod
                                                            .selectItem ==
                                                        data.idPaymentMethodCategory) {
                                                      SelectMethod.selectItem =
                                                          "no select";
                                                    } else {
                                                      SelectMethod.selectItem =
                                                          data.idPaymentMethodCategory;
                                                      SelectMethod
                                                              .selectPayType =
                                                          data.paymentType;
                                                      SelectMethod
                                                              .selectPayTypeLabel =
                                                          data.paymentTypeLabel;
                                                    }
                                                  });
                                                }));
                                      });
                                    }).toList());
                                  }
                                  return const SizedBox();
                                })
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }));
        });
      });
}
