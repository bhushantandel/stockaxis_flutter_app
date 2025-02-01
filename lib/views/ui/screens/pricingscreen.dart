import 'package:flutter/material.dart';
import 'package:stockaxis_flutter_app/viewmodels/pricing_view_model.dart';
import 'package:stockaxis_flutter_app/viewmodels/pricing_view_provider.dart';
import 'package:stockaxis_flutter_app/views/shared/constants/app_colors.dart';
import 'package:stockaxis_flutter_app/views/shared/constants/size_config.dart';
import 'package:provider/provider.dart';
import 'package:stockaxis_flutter_app/views/shared/utils/custom_text_style.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {



  double totalAmount = 0;
  double newDiscountedAmount = 0;
  int dropDownCounter = 0;
  String savingMsg = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() {
      print('Future.microtask Performed');
      if (mounted) {
        Provider.of<PricingViewProvider>(context, listen: false)
            .getPricingData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      color: AppColors.color_white,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              elevation: 0,
              titleSpacing: 0,
              title: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                  Text('Pricing'),
                ],
              ),
              actions: [
                GestureDetector(
                    onTap: () {

                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.headset_mic_outlined,
                        color: AppColors.color_primary_black,
                      ),
                    ))
              ],
            ),
            body: Column(
              children: [
                dropDownCounter >= 2 ? showSavingMessage() : SizedBox.shrink(),
                Expanded(
                  child: Consumer<PricingViewProvider>(
                      builder: (context, value, child) {
                    return ListView.separated(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      shrinkWrap: true,
                      itemCount: value.pricingViewData.length,
                      itemBuilder: (BuildContext context, int index) {
                        PricingView selectedPackg =
                            value.pricingViewData[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.color_white,
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.color_grey,
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      offset: Offset(0, 0))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Image.asset(
                                          'assets/images/${selectedPackg.imageString}',
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            selectedPackg.title,
                                            style: CustomTextstyle
                                                .titile_black_bold,
                                          ),
                                          Text(
                                            selectedPackg.capString,
                                            style: CustomTextstyle
                                                .subTitile_black_regular,
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(Icons.info_outline_rounded),
                                    ],
                                  ),
                                  Divider(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 10),
                                    child: Text(
                                      selectedPackg.description,
                                      style: CustomTextstyle
                                          .description_black_regular,
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: selectedPackg
                                                    .isDropDownSelected
                                                ? AppColors.color_primary_green
                                                : Colors.grey)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        dropdownColor: Colors.white,
                                        value:
                                            selectedPackg.dropdownOptions.label,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        elevation: 16,
                                        style: CustomTextstyle
                                            .subTitile_grey_subregular,
                                        underline: Container(
                                          color: Colors.white,
                                        ),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            if (selectedPackg
                                                    .dropdownOptions.label ==
                                                value) {
                                              return;
                                            }
                                            selectedPackg
                                                .dropdownOptions.label = value!;

                                            selectedPackg.isDropDownSelected =
                                                value !=
                                                    selectedPackg
                                                        .dropdownOptions
                                                        .value
                                                        .first; // Check if it's the first option

                                            getFinalAmount(
                                                selectedPackg,
                                                selectedPackg
                                                    .isDropDownSelected);
                                          });
                                        },
                                        items: selectedPackg
                                            .dropdownOptions.value
                                            .map<DropdownMenuItem<String>>(
                                          (String value) {
                                            // Check if the value contains "Rs" to identify price strings
                                            if (value.contains('Rs')) {
                                              List<String> parts =
                                                  value.split('Rs');

                                              if (parts.length == 3) {
                                                // Extract the duration and price information
                                                String duration = parts[0]
                                                    .trim(); // e.g., "12 Months -"
                                                String originalPrice =
                                                    'Rs. ${parts[1].trim()}'; // Original price
                                                String discountedPrice =
                                                    'Rs. ${parts[2].trim()}'; // Discounted prices
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: CustomTextstyle
                                                          .dropDown_grey,
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              duration, // Keep duration normal
                                                          style: CustomTextstyle
                                                              .dropDown_grey,
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "$originalPrice", // Strikeout original price
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .color_grey),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              " ${discountedPrice}", // Highlight discounted price
                                                          style: CustomTextstyle
                                                              .dropDown_grey,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            }

                                            // Default case for non-price entries
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                    );
                  }),
                ),
                bottomContainerWidget()
              ],
            )),
      ),
    );
  }

  bottomContainerWidget() {
    return Container(
      color: AppColors.color_white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rs. ${dropDownCounter >= 2 ? newDiscountedAmount : totalAmount}',
                  style: CustomTextstyle.titile_black_bold,
                ),
                Text(
                  'Inclusive GST',
                  style: CustomTextstyle.subTitile_grey_regular,
                )
              ],
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.color_primary_blue,
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  'Proceed For Payment',
                  style: CustomTextstyle.textStyle_14_600_white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getFinalAmount(PricingView pricingView, bool isDropDownSelected) {
    print('object >>>>>>> $isDropDownSelected');
    isDropDownSelected ? dropDownCounter++ : dropDownCounter--;
    String amountString = '';

    if (isDropDownSelected) {
      totalAmount = totalAmount + pricingView.discountedAmount;
      amountString = '$totalAmount';

      if (dropDownCounter >= 2) {
        newDiscountedAmount = totalAmount - (totalAmount * 0.2);
        print('totalAmount after 2 >>>> $newDiscountedAmount');
        amountString = '$newDiscountedAmount';

setState(() {
  savingMsg =
  'You will save Rs. ${(totalAmount * 0.2).ceil()} on this plan';
});

      }
    } else {
      totalAmount = totalAmount - pricingView.discountedAmount;
      amountString = '$totalAmount';
      if (dropDownCounter >= 2) {
        newDiscountedAmount = totalAmount - (totalAmount * 0.2);
        print('totalAmount after 2 >>>> $newDiscountedAmount');
        amountString = '$newDiscountedAmount';

        setState(() {
          savingMsg =
          'You will save Rs. ${(totalAmount * 0.2).ceil()} on this plan';
        });

      }
    }

    return amountString;
  }

  Widget showSavingMessage() {
    return  Container(
      width: SizeConfig.screenWidth,
      height: 40,
      decoration: BoxDecoration(
          color: AppColors.color_primary_green
      ),
      child: Center(child: Text(savingMsg,style:  CustomTextstyle.textStyle_14_600_white)),

    );
  }


}


