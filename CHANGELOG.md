## [3.0.1] - [September 26, 2026]

* README: a **More from Yako** grid with an animated preview of each of our other packages.

## [3.0.0] - [September 25, 2026]

### Breaking Changes
* **Migrated to `package:material_ui`** — Flutter 3.47 moved Material out of the SDK into the
  `material_ui` package. In apps that use `material_ui`, the alert now picks up the app's Material
  theme without `MaterialUiCompatibilityBridge`. Apps still on `package:flutter/material.dart` keep
  working, but these theme-dependent defaults come from the default Material theme until they
  migrate:
  * **Dark/light detection** (`Theme.of(context).brightness`), which picks the default background,
    icon, title and subtitle colors: the alert always uses its light style.
  * **Default text style** that the alert's `Material` provides (the theme's `bodyMedium`), which
    fills in whatever `titleOptions` / `subtitleOptions` styles don't set.
* **Minimum SDK raised to Dart 3.13.0 / Flutter 3.47.0.** Apps on older Flutter keep resolving
  `status_alert` 2.x (2.1.0). This also fixes the old floor: 2.x allowed Dart 3.0, but
  `StatusAlertTextConfiguration.textScaler` uses `TextScaler`, which needs Flutter 3.16+.

---

## [2.1.0] - [September 25, 2026]

### Bug Fixes
* **Alerts no longer stop showing** after the `Overlay` of a visible alert was disposed (for
  example when a nested `Navigator` left the tree, or between widget tests). `StatusAlert.isVisible`
  stayed `true` forever and every later `show()` was ignored.
* **`StatusAlert.hide()` no longer leaves a pending timer**, which made widget tests fail with
  "A Timer is still pending even after the widget tree was disposed".
* **`onComplete` is now called when the alert is dismissed by a background tap**
  (`dismissOnBackgroundTap: true`). It is still not called by `StatusAlert.hide()`.
* **An alert that finishes hiding no longer removes the alert shown after it** when `hide()` and
  `show()` are called during its last animation frame.
* **Alerts stay above the on-screen keyboard** instead of being drawn behind it.
* **Content scales down instead of overflowing** when it is taller than the space left, e.g. an
  icon, title and subtitle on a phone in landscape.

### Improvements
* The alert is a live region, so screen readers announce it when it appears.
* Overlay entries are disposed after use.
* Documented that `WidgetConfiguration` replaces the whole content (`title` and `subtitle` are
  not shown) and that `show()` does nothing while an alert is visible; fixed the README example.
* `pubspec.yaml`: added `repository`, `issue_tracker` and `topics`; `flutter_lints` 6.
* The published package no longer contains the README images (about 2.7 MB); they load from GitHub.
* Example app: Android, iOS and web projects regenerated (the Android project no longer built),
  unused Flare assets removed, example is now analyzed in CI.
* CI: updated actions, beta channel job, weekly run, PR title check. The publish workflow now uses
  pub.dev automated publishing (OIDC).

---

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
