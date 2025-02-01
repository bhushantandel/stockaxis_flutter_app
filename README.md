# stockaxis_flutter_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


StockAxis Flutter Demo App Documentation
1. Project Overview
App Name: StockAxis Pricing Demo Description: This is a single-page Flutter demo application that fetches product pricing from the provided APIs and displays them in a dropdown (spinner). Users can select/unselect products, and the total price is calculated dynamically. A 20% discount is applied if two products are selected.
2. Technologies & Architecture
	•	Framework: Flutter
	•	State Management: Provider
	•	Networking: Dio for API calls
	•	Architecture: MVVM (Model-View-ViewModel)
	•	UI Components: Dropdown (Spinner), ListView, AppBar
	•	IDE Used: Android Studio / VS Code , Xcode

3. App Features & Functionality
	•	API Integration
	◦	Used Dio to fetch pricing data from:
	▪	Little Masters: https://www.stockaxis.com/webservices/android/index.aspx?action=search&activity=PricingV2&CID=984493&PKGName=LM
	▪	Emerging Market Leaders: https://www.stockaxis.com/webservices/android/index.aspx?action=search&activity=PricingV2&CID=984493&PKGName=EML
	▪	Large Cap Focus: https://www.stockaxis.com/webservices/android/index.aspx?action=search&activity=PricingV2&CID=984493&PKGName=LCF
	▪	StocksOnTheMove: https://www.stockaxis.com/webservices/android/index.aspx?action=search&activity=PricingV2&CID=984493&PKGName=SOM
	◦	Parsing Json:
	▪	As Json response is not coming as expected we have taken only pAmount for Calculating Amount.
	▪	we have used regx to detect Json
	•	Dropdown Selection (Spinner)
	◦	Displays products with pricing fetched from API.
	•	Dynamic Price Calculation
	◦	When a product is selected, the price updates in real-time.
	•	20% Combo Discount
	◦	If two products are selected, the total price reflects a 20% discount.

4. Project Structure (MVVM)
lib
 ┣ models
 ┃ ┗ pricing_api_model.dart
 ┣ services
 ┃ ┣ interface
 ┃ ┃ ┗ app_interface.dart
 ┃ ┣ manager
 ┃ ┃ ┗ api_manager.dart
 ┃ ┣ network
 ┃ ┃ ┣ api_client.dart
 ┃ ┃ ┣ api_wrapper.dart
 ┃ ┃ ┗ url_constant.dart
 ┃ ┗ .DS_Store
 ┣ viewmodels
 ┃ ┣ pricing_view_model.dart
 ┃ ┗ pricing_view_provider.dart
 ┣ views
 ┃ ┣ shared
 ┃ ┃ ┣ constants
 ┃ ┃ ┃ ┣ app_colors.dart
 ┃ ┃ ┃ ┣ app_logs.dart
 ┃ ┃ ┃ ┗ size_config.dart
 ┃ ┃ ┗ utils
 ┃ ┃ ┃ ┣ app_theam.dart
 ┃ ┃ ┃ ┣ custom_box_decoration.dart
 ┃ ┃ ┃ ┣ custom_text_style.dart
 ┃ ┃ ┃ ┣ easy_loading.dart
 ┃ ┃ ┃ ┗ show_message.dart
 ┃ ┣ ui
 ┃ ┃ ┗ screens
 ┃ ┃ ┃ ┣ pricingscreen.dart
 ┃ ┃ ┃ ┗ splashscreen.dart
 ┃ ┗ .DS_Store
 ┗ main.dart

