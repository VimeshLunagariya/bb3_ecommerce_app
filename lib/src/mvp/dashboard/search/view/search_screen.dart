import 'dart:async';

import 'package:bb3_ecommerce_app/src/mvp/dashboard/search/view/filter_bottom_sheet.dart';
import 'package:bb3_ecommerce_app/src/widget/custom/search_product_list_shimmer_widget.dart';
import 'package:bb3_ecommerce_app/src/widget/widget.dart';
import 'package:bb3_ecommerce_app/utilities/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider/search_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
  // Timer to debounce search input.
  Timer? _debounce;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final searchProvider = Provider.of<SearchProvider>(context, listen: false);
      searchProvider.reSetDataForSearchScreen();

      // Add a listener to load more data when reaching the bottom of the list.
      scrollController.addListener(() async {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          searchProvider.callSearchCardApi(context);
        }
      });
    });
  }

  @override
  void dispose() {
    // Cancel the debounce timer to avoid memory leaks
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanDown: (tap) {
          print("object");
          if (Core.isKeyboardOpen(context)) {
            Core.hideKeyBoard();
          }
        },
        child: Consumer<SearchProvider>(builder: (_, SearchProvider searchProvider, __) {
          return Stack(
            children: [
              // AppBar BG
              Container(color: const Color(0XFFD8407D), height: 100),
              Stack(
                children: [
                  SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        // SearchBar Widget
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              // BackArrow Button Widget
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back, color: VariableUtilities.theme.whiteColor, size: 25)),
                              const SizedBox(width: 5),
                              // SearchBar
                              Expanded(
                                child: SearchInputField(
                                  onChanged: (text) {
                                    if (searchProvider.searchValue != text) {
                                      if (_debounce?.isActive ?? false) {
                                        _debounce?.cancel();
                                      }

                                      _debounce = Timer(const Duration(milliseconds: 500), () {
                                        if (text.length >= 2) {
                                          searchProvider.isFetchingFromAPI = true;
                                          searchProvider.callSearchCardApi(context);
                                        } else {
                                          searchProvider.isFetchingFromAPI = false;
                                        }
                                      });
                                    }
                                  },
                                  suffixIcon: searchProvider.searchTextController.text.isNotEmpty
                                      ? GestureDetector(
                                          onTap: () {
                                            if (searchProvider.isFetchingFromAPI) {
                                              searchProvider.isFetchingFromAPI = false;
                                              searchProvider.searchTextController.clear();
                                            }
                                          },
                                          child: Icon(
                                            Icons.cancel,
                                            color: VariableUtilities.theme.color7C7C7C,
                                          ),
                                        )
                                      : const SizedBox(),
                                  searchController: searchProvider.searchTextController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        (searchProvider.searchCardData.isLeft)
                            ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Search Results',
                                        style: FontUtilities.h14(fontColor: Colors.black, fontWeight: FWT.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(text: '${searchProvider.searchCardData.left.data!.products?.length} Result for ', style: FontUtilities.h10(fontColor: Colors.grey), children: [
                                          TextSpan(
                                            text: '''"${searchProvider.searchTextController.text}"''',
                                            style: FontUtilities.h10(fontColor: Colors.black, fontWeight: FWT.semiBold),
                                          ),
                                        ]),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Filter Button
                                    searchProvider.searchTextController.text.isEmpty
                                        ? const SizedBox()
                                        : SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (searchProvider.searchTextController.text.length >= 2) {
                                                      if (Core.isKeyboardOpen(context)) {
                                                        Core.hideKeyBoard();
                                                      }
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return const FilterBottomSheetWidget();
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: const CircleAvatar(backgroundColor: Colors.black, child: Icon(Icons.filter_list_rounded, color: Colors.white, size: 25)),
                                                ),
                                                const SizedBox(width: 5),
                                                InputChip(
                                                  label: Text('SortBy', style: FontUtilities.h10()),
                                                  deleteIcon: const Icon(Icons.arrow_drop_down_rounded),
                                                  onPressed: () {
                                                    searchProvider.filterSelctionName = 'sortBy';
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return const FilterBottomSheetWidget();
                                                      },
                                                    );
                                                  },
                                                  onDeleted: () {},
                                                ),
                                                const SizedBox(width: 5),
                                                InputChip(
                                                  label: Text('Rating', style: FontUtilities.h10()),
                                                  deleteIcon: const Icon(Icons.arrow_drop_down_rounded),
                                                  onPressed: () {
                                                    searchProvider.filterSelctionName = 'rating';
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return const FilterBottomSheetWidget();
                                                      },
                                                    );
                                                  },
                                                  onDeleted: () {},
                                                ),
                                                const SizedBox(width: 5),
                                                InputChip(
                                                  label: Text('Brand', style: FontUtilities.h10()),
                                                  deleteIcon: const Icon(Icons.arrow_drop_down_rounded),
                                                  onPressed: () {
                                                    searchProvider.filterSelctionName = 'brand';
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return const FilterBottomSheetWidget();
                                                      },
                                                    );
                                                  },
                                                  onDeleted: () {},
                                                ),
                                                const SizedBox(width: 5),
                                                InputChip(
                                                  label: Text('Price Range', style: FontUtilities.h10()),
                                                  deleteIcon: const Icon(Icons.arrow_drop_down_rounded),
                                                  onPressed: () {
                                                    searchProvider.filterSelctionName = 'price_range';
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return const FilterBottomSheetWidget();
                                                      },
                                                    );
                                                  },
                                                  onDeleted: () {},
                                                ),
                                                const SizedBox(width: 5),
                                                SizedBox(
                                                  width: 450,
                                                  height: 30,
                                                  child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: searchProvider.searchCardData.left.data!.attributes?.length,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      return Padding(
                                                        padding: const EdgeInsets.only(left: 8),
                                                        child: InputChip(
                                                          label: Text(searchProvider.searchCardData.left.data!.attributes![index].title ?? '', style: FontUtilities.h10()),
                                                          deleteIcon: const Icon(Icons.arrow_drop_down_rounded),
                                                          onPressed: () {
                                                            searchProvider.filterSelctionName = searchProvider.searchCardData.left.data!.attributes![index].code ?? '';
                                                            showModalBottomSheet(
                                                              context: context,
                                                              builder: (builder) {
                                                                return const FilterBottomSheetWidget();
                                                              },
                                                            );
                                                          },
                                                          onDeleted: () {},
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              )
                            : const SizedBox(),

                        /////////
                        searchProvider.searchTextController.text.isEmpty
                            ? Column(
                                children: [
                                  const SizedBox(height: 30),
                                  // Placeholder text when the search bar is empty
                                  Text(
                                    'Search for "Routines", "Brands", "Skin Care", ETC...',
                                    style: FontUtilities.h10(fontWeight: FWT.medium),
                                  ),
                                ],
                              )
                            : searchProvider.searchCardData.isLeft
                                ? searchProvider.searchCardData.left.data!.products!.isEmpty
                                    ? Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // Display message if no products are found for the search term
                                            Text(
                                              'No Product Found For This Search!',
                                              style: FontUtilities.h10(fontWeight: FWT.semiBold),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                          child: SingleChildScrollView(
                                            // Scroll controller for dynamic scrolling
                                            controller: scrollController,
                                            child: Column(
                                              children: [
                                                GridView.builder(
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 0.65,
                                                    crossAxisSpacing: 8,
                                                    mainAxisSpacing: 8,
                                                  ),
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: searchProvider.searchCardData.left.data!.products!.length,
                                                  itemBuilder: (context, index) {
                                                    var reviews = searchProvider.searchCardData.left.data!.products![index].reviews;

                                                    // Calculate the average rating of the product
                                                    double averageRating = 0.0;

                                                    if (reviews != null && reviews.isNotEmpty) {
                                                      averageRating = reviews
                                                              // Extract ratings
                                                              .map((e) => e.rating!)
                                                              .reduce((a, b) => a + b) /
                                                          // Calculate sum and divide by count
                                                          reviews.length;
                                                    } else {
                                                      // Set default value if there are no reviews
                                                      averageRating = 0.0;
                                                    }

                                                    // Grid item widget
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black.withOpacity(0.10)),
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 6),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Expanded(
                                                              // Image takes 2 parts of the space
                                                              flex: 2,
                                                              child: CachedNetworkImage(
                                                                imageUrl: '${AssetUtilities.liveImageUrlPrefix}${searchProvider.searchCardData.left.data!.products![index].thumbnail!}',
                                                                fit: BoxFit.cover,
                                                                placeholder: (_, __) {
                                                                  // Placeholder widget while the image is loading
                                                                  return Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Image.asset(AssetUtilities.logoPng, height: 100, width: 100),
                                                                    ],
                                                                  );
                                                                },
                                                                errorWidget: (_, __, ___) {
                                                                  // Fallback widget if the image fails to load
                                                                  return const Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [Icon(Icons.error, color: Colors.black54)],
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            const SizedBox(height: 10),
                                                            Expanded(
                                                              // Product details take 2 parts of the space
                                                              flex: 2,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  const SizedBox(height: 10),
                                                                  // Product title
                                                                  Text(
                                                                    searchProvider.searchCardData.left.data!.products![index].title ?? 'Unknown Product',
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: FontUtilities.h12(fontWeight: FWT.medium),
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  // Rating widget
                                                                  RatingStars(
                                                                    axis: Axis.horizontal,
                                                                    value: averageRating,
                                                                    onValueChanged: (v) {},
                                                                    starCount: 5,
                                                                    starSize: 20,
                                                                    valueLabelRadius: 10,
                                                                    maxValue: 5,
                                                                    starSpacing: 2,
                                                                    maxValueVisibility: true,
                                                                    valueLabelVisibility: false,
                                                                    animationDuration: const Duration(milliseconds: 1000),
                                                                    valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                                                                    valueLabelMargin: const EdgeInsets.only(right: 8),
                                                                    starOffColor: const Color(0xffe7e8ea),
                                                                    starColor: Colors.amber,
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  // Product price
                                                                  Text(
                                                                    'Rs. ${searchProvider.searchCardData.left.data!.products![index].priceStart}',
                                                                    style: FontUtilities.h13(fontWeight: FWT.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                // Loading indicator for infinite scroll
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Visibility(
                                                      visible: searchProvider.isVisibleLoadingIndicator,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(height: 20),
                                                          CircularProgressIndicator(color: VariableUtilities.theme.primaryColor),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 70),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                : searchProvider.isVisibleLoadingIndicator
                                    ? Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          // Placeholder for shimmer effect
                                          child: GridView.builder(
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.65,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 8,
                                            ),
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: 6,
                                            itemBuilder: (context, index) {
                                              return const Padding(
                                                padding: EdgeInsets.only(bottom: 8),
                                                // Shimmer effect widget
                                                child: SearchProductListShimmerEffect(),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          const SizedBox(height: 30),
                                          // Display message when no products match the search keyword
                                          Text(
                                            'No products found!',
                                            textAlign: TextAlign.center,
                                            style: FontUtilities.h10(fontWeight: FWT.medium),
                                          ),
                                          Text(
                                            'for the keyword: "${searchProvider.searchTextController.text}"',
                                            textAlign: TextAlign.center,
                                            style: FontUtilities.h12(fontWeight: FWT.semiBold, fontColor: Colors.grey),
                                          ),
                                        ],
                                      ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
