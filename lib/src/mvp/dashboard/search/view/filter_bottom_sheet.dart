import 'package:bb3_ecommerce_app/src/mvp/dashboard/search/model/price_range_model.dart';
import 'package:bb3_ecommerce_app/src/mvp/dashboard/search/provider/search_provider.dart';
import 'package:bb3_ecommerce_app/src/widget/widget.dart';
import 'package:bb3_ecommerce_app/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  const FilterBottomSheetWidget({super.key});

  @override
  State<FilterBottomSheetWidget> createState() => _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (_, SearchProvider searchProvider, __) {
      return Container(
        decoration: BoxDecoration(color: VariableUtilities.theme.whiteColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
        child: SafeArea(
          bottom: true,
          child: FractionallySizedBox(
            heightFactor: 0.75, // 75% of the screen height
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

                Expanded(
                    child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      ExpansionPanelList(
                        expansionCallback: (panelIndex, isExpanded) {
                          searchProvider.filterSelctionName == 'sortBy' ? searchProvider.filterSelctionName = '' : searchProvider.filterSelctionName = 'sortBy';
                          setState(() {});
                        },
                        expandedHeaderPadding: const EdgeInsets.all(0.0),
                        children: <ExpansionPanel>[
                          ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text('Sort By', style: FontUtilities.h12(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.bold)),
                                );
                              },
                              body: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Theme(
                                  // Setting a custom theme for radio buttons
                                  data: ThemeData(radioTheme: RadioThemeData(fillColor: WidgetStatePropertyAll(VariableUtilities.theme.blackColor))),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        // ListView for rendering rating options
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.all(0),
                                          itemCount: searchProvider.sortByList.length,
                                          shrinkWrap: true,
                                          reverse: true,
                                          itemBuilder: (context, index) {
                                            return RadioMenuButton(
                                                // Dynamically set the selected rating value
                                                value: searchProvider.selectedSortBy == index ? 1 : 0,
                                                groupValue: 1,
                                                onChanged: (int? value) {
                                                  searchProvider.selectedSortBy = index;
                                                },
                                                // Display the star rating dynamically
                                                child: Text(searchProvider.sortByList[index]));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              isExpanded: searchProvider.filterSelctionName == 'sortBy',
                              canTapOnHeader: true)
                        ],
                      ),
                      ExpansionPanelList(
                        expansionCallback: (panelIndex, isExpanded) {
                          searchProvider.filterSelctionName == 'rating' ? searchProvider.filterSelctionName = '' : searchProvider.filterSelctionName = 'rating';
                          setState(() {});
                        },
                        expandedHeaderPadding: const EdgeInsets.all(0.0),
                        children: <ExpansionPanel>[
                          ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text('Rating', style: FontUtilities.h12(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.bold)),
                                );
                              },
                              body: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Theme(
                                  // Setting a custom theme for radio buttons
                                  data: ThemeData(radioTheme: RadioThemeData(fillColor: WidgetStatePropertyAll(VariableUtilities.theme.blackColor))),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        // ListView for rendering rating options
                                        ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.all(0),
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
                              isExpanded: searchProvider.filterSelctionName == 'rating',
                              canTapOnHeader: true)
                        ],
                      ),

                      /// Brand ExpansionPanel List
                      searchProvider.searchCardData.isLeft && searchProvider.searchCardData.left.data!.brands!.isNotEmpty
                          ? ExpansionPanelList(
                              expansionCallback: (panelIndex, isExpanded) {
                                searchProvider.filterSelctionName == 'brand' ? searchProvider.filterSelctionName = '' : searchProvider.filterSelctionName = 'brand';
                                setState(() {});
                                // Scroll to the selected panel
                              },
                              expandedHeaderPadding: const EdgeInsets.all(0.0),
                              children: <ExpansionPanel>[
                                ExpansionPanel(
                                    headerBuilder: (context, isExpanded) {
                                      return Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text('Brand', style: FontUtilities.h12(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.bold)),
                                      );
                                    },
                                    body: searchProvider.searchCardData.isLeft
                                        ? Column(
                                            children: [
                                              // Input field for searching brands
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                                child: SearchInputField(
                                                  isDense: true,
                                                  fillColor: Colors.grey.withOpacity(0.2),
                                                  hintText: 'Search Brand',
                                                  autoFocus: false,
                                                  onChanged: (text) {
                                                    // Trigger search logic if the text changes
                                                    if (searchProvider.searchBrandValue != text) {
                                                      // Call the search function when the input is at least 2 characters long
                                                      searchProvider.searchBrand(searchProvider.brandSearchTextController.text);
                                                    }
                                                    // Clear search results and input if the text is empty
                                                    if (text.isEmpty) {
                                                      FocusScope.of(context).unfocus();
                                                      searchProvider.clearOnSearchInputField();
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
                                                          child: Icon(Icons.cancel, color: VariableUtilities.theme.color7C7C7C),
                                                        )
                                                      : const SizedBox(),
                                                  searchController: searchProvider.brandSearchTextController,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8, left: 16),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (searchProvider.isFilterAtoZ) {
                                                        searchProvider.sortFilterRelevance();
                                                      } else {
                                                        searchProvider.sortFilterAtoZ();
                                                      }
                                                      searchProvider.isFilterAtoZ = !searchProvider.isFilterAtoZ;
                                                    },
                                                    child: Text(
                                                      searchProvider.isFilterAtoZ ? 'View by Relevance' : 'View A-Z',
                                                      style: FontUtilities.h12(fontColor: Colors.blue),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              (searchProvider.brandSearchTextController.text.isNotEmpty && searchProvider.searchInstrumentsList.isEmpty)
                                                  ? Text('No Result Found!', style: FontUtilities.h10(fontColor: Colors.black, fontWeight: FWT.semiBold))
                                                  : searchProvider.searchInstrumentsList.isEmpty
                                                      // Display the full brand list when no search is applied
                                                      ? Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Wrap(
                                                            children: List.generate(
                                                              searchProvider.searchCardData.left.data!.brands!.length,
                                                              (index) {
                                                                return SizedBox(
                                                                  width: MediaQuery.of(context).size.width / 2 - 8, // Half the screen width with padding
                                                                  child: Row(
                                                                    children: [
                                                                      // Checkbox for selecting/deselecting a brand
                                                                      Checkbox(
                                                                        activeColor: VariableUtilities.theme.blackColor,
                                                                        value: searchProvider.selectedBrandList.contains(
                                                                          searchProvider.searchCardData.left.data!.brands![index],
                                                                        ),
                                                                        onChanged: (val) {
                                                                          // Handle brand selection/deselection
                                                                          searchProvider.onBrandSelectAndDeSelect(
                                                                            searchProvider.searchCardData.left.data!.brands![index],
                                                                          );
                                                                        },
                                                                      ),
                                                                      // Display the brand name and product count
                                                                      Expanded(
                                                                        child: Text(
                                                                          '${searchProvider.searchCardData.left.data!.brands![index].name} (${searchProvider.searchCardData.left.data!.brands![index].productCount})',
                                                                          maxLines: 2,
                                                                          style: FontUtilities.h12(fontFamily: 'Open Sans'), // Text styling
                                                                          overflow: TextOverflow.ellipsis, // Handle text overflow
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        )
                                                      : Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Wrap(
                                                            children: List.generate(
                                                              searchProvider.searchInstrumentsList.length,
                                                              (index) {
                                                                return SizedBox(
                                                                  width: MediaQuery.of(context).size.width / 2 - 8, // Half the screen width with padding
                                                                  child: Row(
                                                                    children: [
                                                                      // Checkbox for selecting/deselecting a brand
                                                                      Checkbox(
                                                                        activeColor: VariableUtilities.theme.blackColor,
                                                                        value: searchProvider.selectedBrandList.contains(searchProvider.searchInstrumentsList[index]),
                                                                        onChanged: (val) {
                                                                          // Handle selection/deselection of filtered brands
                                                                          searchProvider.onBrandSelectAndDeSelect(searchProvider.searchInstrumentsList[index]);
                                                                        },
                                                                      ),
                                                                      // Display the filtered brand name and product count
                                                                      Expanded(
                                                                        child: Text(
                                                                          '${searchProvider.searchInstrumentsList[index].name} (${searchProvider.searchInstrumentsList[index].productCount})',
                                                                          style: FontUtilities.h12(fontFamily: 'Open Sans'),
                                                                          maxLines: 2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        )
                                            ],
                                          )
                                        // Show an empty space if no brands or filters are available
                                        : const SizedBox(),
                                    isExpanded: searchProvider.filterSelctionName == 'brand',
                                    canTapOnHeader: true)
                              ],
                            )
                          : const SizedBox(),

                      /// SkinType / SkinConcern / Routine / SkinCare / PriceRange / ETC. ExpansionPanel List
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: searchProvider.searchCardData.left.data!.attributes!.length,
                        itemBuilder: (context, index) {
                          return ExpansionPanelList(
                            expansionCallback: (panelIndex, isExpanded) {
                              searchProvider.filterSelctionName == (searchProvider.searchCardData.left.data!.attributes![index].code ?? '$index')
                                  ? searchProvider.filterSelctionName = ''
                                  : searchProvider.filterSelctionName = (searchProvider.searchCardData.left.data!.attributes![index].code ?? '$index');
                              setState(() {});
                            },
                            expandedHeaderPadding: const EdgeInsets.all(0.0),
                            children: <ExpansionPanel>[
                              ExpansionPanel(
                                  headerBuilder: (context, isExpanded) {
                                    return Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(searchProvider.searchCardData.left.data!.attributes![index].title ?? 'Unknown',
                                          style: FontUtilities.h12(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.bold)),
                                    );
                                  },
                                  body: searchProvider.searchCardData.left.data!.attributes!.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: searchProvider.searchCardData.left.data!.attributes!.length,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return searchProvider.searchCardData.left.data!.attributes?[index].code == searchProvider.filterSelctionName
                                                ? Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Wrap(
                                                      children: List.generate(
                                                        searchProvider.searchCardData.left.data!.attributes![index].values!.length,
                                                        (insideIndex) {
                                                          return SizedBox(
                                                            width: MediaQuery.of(context).size.width / 2 - 8, // Half the screen width with padding
                                                            child: Row(
                                                              children: [
                                                                // Checkbox for selecting/deselecting a brand
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
                                                                    maxLines: 3,
                                                                    style: FontUtilities.h12(fontFamily: 'Open Sans'),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox();
                                          },
                                        )
                                      : const SizedBox(),
                                  isExpanded: searchProvider.filterSelctionName == (searchProvider.searchCardData.left.data!.attributes![index].code ?? '$index'),
                                  canTapOnHeader: true)
                            ],
                          );
                        },
                      ),

                      /// Price Range ExpansionPanel List
                      searchProvider.searchCardData.isLeft && searchProvider.searchCardData.left.data!.brands!.isNotEmpty
                          ? ExpansionPanelList(
                              expansionCallback: (panelIndex, isExpanded) {
                                searchProvider.filterSelctionName == 'price_range' ? searchProvider.filterSelctionName = '' : searchProvider.filterSelctionName = 'price_range';
                                setState(() {});
                              },
                              expandedHeaderPadding: const EdgeInsets.all(0.0),
                              children: <ExpansionPanel>[
                                ExpansionPanel(
                                    headerBuilder: (context, isExpanded) {
                                      return Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text('Price Range', style: FontUtilities.h12(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.bold)),
                                      );
                                    },
                                    body: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                    isExpanded: searchProvider.filterSelctionName == 'price_range',
                                    canTapOnHeader: true)
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                )),

                const SizedBox(height: 5),

                /// CLEAR FILTER & SEARCH BUTTON
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
