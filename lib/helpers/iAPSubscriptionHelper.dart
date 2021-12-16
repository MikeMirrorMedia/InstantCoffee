import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:readr_app/services/subscriptionSelectService.dart';

class IAPSubscriptionHelper {  
  static final IAPSubscriptionHelper _instance = IAPSubscriptionHelper._internal();

  factory IAPSubscriptionHelper() {
    return _instance;
  }

  IAPSubscriptionHelper._internal();

  StreamController<PurchaseDetails> buyingPurchaseController = StreamController<PurchaseDetails>.broadcast();
  StreamSubscription<List<PurchaseDetails>> _subscription;
  InAppPurchase _inAppPurchase = InAppPurchase.instance;

  void setSubscription() {
    _subscription = _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      buyingPurchaseController.sink.add(purchaseDetails);
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          if(purchaseDetails.pendingCompletePurchase) {
            await _inAppPurchase.completePurchase(purchaseDetails);
          }
        } else {
          _handleInvalidPurchase(purchaseDetails);
          return;
        }
      }
      else if (purchaseDetails.status == PurchaseStatus.canceled) {
        if(Platform.isIOS) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async{
    SubscriptionSelectServices subscriptionSelectServices = SubscriptionSelectServices();
    return subscriptionSelectServices.verifyPurchase(purchaseDetails);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) async{
    int retryAwaitSecond = 1;
    int retryMaxAwaitSecond = 60;
    bool valid = false;
    while(!valid && retryAwaitSecond < retryMaxAwaitSecond) {
      await Future.delayed(Duration(seconds: retryAwaitSecond));
      valid = await _verifyPurchase(purchaseDetails);
      if (valid) {
        if(purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
      retryAwaitSecond = retryAwaitSecond*2;
    }
  }

  cancelSubscriptionStream() {
    _subscription.cancel();
    buyingPurchaseController.close();
  }
}