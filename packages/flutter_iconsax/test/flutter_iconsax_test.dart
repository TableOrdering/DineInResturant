import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_iconsax/flutter_iconsax.dart';

void main() {
  /// Test for Iconsax
  test('Test', () {
    const dcube = Iconsax.dcube;
    expect(dcube.codePoint, 0xe901);
    expect(dcube.fontFamily, 'iconsax');
    expect(dcube.fontPackage, 'flutter_iconsax');
  });
}
