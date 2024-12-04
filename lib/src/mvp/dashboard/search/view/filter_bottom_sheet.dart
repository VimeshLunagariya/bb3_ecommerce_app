import 'package:bb3_ecommerce_app/src/mvp/dashboard/search/model/price_range_model.dart';
import 'package:bb3_ecommerce_app/src/mvp/dashboard/search/provider/search_provider.dart';
import 'package:bb3_ecommerce_app/src/mvp/dashboard/search/view/filter_bottom_sheet_side_view_widget.dart';
import 'package:bb3_ecommerce_app/src/widget/widget.dart';
import 'package:bb3_ecommerce_app/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../utilities/settings/settings.dart';

class FilterBottomSheetWidget extends StatelessWidget {
  const FilterBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (_, SearchProvider searchProvider, __) {
      return Container(
        decoration: BoxDecoration(color: VariableUtilities.theme.whiteColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
        child: SafeArea(
          bottom: true,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filters",
                      style: FontUtilities.h10(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.semiBold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Close",
                        style: FontUtilities.h10(fontColor: VariableUtilities.theme.blackColor.withOpacity(0.6), fontWeight: FWT.semiBold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 1,
                decoration: BoxDecoration(color: VariableUtilities.theme.blackColor.withOpacity(0.1)),
              ),
              searchProvider.searchCardData.isLeft
                  ? Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // A scrollable view containing various filter options
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Widget for the 'Rating' filter option
                                FilterBottomSheetSideViewWidget(
                                  title: 'Rating',
                                  isTabSelect: searchProvider.filterSelctionName == 'rating',
                                  onTap: () {
                                    // Update the selected filter to 'rating'
                                    searchProvider.filterSelctionName = 'rating';
                                  },
                                ),
                                // Conditional rendering for the 'Brand' filter option
                                searchProvider.searchCardData.isLeft && searchProvider.searchCardData.left.data!.brands!.isNotEmpty
                                    ? FilterBottomSheetSideViewWidget(
                                        title: 'Brand',
                                        isTabSelect: searchProvider.filterSelctionName == 'brand',
                                        onTap: () {
                                          // Update the selected filter to 'brand'
                                          searchProvider.filterSelctionName = 'brand';
                                        },
                                      )
                                    : const SizedBox(),
                                // A list of attributes rendered dynamically
                                SizedBox(
                                  width: VariableUtilities.screenSize.width * 0.30,
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: searchProvider.searchCardData.left.data!.attributes!.length,
                                    itemBuilder: (context, index) {
                                      return FilterBottomSheetSideViewWidget(
                                        title: searchProvider.searchCardData.left.data!.attributes![index].title ?? 'Unknown',
                                        isTabSelect: searchProvider.filterSelctionName == (searchProvider.searchCardData.left.data!.attributes![index].code ?? '$index'),
                                        onTap: () {
                                          // Update the selected filter to the current attribute's code
                                          searchProvider.filterSelctionName = searchProvider.searchCardData.left.data!.attributes![index].code ?? '$index';
                                        },
                                      );
                                    },
                                  ),
                                ),
                                // Widget for the 'Price Range' filter option
                                FilterBottomSheetSideViewWidget(
                                  title: 'Price Range',
                                  isTabSelect: searchProvider.filterSelctionName == 'price_range',
                                  onTap: () {
                                    // Update the selected filter to 'price_range'
                                    searchProvider.filterSelctionName = 'price_range';
                                  },
                                ),
                              ],
                            ),
                          ),

                          searchProvider.filterSelctionName == 'rating'
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                    child: Theme(
                                      // Setting a custom theme for radio buttons
                                      data: ThemeData(radioTheme: RadioThemeData(fillColor: WidgetStatePropertyAll(VariableUtilities.theme.blackColor))),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            // Title for the rating section
                                            Text(
                                              'Rating',
                                              style: FontUtilities.h12(
                                                fontColor: VariableUtilities.theme.blackColor,
                                                fontWeight: FWT.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            // ListView for rendering rating options
                                            ListView.builder(
                                                itemCount: searchProvider.searchCardData.left.data!.ratingsCounts!.length - 1,
                                                shrinkWrap: true,
                                                reverse: true,
                                                itemBuilder: (context, index) {
                                                  return RadioMenuButton(
                                                      // Dynamically set the selected rating value
                                                      value: searchProvider.selectRatingValue == index ? 1 : 0,
                                                      groupValue: 1,
                                                      onChanged: (int? value) {
                                                        searchProvider.selectRatingValue = index;
                                                      },
                                                      // Display the star rating dynamically
                                                      child: Text(fetchRatingStars(searchProvider.searchCardData.left.data!.ratingsCounts!.keys.elementAt(index),
                                                          searchProvider.searchCardData.left.data!.ratingsCounts!["${index + 1}"]!)));
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              // Placeholder for brand filter details
                              : searchProvider.filterSelctionName == 'brand'
                                  ? searchProvider.searchCardData.isLeft
                                      ? Expanded(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                // Input field for searching brands
                                                SearchInputField(
                                                  autoFocus: false,
                                                  onChanged: (text) {
                                                    // Trigger search logic if the text changes
                                                    if (searchProvider.searchBrandValue != text) {
                                                      if (text.length >= 2) {
                                                        // Call the search function when the input is at least 2 characters long
                                                        searchProvider.searchBrand(searchProvider.brandSearchTextController.text);
                                                      }
                                                    }
                                                    // Clear search results and input if the text is empty
                                                    if (text.isEmpty) {
                                                      FocusScope.of(context).unfocus();
                                                      searchProvider.brandSearchTextController.clear();
                                                      searchProvider.searchInstrumentsList.clear();
                                                    }
                                                  },
                                                  // Show a cancel icon to clear the input field if text is present
                                                  suffixIcon: searchProvider.brandSearchTextController.text.isNotEmpty
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            // Clear input and search results when the cancel icon is tapped
                                                            FocusScope.of(context).unfocus();
                                                            searchProvider.brandSearchTextController.clear();
                                                            searchProvider.searchInstrumentsList.clear();
                                                          },
                                                          child: Icon(
                                                            Icons.cancel,
                                                            color: VariableUtilities.theme.color7C7C7C,
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  searchController: searchProvider.brandSearchTextController,
                                                ),
                                                // Check if there are no filtered results
                                                searchProvider.searchInstrumentsList.isEmpty
                                                    // Display the full brand list when no search is applied
                                                    ? ListView.builder(
                                                        itemCount: searchProvider.searchCardData.left.data!.brands!.length,
                                                        shrinkWrap: true,
                                                        itemBuilder: (context, index) {
                                                          return Row(
                                                            children: [
                                                              // Checkbox for selecting/deselecting a brand
                                                              Checkbox(
                                                                activeColor: VariableUtilities.theme.blackColor,
                                                                value: searchProvider.allBrandList.contains(searchProvider.searchCardData.left.data!.brands![index]),
                                                                onChanged: (val) {
                                                                  // Handle brand selection/deselection
                                                                  searchProvider.onBrandSelectAndDeSelect(searchProvider.searchCardData.left.data!.brands![index]);
                                                                },
                                                              ),
                                                              // Display the brand name and product count
                                                              Text(
                                                                '${searchProvider.searchCardData.left.data!.brands![index].name} (${searchProvider.searchCardData.left.data!.brands![index].productCount})',
                                                                style: FontUtilities.h12(fontFamily: 'Open Sans'), // Text styling
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      )
                                                    // Display the filtered brand list based on search input
                                                    : ListView.builder(
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: searchProvider.searchInstrumentsList.length,
                                                        shrinkWrap: true, // Adjust size to content
                                                        itemBuilder: (context, index) {
                                                          return Row(
                                                            children: [
                                                              // Checkbox for selecting/deselecting a filtered brand
                                                              Checkbox(
                                                                activeColor: VariableUtilities.theme.blackColor,
                                                                value: searchProvider.allBrandList.contains(searchProvider.searchInstrumentsList[index]),
                                                                onChanged: (val) {
                                                                  // Handle selection/deselection of filtered brands
                                                                  searchProvider.onBrandSelectAndDeSelect(searchProvider.searchInstrumentsList[index]);
                                                                },
                                                              ),
                                                              // Display the filtered brand name and product count
                                                              Text(
                                                                '${searchProvider.searchInstrumentsList[index].name} (${searchProvider.searchInstrumentsList[index].productCount})',
                                                                style: FontUtilities.h12(fontFamily: 'Open Sans'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                              ],
                                            ),
                                          ),
                                        )
                                      // Show an empty space if no brands or filters are available
                                      : const SizedBox()
                                  : searchProvider.filterSelctionName == 'price_range'
                                      ? Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                            child: Theme(
                                              data: ThemeData(
                                                radioTheme: RadioThemeData(
                                                  fillColor: WidgetStatePropertyAll(VariableUtilities.theme.blackColor),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  // Displays the "Price Range" label
                                                  Text(
                                                    'Price Range',
                                                    style: FontUtilities.h12(
                                                      fontColor: VariableUtilities.theme.blackColor,
                                                      fontWeight: FWT.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  // List of price range options
                                                  ListView.builder(
                                                    itemCount: searchProvider.priceRangeList.length,
                                                    shrinkWrap: true,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      return RadioMenuButton(
                                                        // Sets the value of the current price range
                                                        value: searchProvider.selectedPriceRange == searchProvider.priceRangeList[index] ? 1 : 0,
                                                        groupValue: 1,
                                                        onChanged: (int? value) {
                                                          // Updates the selected price range
                                                          searchProvider.selectedPriceRange = searchProvider.priceRangeList[index];
                                                        },
                                                        child: Text(
                                                          // Displays the price range label based on its values
                                                          searchProvider.priceRangeList[index].minPrice == 0
                                                              ? 'Under ₹${searchProvider.priceRangeList[index].maxPrice}'
                                                              : searchProvider.priceRangeList[index].minPrice == 1000
                                                                  ? '₹${searchProvider.priceRangeList[index].minPrice} and Above'
                                                                  : '₹${searchProvider.priceRangeList[index].minPrice} to ₹${searchProvider.priceRangeList[index].maxPrice}', // Case: Range
                                                          style: FontUtilities.h13(
                                                            fontColor: VariableUtilities.theme.blackColor,
                                                            fontWeight: FWT.regular,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(height: 10),
                                                  // Custom price range input fields
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: SizedBox(
                                                            height: 55,
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: TextField(
                                                                    // Updates minimum price on text change
                                                                    onChanged: (val) {
                                                                      searchProvider.selectedPriceRange = PriceRange(
                                                                        minPrice: int.tryParse(val) ?? 0,
                                                                        maxPrice: searchProvider.selectedPriceRange.maxPrice,
                                                                      );
                                                                    },
                                                                    keyboardType: TextInputType.number,
                                                                    inputFormatters: [
                                                                      FilteringTextInputFormatter.digitsOnly,
                                                                    ],
                                                                    decoration: const InputDecoration(
                                                                      prefixText: '₹ ',
                                                                      hintText: '100',
                                                                      border: OutlineInputBorder(),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10),
                                                        Expanded(
                                                          child: SizedBox(
                                                            height: 55,
                                                            child: TextField(
                                                              // Updates maximum price on text change
                                                              onChanged: (val) {
                                                                searchProvider.selectedPriceRange = PriceRange(
                                                                  minPrice: searchProvider.selectedPriceRange.minPrice,
                                                                  maxPrice: int.tryParse(val) ?? 0,
                                                                );
                                                              },
                                                              keyboardType: TextInputType.number,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter.digitsOnly,
                                                              ],
                                                              decoration: const InputDecoration(
                                                                prefixText: '₹ ',
                                                                hintText: '1000',
                                                                border: OutlineInputBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : searchProvider.searchCardData.left.data!.attributes!.isNotEmpty
                                          ? Expanded(
                                              child: SingleChildScrollView(
                                                physics: const BouncingScrollPhysics(),
                                                child: ListView.builder(
                                                  itemCount: searchProvider.searchCardData.left.data!.attributes!.length,
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context, index) {
                                                    return searchProvider.searchCardData.left.data!.attributes?[index].code == searchProvider.filterSelctionName
                                                        ? ListView.builder(
                                                            itemCount: searchProvider.searchCardData.left.data!.attributes?[index].values!.length,
                                                            shrinkWrap: true,
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            itemBuilder: (context, insideIndex) {
                                                              return Row(
                                                                children: [
                                                                  Checkbox(
                                                                    activeColor: VariableUtilities.theme.blackColor,
                                                                    value: searchProvider.selectedValues.contains(searchProvider.searchCardData.left.data!.attributes![index].values![insideIndex]),
                                                                    onChanged: (val) {
                                                                      // Handles changes in attribute selection
                                                                      searchProvider.onAttributesChanges(
                                                                        searchProvider.searchCardData.left.data!.attributes![index],
                                                                        searchProvider.searchCardData.left.data!.attributes![index].values![insideIndex],
                                                                      );
                                                                    },
                                                                  ),
                                                                  // Displays attribute value and product count
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${searchProvider.searchCardData.left.data!.attributes![index].values![insideIndex].value} (${searchProvider.searchCardData.left.data!.attributes![index].values![insideIndex].productCount})",
                                                                      overflow: TextOverflow.ellipsis,
                                                                      maxLines: 2,
                                                                      style: FontUtilities.h12(fontFamily: 'Open Sans'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          )
                                                        : const SizedBox();
                                                  },
                                                ),
                                              ),
                                            )
                                          : const SizedBox()
                        ],
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          '''No Data Found for "${searchProvider.searchTextController.text}"''',
                          style: FontUtilities.h12(fontWeight: FWT.semiBold),
                        ),
                      ),
                    ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                          decoration: const BoxDecoration(),
                          titleColor: VariableUtilities.theme.primaryColor,
                          onTap: () async {
                            await searchProvider.clearAllFilter();
                          },
                          title: 'Clear Filter'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryButton(
                          onTap: () async {
                            Navigator.pop(context);
                            await searchProvider.callSearchCardApi(context, pageNumberSearchByFilter: 1);
                          },
                          title: 'Show'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      );
    });
  }

  String fetchRatingStars(String val, int reivewCount) {
    switch (val) {
      case '5':
        return '★★★★★ Upto 5 ($reivewCount)';
      case '4':
        return '★★★★☆ 4 & Up ($reivewCount)';
      case '3':
        return '★★★☆☆ 3 & Up ($reivewCount)';
      case '2':
        return '★★☆☆☆ 2 & Up ($reivewCount)';
      case '1':
        return '★☆☆☆☆ 1 & Up ($reivewCount)';
      default:
        return '★☆☆☆☆ 1 & Up ($reivewCount)';
    }
  }
}
