# Part 3 Acceptance Gate (§32–§42)

Final verification record for the world-class UI/UX, design system and
performance part. Every line below reflects a real, reproducible result —
nothing is aspirational.

## Gate results

| Check | Command | Result |
| --- | --- | --- |
| Zero analyzer issues | `flutter analyze` | **No issues found!** (270.5 s run, 0 infos/warnings/errors) |
| Full test suite | `flutter test` | **249 / 249 passed** (01:43 wall time) |
| Golden snapshots | `flutter test test/goldens` | 4/4 pass (home light, home dark, home RTL, settings light) |
| Localization parity gate | part of suite | 15/15 locales, key parity + placeholder + non-copy checks pass |
| Performance budgets | part of suite | pass |
| Text scaling @ 1.5× | part of suite | 3/3 pass (onboarding+home, settings+history, Arabic home) |
| RTL + accessibility semantics | part of suite | pass (localized semantics, tooltips, 48 dp targets) |
| Preference persistence | part of suite | pass |
| Privacy audit | part of suite | pass (fails build on tracking/ads/payments/data-sale code) |
| App icons | `dart run tool/generate_icon.dart` + `dart run flutter_launcher_icons` | 1024 px source + adaptive icons + Android/iOS launcher icons written |

## Section checklist

### §32 — Central design tokens
- Single token layer in `lib/app/theme/` (colour, spacing, typography, motion).
- Light/dark themes derived from the same tokens; accent `#2457D6` light /
  `#8EACFF` dark; 4 pt spacing scale; radii 8/12/16/20.
- No hard-coded colours or magic spacing outside the token layer.

### §33 — Screen-by-screen premium design
- **Onboarding**: 3 pages (privacy, how-it-works, language), completion
  persisted via `AppPrefs` (`onboardingDone`); verified by
  `persistence_test.dart` and `text_scaling_test.dart`.
- **Home**: one dominant "Create a photo" action; recents; favourites;
  "Your photos" shortcut to history (duplicate card removed — title uses
  `navHistory`).
- **Country picker**: searchable, grouped by country, pinned favourites
  section with star toggles.
- **Spec details**: favourite star toggle; shared `displayName(l10n)`
  extension (local `_specName` switch removed); last-verified date; official
  source link.
- **Capture**: flash control cycling auto → always → off; failures swallowed
  via `.ignore()`; front/back switch; gallery import fallback without camera
  permission.
- **Editor**: RetouchScreen merged into EditorScreen as Crop / Background /
  Adjust modes; `/retouch` route removed with no dangling references;
  PopScope discard confirmation; `releaseImages()` on exit; crop-preserving
  `loadFromCapture`; live retouch preview. Covered by `editor_flow_test.dart`
  (main-isolate `_FakePipeline` — `compute` isolates never resume under
  fake-async widget tests).
- **Compliance**: StatusTile per-check rows with measured value, status,
  explanation and an actionable next step; never blocks export; never claims
  official approval.
- **Export**: share card, save actions, collapsible `_DetailsDisclosure`
  (file-size limit, formats, DPI); fake export success is impossible by
  construction (results come from the pipeline only).
- **History**: `AppEmptyState` empty state; yyyy-MM-dd dates;
  `historyMissingPhoto` label for missing files; reopen-in-editor action.
- **Settings**: grouped sections (appearance, language, privacy, about);
  destructive clear dialog with distinct destructive button; disclaimer row.

### §34–§35 — Uniform transitions + reduced motion
- All routes use the shared page transition from the router layer.
- `MediaQuery.disableAnimations` / OS "reduce motion" is respected — no
  transition or in-page animation runs when reduce-motion is active.

### §36 — Responsive / no overflow at 1.5× text scaling
- Small viewport (640×1136 logical @ 2 dpr) at `textScaleFactor == 1.5`
  renders onboarding, home, settings and history with **no RenderFlex
  overflow** (`tester.takeException()` is null), in both LTR (en) and
  RTL (ar).
- Landscape editor rail widened to 360 px; segment selector horizontally
  scrollable.
- Regression-guarded by `text_scaling_test.dart` (3 tests).

### §37–§39 — Rebuild discipline, isolates, memory
- Riverpod: narrow providers; screens read derived view-models, not whole
  state; verified by `perf_budget_test.dart`.
- All heavy image work (crop/rotate/retouch/encode) runs in background
  isolates via `compute`; under widget tests the pipeline provider is
  overridden with a main-isolate fake (documented in `editor_flow_test.dart`).
- Editor releases decoded images on exit (`releaseImages()`); reload
  preserves crop/face/retouch session state.

### §40 — Accessibility + RTL
- Icon buttons carry tooltips; primary actions meet the 48 dp minimum;
  navigation destinations expose localized semantics — asserted in
  `rtl_accessibility_test.dart`.
- The captured photo is **never mirrored** in RTL locales; only chrome
  (layout direction) flips.

### §41 — Golden tests + consistency audit
- Goldens in `test/goldens/goldens/`: home_light, home_dark, home_rtl,
  settings_light — generated with `--update-goldens` and validated with a
  plain `flutter test` run (all pass on this machine).
- Consistency audit: no stray colours/spacing/typography outside tokens
  (enforced by analyzer-clean codebase + golden review).

### §42 — Final acceptance
- `flutter analyze`: clean. `flutter test`: 249/249 green.
- README fully rewritten (features, privacy, screens, specs, tech stack,
  structure, run/build/test instructions, limitations).
- Store listing, privacy policy, privacy audit and product policy drafted in
  `docs/`.

## Known limitations (accepted, documented)

1. **Goldens are machine-specific** — anti-aliased text rasterization differs
   across platforms; regenerate with `flutter test --update-goldens` when
   switching machines.
2. **Web build is a UI demo** — `dart:io` paths (history file storage,
   compliance/export file work) degrade on web and camera/ML Kit are
   unavailable; the demoable surface is onboarding → home → country select →
   spec details → settings.
3. **`compute` isolates in widget tests** — never resume under fake async;
   tests override `imagePipelineProvider` with a main-isolate fake.
4. **Release APK not built in this pass** — per current instruction the web
   build is served instead; run `flutter build apk --release` on request
   (Android SDK 36 + JDK 17 are installed and ready).
5. **Device end-to-end flows** (`integration_test/`) are CI/device-only —
   no emulator or VS C++ toolchain on this machine.
