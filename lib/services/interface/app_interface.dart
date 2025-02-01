abstract class AppLoading {
  void isSuccessful(String response, {String type});

  void hideProgress();

  void showProgress();

  void showError(String message);
}
