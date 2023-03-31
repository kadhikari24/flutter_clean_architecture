// extension on String
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) empty;
    return this!;
  }
}

// extension on Integer
extension NonNullInteger on int? {
  int orZero() {
    if (this == null) zero;
    return this!;
  }
}
