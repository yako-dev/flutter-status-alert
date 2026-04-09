## [2.0.0] - [April 9, 2026]

### Breaking Changes
* **Removed `FlareConfiguration`** — `flare_flutter` is abandoned and incompatible with Flutter 3.27+
  (fixes #17). Migrate to `WidgetConfiguration` to embed your own animation widget (e.g. Rive, Lottie).
* **Dart SDK `>=3.0.0 <4.0.0`** — Dart 2.x is no longer supported.
* **`textScaleFactor` removed** from `StatusAlertTextConfiguration` — replaced by `textScaler`
  (aligned with Flutter 3.10+ deprecation).

### New Features
* **`onComplete` callback** added to `StatusAlert.show()` — called after the alert finishes
  its dismiss animation (resolves #19 workaround request).

### Bug Fixes
* **`dismissOnBackgroundTap`** no longer uses `showDialog`, which was causing the alert to be
  pushed onto the Navigator stack and requiring a manual `Navigator.pop` to clean up (fixes #19).
  Now uses an `OverlayEntry` + `GestureDetector` for both modes — no Navigator interference.
* **`blurPower` parameter now applied** — it was accepted but hardcoded to `2.0` internally.
* **Touch pass-through** (`IgnorePointer`) confirmed correct — underlying widgets remain tappable
  while the alert is visible.

### Improvements
* Replaced `pedantic` with `flutter_lints` (incorporates community PR #14).
* Added `analysis_options.yaml` with recommended Flutter lint rules.
* Renamed internal file `status_allert_manager.dart` → `status_alert_manager.dart` (typo fix).
* Renamed private state class to `_StatusAlertBaseWidgetState`.
* Replaced `Container(alignment:...)` with `Align` for clarity.
* Added GitHub Actions CI — analyze + test on every push and PR.
* Added GitHub Actions publish workflow — publishes to pub.dev on version tag push.
* Expanded test suite with integration tests for `isVisible`, `hide()`, `onComplete`, and touch pass-through.

---

## [1.0.1] - [Oct 17, 2022]
* The maxWidth parameter will let you to contoll the Status Alert size on big screens

## [1.0.0] - [January 9, 2022]
* Fix gradle.wrapper version. Stable.

## [1.0.0-nullsafety.1] - [March 20, 2021]
* Flutter 2 & null safety

## [0.1.3] - [December 4, 2020]
* Dependencies version update
* Type 'MaterialColor' is not a subtype of type 'bool was fixed
* New feature: dismiss on background tap

## [0.1.2] - [April 1, 2020]
* Fixed issue "Type 'Color' is not a subtype of type 'bool'"

## [0.1.1] - [December 3, 2019]
* Added description in pubspec.yaml

## [0.1.0] - [December 3, 2019]
* Initial release with basic StatusAlert.
