import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stockaxis_flutter_app/models/pricing_api_model.dart';
import 'package:stockaxis_flutter_app/services/interface/app_interface.dart';
import 'package:stockaxis_flutter_app/services/manager/api_manager.dart';
import 'package:stockaxis_flutter_app/services/network/url_constant.dart';
import 'package:stockaxis_flutter_app/viewmodels/pricing_view_model.dart';
import 'package:stockaxis_flutter_app/views/shared/utils/easy_loading.dart';

class PricingViewProvider with ChangeNotifier implements AppLoading {
  ApiManager? apiManager;
  EasyLoader easyLoader = EasyLoader();

  final List<PricingApiModel> _pricingApiModel =
      List.filled(4, PricingApiModel());
  // List<PricingApiModel> get pricingApiModel => _pricingApiModel;

  List<PricingView> _pricingViewData = [];
  List<PricingView> get pricingViewData => _pricingViewData;

  int _serviceCounter = 0;
  int get serviceCounter => _serviceCounter;

  int _indexCounter = 0;
  int get indexCounter => _indexCounter;

  List<Map<String, String>> items = [
    {
      'titleString': 'Little Masters',
      'capString': 'Small cap',
      'description':
          'Invest in up-trending Smallcap stocks screened through MILARS strategy to generate wealth.',
      'imageString': 'lm_icon.png'
    },
    {
      'titleString': 'Emerging Market Leaders',
      'capString': 'Mid cap',
      'description':
          'Generate wealth by riding momentum in Midcap stocks screened through MILARS strategy.',
      'imageString': 'eml_icon.png'
    },
    {
      'titleString': 'Large Cap Focus',
      'capString': 'Large cap',
      'description':
          'Achieve stable growth in your portfolio by investing in Bluechip stocks passed through MILARS strategy.',
      'imageString': 'lcf_icon.png'
    },
    {
      'titleString': 'Stocks On The Move',
      'capString': 'Flexi cap',
      'description':
          'Capitalize opportunities in strong momentum stocks, identified through technical research.',
      'imageString': 'som_icon.png'
    },
  ];

  getPricingData() async {
    apiManager = ApiManager(this);
    print('inside getDealsData');
    easyLoader.addLoader();
    apiManager?.apiManager(urlString: UrlConstants.pricingLm(), type: 'LM');
    _serviceCounter++;
    apiManager?.apiManager(urlString: UrlConstants.pricingEml(), type: 'EML');
    _serviceCounter++;
    apiManager?.apiManager(urlString: UrlConstants.pricingLcf(), type: 'LCF');
    _serviceCounter++;
    apiManager?.apiManager(urlString: UrlConstants.pricingSom(), type: 'SOM');
    _serviceCounter++;
  }

  setDataForView() {
    _indexCounter++;
    if (_indexCounter == 4) {
      _pricingViewData = generatePricingViewsList(items, _pricingApiModel);
      notifyListeners();
    }
  }

  List<PricingView> generatePricingViewsList(
      List<Map<String, String>> items, List<PricingApiModel> pricingApiModel) {
    return List.generate(items.length, (index) {
      // Ensure that we are not going out of bounds

      // Get the Datum corresponding to the index
      Datum datum = pricingApiModel[index].data?.first ?? Datum();

      // Calculate dynamic dropdown values (Amount and Discount)
      double amount = double.tryParse(datum.pAmount ?? '0') ?? 0.0;
      String discount = datum.comboOffer ?? '0';

      // Create dynamic dropdown options based on `amount` and `discount`
      DropdownOption dropdownOptions = DropdownOption(value: [
        'Select a Plan (inclusive of GST)',
        '12 Months - Rs $amount Rs ${amount - (amount * 0.2)}',
      ], label: 'Select a Plan (inclusive of GST)');

      // Construct the PricingView object
      return PricingView(
          title: items[index]['titleString'] ?? '',
          capString: items[index]['capString'] ?? '',
          description: items[index]['description'] ?? '',
          imageString: items[index]['imageString'] ?? '',
          dropdownOptions: dropdownOptions,
          selectedDropdownValue: dropdownOptions.label,
          pAmount: amount,
          discountedAmount: amount - (amount * 0.2),
          discounte: double.parse(discount));
    });
  }

  @override
  void hideProgress() {
    // setIsLoadingFalse();
    _serviceCounter--;
    if (_serviceCounter <= 1) {
      easyLoader.removeLoader();
    }
  }

  @override
  void isSuccessful(String resp, {String? type}) {
    switch (type) {
      case 'LM':
        _pricingApiModel[0] = PricingApiModel.fromJson(jsonDecode(resp));
        setDataForView();
        break;
      case 'EML':
        _pricingApiModel[1] = PricingApiModel.fromJson(jsonDecode(resp));
        setDataForView();
        break;
      case 'LCF':
        _pricingApiModel[2] = PricingApiModel.fromJson(jsonDecode(resp));
        setDataForView();
        break;
      case 'SOM':
        _pricingApiModel[3] = PricingApiModel.fromJson(jsonDecode(resp));
        setDataForView();
        break;
      default:
    }
  }

  @override
  void showError(String message) {}

  @override
  void showProgress() {}
}
