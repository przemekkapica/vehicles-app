import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Testing the whole app', () {
    final carListScreenTitle = find.byValueKey('carListScreenTitle');
    final languagePopupButton = find.byValueKey('languagePopupButton');
    final polishLangSwitcher = find.byValueKey('polishLangSwitcher');
    final englishLangSwitcher = find.byValueKey('englishLangSwitcher');
    final carList = find.byValueKey('carList');
    final carDetailsScreenTitle = find.byValueKey('carDetailsScreenTitle');
    final moveToCarFormButton = find.byValueKey('moveToCarFormButton');
    final googleMapCarLocation = find.byValueKey('googleMapCarLocation');
    final carDetailsPageBackButton =
        find.byValueKey('carDetailsPageBackButton');
    final carAddingScreenBackButton =
        find.byValueKey('carAddingScreenBackButton');
    final carAddingScreenTitle = find.byValueKey('carAddingScreenTitle');
    final carBrandInput = find.byValueKey('carBrandInput');
    final carModelInput = find.byValueKey('carModelInput');
    final carRegistrationInput = find.byValueKey('carRegistrationInput');
    final carDateInput = find.byValueKey('carDateInput');
    final carOwnerDropdown = find.byValueKey('carOwnerDropdown');
    final stepperNextButton = find.byValueKey('stepperNextButton');
    final stepperBackButton = find.byValueKey('stepperBackButton');
    final colorPicker = find.byValueKey('colorPicker');
    final submitLocationButton = find.byValueKey('submitLocationButton');
    final locationPicker = find.byValueKey('locationPicker');
    final overviewBrand = find.byValueKey('overviewBrand');
    final overviewModel = find.byValueKey('overviewModel');
    final overviewOwnerName = find.byValueKey('overviewOwnername');
    final overviewRegistration = find.byValueKey('overviewRegistrationnumber');
    final overviewDate = find.byValueKey('overviewRegistrationdate');
    final overviewColor = find.byValueKey('overviewVehiclescolor');
    final colorStepTitle = find.byValueKey('colorStepTitle');
    final locationStepTitle = find.byValueKey('locationStepTitle');

    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    test('Starts app at car list page', () async {
      expect(await driver.getText(carListScreenTitle), 'Availble vehicles');
    });

    test('Change language within car list page', () async {
      await driver.tap(languagePopupButton);
      await driver.tap(polishLangSwitcher);
      expect(await driver.getText(carListScreenTitle), 'Dostępne pojazdy');

      await driver.tap(languagePopupButton);
      await driver.tap(englishLangSwitcher);
      expect(await driver.getText(carListScreenTitle), 'Availble vehicles');
    });

    test('Scroll through car list and tap on (random) item', () async {
      await driver.scroll(carList, 0, -500, Duration(milliseconds: 300));
      await driver.scroll(carList, 0, -300, Duration(milliseconds: 300));
      await driver.scroll(carList, 0, 400, Duration(milliseconds: 300));
      await driver.scroll(carList, 0, -500, Duration(milliseconds: 200));
      await driver.scroll(carList, 0, 500, Duration(milliseconds: 200));
      await driver.scroll(carList, 0, 600, Duration(milliseconds: 400));
    });

    test('Move to car details page', () async {
      final carListItem = find.byValueKey('carListItem3');
      await driver.tap(carListItem);
      await Future.delayed(const Duration(seconds: 2), () {});

      expect(await driver.getText(carDetailsScreenTitle), 'Vehicle details');
    });

    test('Change language within car details page', () async {
      await driver.tap(languagePopupButton);
      await driver.tap(polishLangSwitcher);
      expect(await driver.getText(carDetailsScreenTitle), 'Szczegóły pojazdu');

      await driver.tap(languagePopupButton);
      await driver.tap(englishLangSwitcher);
      expect(await driver.getText(carDetailsScreenTitle), 'Vehicle details');
    });

    test('Test swiping within google map', () async {
      await driver.scroll(
          googleMapCarLocation, 400, -400, Duration(milliseconds: 300));
      await driver.scroll(
          googleMapCarLocation, 500, 400, Duration(milliseconds: 300));
      await driver.scroll(
          googleMapCarLocation, -600, 500, Duration(milliseconds: 200));
      await driver.scroll(
          googleMapCarLocation, 500, -500, Duration(milliseconds: 200));
    });

    test('Move back to car list page', () async {
      await driver.tap(carDetailsPageBackButton);
      expect(await driver.getText(carListScreenTitle), 'Availble vehicles');
    });

    test('Move to car adding form', () async {
      await driver.tap(moveToCarFormButton);
      expect(await driver.getText(carAddingScreenTitle), 'Adding new car');
    });

    test('Move back to car list page', () async {
      await driver.tap(carAddingScreenBackButton);
      expect(await driver.getText(carListScreenTitle), 'Availble vehicles');
    });

    test('Move to car adding form', () async {
      await driver.tap(moveToCarFormButton);
      expect(await driver.getText(carAddingScreenTitle), 'Adding new car');
    });

    test('Move back to car list page by clicking back button', () async {
      await driver.tap(stepperBackButton);
      expect(await driver.getText(carListScreenTitle), 'Availble vehicles');
    });

    test('Move to car adding form', () async {
      await driver.tap(moveToCarFormButton);
      expect(await driver.getText(carAddingScreenTitle), 'Adding new car');
    });

    test('Change language within car adding form page', () async {
      await driver.tap(languagePopupButton);
      await driver.tap(polishLangSwitcher);
      expect(await driver.getText(carAddingScreenTitle), 'Dodawanie pojazdu');

      await driver.tap(languagePopupButton);
      await driver.tap(englishLangSwitcher);
      expect(await driver.getText(carAddingScreenTitle), 'Adding new car');
    });

    // test('Fill form with invalid data', () async {
    //   await driver.tap(carBrandInput);
    //   await driver.enterText('Car12');

    //   await driver.tap(carModelInput);
    //   await driver.enterText('Passat');

    //   await driver.tap(carRegistrationInput);
    //   await driver.enterText('SG H79DT');

    //   await driver.tap(carDateInput);
    //   await driver.enterText('2008/10/15');

    //   await driver.tap(carOwnerDropdown);
    //   await driver.tap(find.text('Lazaro Beier'));

    //   await driver.tap(stepperNextButton);
    // });

    test('Filling in car adding form with valid data', () async {
      final String brand = 'Volksvagen';
      final String model = 'Passat';
      final String ownerName = 'Lazaro Beier';
      final String registrationNumber = 'SG H79DT';
      final String registrationDate = '2008/10/15';
      final String color = '#000000';

      await driver.tap(carBrandInput);
      await driver.enterText(brand);

      await driver.tap(carModelInput);
      await driver.enterText(model);

      await driver.tap(carRegistrationInput);
      await driver.enterText(registrationNumber);

      await driver.tap(carDateInput);
      await driver.enterText(registrationDate);

      await driver.tap(carOwnerDropdown);
      await driver.tap(find.text(ownerName));

      await driver.tap(stepperNextButton);

      await driver.waitFor(colorPicker);

      await driver.tap(stepperNextButton);
      await driver.waitFor(locationPicker);

      await driver.tap(submitLocationButton);

      expect(await driver.getText(overviewBrand), brand);
      expect(await driver.getText(overviewModel), model);
      expect(await driver.getText(overviewOwnerName), ownerName);
      expect(await driver.getText(overviewRegistration), registrationNumber);
      expect(await driver.getText(overviewDate), registrationDate);
      expect(await driver.getText(overviewColor), color);

      await driver.tap(locationStepTitle);
      await driver.waitFor(locationPicker);

      await driver.tap(colorStepTitle);
      await driver.waitFor(colorPicker);

      await driver.tap(stepperNextButton);
      await driver.tap(submitLocationButton);

      expect(await driver.getText(overviewBrand), brand);
      expect(await driver.getText(overviewModel), model);
      expect(await driver.getText(overviewOwnerName), ownerName);
      expect(await driver.getText(overviewRegistration), registrationNumber);
      expect(await driver.getText(overviewDate), registrationDate);
      expect(await driver.getText(overviewColor), color);
    });
  });
}
