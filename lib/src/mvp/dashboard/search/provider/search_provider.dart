import 'dart:convert';

import 'package:bb3_ecommerce_app/src/mvp/dashboard/search/api/get_search_card_api.dart';
import 'package:bb3_ecommerce_app/src/mvp/dashboard/search/model/price_range_model.dart';
import 'package:bb3_ecommerce_app/src/mvp/dashboard/search/model/search_languages_card_model.dart';
import 'package:bb3_ecommerce_app/utilities/exception/exception_utilities.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchProvider extends ChangeNotifier {
  // Controllers for search input fields
  TextEditingController searchTextController = TextEditingController();
  TextEditingController brandSearchTextController = TextEditingController();

  // Indicates whether a search is currently in progress
  bool _isFetchingFromAPI = false;
  bool get isFetchingFromAPI => _isFetchingFromAPI;
  set isFetchingFromAPI(bool value) {
    _isFetchingFromAPI = value;
    notifyListeners(); // Notify listeners to rebuild widgets when value changes
  }

  // Stores the current search value
  String _searchValue = '';
  String get searchValue => _searchValue;
  set searchValue(String value) {
    _searchValue = value;
    notifyListeners();
  }

  // Stores the current brand search value
  String _searchBrandValue = '';
  String get searchBrandValue => _searchBrandValue;
  set searchBrandValue(String value) {
    _searchBrandValue = value;
    notifyListeners();
  }

  // Either stores search results or an exception if something went wrong
  Either<SearchProductModel, Exception> _searchCardData = Right(NoDataFoundException());
  Either<SearchProductModel, Exception> get searchCardData => _searchCardData;
  set searchCardData(Either<SearchProductModel, Exception> value) {
    _searchCardData = value;
    notifyListeners();
  }

  // Filter selection criteria (e.g., rating, price, etc.)
  String _filterSelctionName = 'sortBy';
  String get filterSelctionName => _filterSelctionName;
  set filterSelctionName(String value) {
    _filterSelctionName = value;
    notifyListeners();
  }

  // Stores the selected rating value for filtering
  int _selectRatingValue = -1;
  int get selectRatingValue => _selectRatingValue;
  set selectRatingValue(int value) {
    _selectRatingValue = value;
    notifyListeners();
  }

  // Stores the selected SortBy Value
  int _selectedSortBy = -1;
  int get selectedSortBy => _selectedSortBy;
  set selectedSortBy(int value) {
    _selectedSortBy = value;
    notifyListeners();
  }

  // List of selected brands for filtering
  List<BrandElement> _selectedBrandList = [];
  List<BrandElement> get selectedBrandList => _selectedBrandList;
  set selectedBrandList(List<BrandElement> val) {
    _selectedBrandList = val;
    notifyListeners();
  }

  // Predefined price ranges for filtering
  List<PriceRange> priceRangeList = [
    PriceRange(minPrice: 0, maxPrice: 250),
    PriceRange(minPrice: 250, maxPrice: 500),
    PriceRange(minPrice: 500, maxPrice: 1000),
    PriceRange(minPrice: 1000, maxPrice: 100000),
  ];

  // Stores the currently selected price range
  PriceRange _selectedPriceRange = PriceRange(minPrice: -1, maxPrice: -1);
  PriceRange get selectedPriceRange => _selectedPriceRange;
  set selectedPriceRange(PriceRange value) {
    _selectedPriceRange = value;
    notifyListeners();
  }

  // Adds or removes a brand from the selected brand list
  void onBrandSelectAndDeSelect(BrandElement brandElement) {
    if (selectedBrandList.contains(brandElement)) {
      selectedBrandList.removeWhere((val) => val == brandElement);
    } else {
      selectedBrandList.add(brandElement);
    }
    notifyListeners();
  }

  // List of selected attributes for filtering
  List<Attribute> _selectedAttributes = [];
  List<Attribute> get selectedAttributes => _selectedAttributes;
  set selectedAttributes(List<Attribute> val) {
    _selectedAttributes = val;
    notifyListeners();
  }

  // List of selected attribute values for filtering
  List<Value> _selectedValues = [];
  List<Value> get selectedValues => _selectedValues;
  set selectedValues(List<Value> val) {
    _selectedValues = val;
    notifyListeners();
  }

  // Handles adding/removing attributes and their values dynamically
  void onAttributesChanges(Attribute value, Value itemName) {
    if (isCodeExists(value.code ?? '')) {
      if (checkValueIsInAttributes(itemName)) {
        // Remove the attribute value if it exists
        for (int i = 0; i < selectedAttributes.length; i++) {
          if (selectedAttributes[i].code == value.code) {
            selectedAttributes[i].values!.removeWhere((val) => itemName == val);
            selectedValues.removeWhere((val) => val == itemName);
            if (selectedAttributes[i].values!.map((e) => e.value).toList().isEmpty) {
              selectedAttributes.removeWhere((e) => e.code == value.code);
            }
            break;
          }
        }
      } else {
        // Add the attribute value if it doesn't exist
        for (int i = 0; i < selectedAttributes.length; i++) {
          if (selectedAttributes[i].code == value.code) {
            selectedAttributes[i].values!.add(itemName);
            selectedValues.add(itemName);
            break;
          }
        }
      }
    } else {
      // Add a new attribute with its values
      selectedAttributes.add(Attribute(code: value.code, title: value.title, values: [itemName]));
      selectedValues.add(itemName);
    }
    notifyListeners();
  }

  // Check if a value exists in the selected attributes
  bool checkValueIsInAttributes(Value itemName) {
    for (int i = 0; i < selectedAttributes.length; i++) {
      if (selectedAttributes[i].values!.contains(itemName)) {
        return true;
      }
    }
    return false;
  }

  // Check if an attribute code exists in the selected attributes
  bool isCodeExists(String code) {
    return selectedAttributes.where((val) => val.code == code).isNotEmpty;
  }

  // Pagination properties
  int _newPageNumber = 1;
  int get newPageNumber => _newPageNumber;
  set newPageNumber(int val) {
    _newPageNumber = val;
    notifyListeners();
  }

  int _lastPageNumber = 1;
  int get lastPageNumber => _lastPageNumber;
  set lastPageNumber(int val) {
    _lastPageNumber = val;
    notifyListeners();
  }

  // Indicates whether data is being loaded
  bool _isVisibleLoadingIndicator = false;
  bool get isVisibleLoadingIndicator => _isVisibleLoadingIndicator;
  set isVisibleLoadingIndicator(bool val) {
    _isVisibleLoadingIndicator = val;
    notifyListeners();
  }

  // Fetches search data from the API based on the current filters and inputs
  callSearchCardApi(BuildContext context, {int? pageNumberSearchByFilter}) async {
    // Logic for determining the next page number
    if (pageNumberSearchByFilter != null) {
      newPageNumber = 1;
    } else if (pageNumberSearchByFilter == null && searchCardData.isLeft) {
      if (searchValue == searchTextController.text) {
        if (searchCardData.left.meta != null) {
          if ((searchCardData.left.meta!.lastPage ?? 0) >= (searchCardData.left.meta!.currentPage ?? 0)) {
            newPageNumber = (searchCardData.left.meta!.currentPage ?? 0) + 1;
            lastPageNumber = searchCardData.left.meta!.lastPage ?? 0;
          } else {
            Fluttertoast.showToast(msg: 'No More Data');
            return;
          }
        } else {
          newPageNumber = 1;
        }
      } else {
        newPageNumber = 1;
      }
    } else {
      newPageNumber = 1;
    }

    // Prevent further API calls if there are no more pages
    if (newPageNumber > lastPageNumber) {
      Fluttertoast.showToast(msg: 'No More Data');
      return;
    }

    isVisibleLoadingIndicator = true;

    if (searchCardData.isLeft) {
      if (searchCardData.left.data == null) {
        searchCardData = Right(FetchingDataException());
      }
    }

    // Prepare API parameters based on filters and search input
    Map<String, dynamic> params = {'q': searchTextController.text};

    selectedSortBy >= 0 ? params.addAll({'sortBy': sortByApiValue[selectedSortBy]}) : null;
    if (selectedBrandList.isNotEmpty) {
      // Add selected brands to the parameters after formatting
      params.addAll({'brands': selectedBrandList.map((e) => e.name).toList().join(",").replaceAll(" ", '-').toLowerCase()});
    }
    if (selectedAttributes.isNotEmpty) {
      Map<String, dynamic> json = {};

      // Convert selected attributes to JSON format for API
      for (int i = 0; i < selectedAttributes.length; i++) {
        json.addAll({"${selectedAttributes[i].code}": selectedAttributes[i].values!.map((e) => e.value).toList()});
      }
      params.addAll({'attributes': jsonEncode(json)});
    }
    if (selectRatingValue != -1) {
      params.addAll({'minRating': "${selectRatingValue + 1}"});
    }
    if (selectedPriceRange != PriceRange(maxPrice: -1, minPrice: -1)) {
      params.addAll({'minPrice': "${selectedPriceRange.minPrice}"});
      if (selectedPriceRange.minPrice != 1000) {
        params.addAll({'maxPrice': "${selectedPriceRange.maxPrice}"});
      }
    }
    params.addAll({'page': "$newPageNumber"});
    // Call the search API with the prepared parameters
    Either<SearchProductModel, Exception> resposne = await searchCardApi(context, params: params);
    try {
      if (resposne.isLeft) {
        if (resposne.left.success ?? false) {
          if (resposne.left.data!.products!.isEmpty) {
            if (searchCardData.isLeft) {
              if (searchCardData.left.data == null) {
                searchCardData = Right(NoDataFoundException());
              } else {
                searchCardData.left.data!.products!.clear();
                if ((resposne.left.data!.brands ?? []).isEmpty) {
                  searchCardData.left.data!.brands!.clear();
                }
                if ((resposne.left.data!.attributes ?? []).isEmpty) {
                  searchCardData.left.data!.attributes!.clear();
                }
              }
            }
            isVisibleLoadingIndicator = false;
          } else {
            if (pageNumberSearchByFilter != null) {
              searchCardData = resposne;
              allBrandsList = List.from(resposne.left.data!.brands ?? []);
            } else if (searchValue == searchTextController.text) {
              resposne.fold((l) {
                searchCardData.left.data!.products!.addAll(l.data!.products ?? []);
                allBrandsList = List.from(searchCardData.left.data!.brands ?? []);
                if ((l.data!.brands ?? []).isEmpty) {
                  searchCardData.left.data!.brands!.clear();
                }
                if ((l.data!.attributes ?? []).isEmpty) {
                  searchCardData.left.data!.attributes!.clear();
                }
                searchCardData.left.meta = l.meta;
                notifyListeners();
              }, (r) {});
            } else {
              searchCardData = resposne;
              allBrandsList = List.from(resposne.left.data!.brands ?? []);
            }
            isVisibleLoadingIndicator = false;
          }
        }
      } else if (resposne.isRight) {
        if (resposne.right is NoInternetException) {
          searchCardData = Right(NoInternetException());
        } else {
          searchCardData = Right(NoDataFoundException());
        }
      } else {
        searchCardData = Right(NoDataFoundException());
      }
      isVisibleLoadingIndicator = false;
      searchValue = searchTextController.text;
    } catch (e) {
      searchCardData = Right(NoDataFoundException());
    }
  }

  // Brand Filter A-Z
  bool _isFilterAtoZ = false;
  bool get isFilterAtoZ => _isFilterAtoZ;
  set isFilterAtoZ(bool val) {
    _isFilterAtoZ = val;
    notifyListeners(); // Notify UI listeners of data changes
  }

  // All Brands List
  List<BrandElement> _allBrandsList = [];
  List<BrandElement> get allBrandsList => _allBrandsList;
  set allBrandsList(List<BrandElement> val) {
    _allBrandsList = val;
    notifyListeners(); // Notify UI listeners of data changes
  }

  List<BrandElement> searchInstrumentsListForFutureUseByRelevance = [];

  sortFilterAtoZ() {
    if (searchInstrumentsList.isEmpty) {
      if (searchCardData.isLeft) {
        if (searchCardData.left.data != null) {
          searchCardData.left.data!.brands!.sort((a, b) => a.name!.compareTo(b.name!));
          notifyListeners();
        }
      }
    } else {
      searchInstrumentsList.sort((a, b) => a.name!.compareTo(b.name!));
      notifyListeners();
    }
  }

  sortFilterRelevance() {
    if (searchInstrumentsList.isEmpty) {
      if (searchCardData.isLeft) {
        if (searchCardData.left.data != null) {
          searchCardData.left.data!.brands = List.from(allBrandsList);
          notifyListeners();
        }
      }
    } else {
      searchInstrumentsList = List.from(searchInstrumentsListForFutureUseByRelevance);
      notifyListeners();
    }
  }

  // Manage a list of instruments for brand search
  List<BrandElement> _searchInstrumentsList = [];
  List<BrandElement> get searchInstrumentsList => _searchInstrumentsList;
  set searchInstrumentsList(List<BrandElement> val) {
    _searchInstrumentsList = val;
    notifyListeners(); // Notify UI listeners of data changes
  }

  // Search brands by name based on input
  void searchBrand(String searchKeyword) {
    if (searchKeyword.isEmpty) {
      searchInstrumentsList = []; // Clear search list if input is empty
      return;
    }

    if (searchCardData.isLeft) {
      // Filter brands containing the search keyword
      searchInstrumentsList.clear();

      searchInstrumentsList = searchCardData.left.data!.brands!.where((val) {
        return val.name!.toLowerCase().contains(searchKeyword.toLowerCase());
      }).toList();

      searchInstrumentsListForFutureUseByRelevance = searchCardData.left.data!.brands!.where((val) {
        return val.name!.toLowerCase().contains(searchKeyword.toLowerCase());
      }).toList();
    }
    notifyListeners(); // Notify listeners of the updated search list
  }

  clearOnSearchInputField() {
    brandSearchTextController.clear();
    searchInstrumentsList.clear();
    searchInstrumentsListForFutureUseByRelevance.clear();
  }

  // Clear all applied filters
  clearAllFilter() {
    selectRatingValue = -1;
    selectedSortBy = -1;
    selectedBrandList = [];
    selectedAttributes.clear();
    selectedValues.clear();
    selectedPriceRange = PriceRange(minPrice: -1, maxPrice: -1);
    notifyListeners(); // Notify UI listeners
  }

// Clear all search-related data
  reSetDataForSearchScreen() {
    clearAllFilter(); // Clear filters
    filterSelctionName == 'sortBy';
    isVisibleLoadingIndicator = false;
    searchValue = '';
    searchCardData = Right(NoDataFoundException());
    searchTextController.clear(); // Clear search input
    notifyListeners(); // Notify listeners to update UI
  }

// Sort By Data
  List<String> sortByList = ['Relevance', 'Best Selling', 'Top Rated', 'Price: Low to High', 'Price: High to Low', 'New'];
  List<String> sortByApiValue = ['relevance', 'best-selling', 'top-rated', 'price-asc', 'price-desc', 'new'];
}
