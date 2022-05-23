import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:techtest/src/config/colors/app_colors.dart';
import 'package:techtest/src/config/text_style/app_text_style.dart';
import 'package:techtest/src/core/utils/money_format.dart';
import 'package:techtest/src/presentasion/providers/auth_provider.dart';
import 'package:techtest/src/presentasion/providers/cart_provicer.dart';
import 'package:techtest/src/presentasion/providers/product_provider.dart';
import 'package:techtest/src/presentasion/screens/category/category_screen.dart';
import 'package:techtest/src/presentasion/screens/login/login_screen.dart';
import 'package:techtest/src/presentasion/widgets/card_product_widget.dart';
import 'package:techtest/src/presentasion/widgets/frame_widget.dart';
import 'package:techtest/src/presentasion/widgets/input_text_widget.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrameWidget(
      child: Column(
        children: const [
          _HomeHeader(),
          Expanded(child: _HomeGridProduct()),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatefulWidget {
  const _HomeHeader({Key? key}) : super(key: key);

  @override
  State<_HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<_HomeHeader> {
  final _searchController = TextEditingController();

  void _doSelectCategory({required BuildContext context}) async {
    var _callback =
        await Navigator.of(context).pushNamed(CategoryScreen.routeName);
    if (_callback != null && _callback is String) {
      Provider.of<ProductProvider>(context, listen: false).search(
        keyword: _callback,
        isSearch: false,
      );
    }
  }

  void _doSearch({required BuildContext context, required String keyword}) {
    Provider.of<ProductProvider>(context, listen: false).search(
      keyword: keyword,
      isSearch: true,
    );
  }

  void _resetSearch({required BuildContext context}) {
    Provider.of<ProductProvider>(context, listen: false).search(
      keyword: '',
      isSearch: false,
    );
  }

  void _resetSearchController({required BuildContext context}) {
    setState(() {
      _searchController.text = '';
    });
    Provider.of<ProductProvider>(context, listen: false).search(
      keyword: '',
      isSearch: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _activeKeyword =
        Provider.of<ProductProvider>(context, listen: true).activeKeyword;
    var _isSearch =
        Provider.of<ProductProvider>(context, listen: true).isActiveSearch;
    return Padding(
      padding: EdgeInsets.all(_isSearch ? 4 : 16),
      child: Column(
        children: [
          if (!_isSearch)
            Row(
              children: [
                Expanded(
                  child: Text(
                    _activeKeyword != '' ? _activeKeyword : 'All Products',
                    style: AppTextStyle.headline1.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _doSearch(context: context, keyword: '');
                      },
                      child: const Icon(
                        CupertinoIcons.search,
                        size: 32,
                        color: AppColors.defaultTextColor,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        _doSelectCategory(context: context);
                      },
                      child: const Icon(
                        CupertinoIcons.square_grid_2x2,
                        color: AppColors.defaultTextColor,
                        size: 32,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: const Icon(
                        CupertinoIcons.person_crop_circle,
                        size: 32,
                        color: AppColors.defaultTextColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          if (_isSearch)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _resetSearch(context: context);
                    },
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      color: AppColors.defaultTextColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        InputTextWidget(
                          controller: _searchController,
                          isBorder: true,
                          hintText: 'Search Products',
                          icon: CupertinoIcons.search,
                          iconSize: 24,
                          onChange: (value) {
                            if (value != '') {
                              _doSearch(context: context, keyword: value);
                            }
                          },
                        ),
                        if (_searchController.text != '')
                          Positioned.fill(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _resetSearchController(context: context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      CupertinoIcons.clear_circled_solid,
                                      size: 24,
                                      color: AppColors.defaultTextColor
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _HomeGridProduct extends StatefulWidget {
  const _HomeGridProduct({Key? key}) : super(key: key);

  @override
  State<_HomeGridProduct> createState() => _HomeGridProductState();
}

class _HomeGridProductState extends State<_HomeGridProduct> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var _dataCart = Provider.of<CartProvider>(context, listen: true).dataCart;
    var _dataProduct =
        Provider.of<ProductProvider>(context, listen: true).dataProduct;
    return Stack(
      children: [
        AlignedGridView.count(
          padding: EdgeInsets.fromLTRB(
              16, 16, 16, MediaQuery.of(context).padding.bottom + 72 + 24),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          itemBuilder: (context, i) =>
              CardProductWidget(product: _dataProduct[i]),
          itemCount: _dataProduct.length,
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_dataCart.isNotEmpty)
                Container(
                  color: AppColors.solidWhiteColor.withOpacity(0.9),
                  padding: EdgeInsets.fromLTRB(
                      16, 0, 16, MediaQuery.of(context).padding.bottom + 24),
                  child: GestureDetector(
                    onTap: () {
                      if (!Provider.of<AuthProvider>(context, listen: false)
                          .isAuthValidate) {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          'Buy ${_dataCart.length} Items - ${Provider.of<CartProvider>(context, listen: true).currency} ' +
                              MoneyFormatUtils.moneyFormat(
                                Provider.of<CartProvider>(context, listen: true)
                                    .totalPrice
                                    .toInt()
                                    .toString(),
                              ),
                          style: AppTextStyle.headline4.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.solidWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
