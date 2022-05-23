import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtest/src/config/colors/app_colors.dart';
import 'package:techtest/src/config/text_style/app_text_style.dart';
import 'package:techtest/src/core/utils/money_format.dart';
import 'package:techtest/src/data/models/product_model.dart';
import 'package:techtest/src/presentasion/providers/cart_provicer.dart';

class CardProductWidget extends StatelessWidget {
  final ProductModel product;
  const CardProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _dataCart = Provider.of<CartProvider>(context, listen: true).dataCart;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.solidWhiteColor,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: AppColors.defaultTextColor.withOpacity(0.2),
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    product.productThumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      style: AppTextStyle.headline3,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${product.currency} ' +
                          MoneyFormatUtils.moneyFormat(
                            product.price.toInt().toString(),
                          ),
                      style: AppTextStyle.headline2.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!_dataCart.contains(product))
                  InputChip(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addCard(product: product);
                    },
                    padding: const EdgeInsets.all(8),
                    backgroundColor: AppColors.solidWhiteColor,
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add to Chart',
                          style: AppTextStyle.button.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (_dataCart.contains(product))
                  Row(
                    children: [
                      Expanded(
                        child: InputChip(
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .removeCard(product: product);
                          },
                          padding: const EdgeInsets.all(8),
                          backgroundColor: AppColors.solidWhiteColor,
                          shape: const StadiumBorder(
                            side: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '-',
                                style: AppTextStyle.headline5.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            _dataCart
                                .where((element) => element.id == product.id)
                                .length
                                .toString(),
                            style: AppTextStyle.headline3.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InputChip(
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .addCard(product: product);
                          },
                          padding: const EdgeInsets.all(8),
                          backgroundColor: AppColors.solidWhiteColor,
                          shape: const StadiumBorder(
                            side: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '+',
                                style: AppTextStyle.headline5.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
