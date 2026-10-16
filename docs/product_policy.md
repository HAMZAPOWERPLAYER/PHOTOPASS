# PhotoPass Product Policy

Adopted 2026-10-15. This policy supersedes any earlier monetization plan.

## Product rules (permanent)

PhotoPass is a completely free, ad-free public utility:

- 100% free; zero ads, subscriptions, in-app purchases, paid features or paywalls
- No watermarks on any export
- No account or login; no artificial feature restrictions
- Every feature is available to every user, including custom dimensions,
  print sheets, high-resolution export, and all themes and languages

## Architecture consequences

The following must never appear in the codebase or dependencies:

- `google_mobile_ads`, UMP (advertising consent), `in_app_purchase`,
  RevenueCat / `purchases_flutter`
- Paywall screens, purchase routes, restore-purchase buttons
- Premium entitlement state, subscription logic, ad banners/interstitials

## Privacy

- Photos are processed on-device only; never uploaded or sent to any service
- No analytics, tracking, or advertising identifiers; no backend dependency
- Network access is permitted **only** for a future feature explicitly
  approved by the project owner; such a change must be documented and
  reviewed before implementation
- Bundled preset specs work offline; only external source links need internet

## Roadmap (revised)

1. Project setup, architecture, theme, localization scaffold, routing, lint ✅
2. Preset data model, JSON loader, validation, country/document search
3. Camera, gallery import, permissions, face-guide overlay
4. Face detection, crop engine, manual editor
5. On-device background removal, replacement, adjustments
6. Compliance checks and checklist interface
7. Free export engine: exact dimensions, compression, print sheets, PDF, sharing
8. Local history, settings, data deletion
9. Privacy audit, offline verification, performance tuning, security testing
10. Localization, accessibility, RTL testing
11. Integration testing, device testing, bug fixing
12. Icon, screenshots, store listing, privacy policy, release build

## Final rule

Never introduce advertisements, subscriptions, in-app purchases or paid
restrictions without explicit owner approval to change this policy.
