# Runkeeper Achievements

A medal case screen for Runkeeper, built with SwiftUI and MVVM.

## Architecture

- **View**: `AchievementsScreen` renders a two-column grid (`AchievementsGridView`), sectioned into categories (e.g. Personal Records, Virtual Races), with dedicated states for loading, empty, and error.
- **ViewModel**: `AchievementsViewModel` is an `@Observable` class exposing a `ViewState` (`idle` / `loading` / `loaded` / `error`) and a derived `sections` property. The view only ever reads state — it has no knowledge of networking.
- **Model**: `Achievement` and `AchievementCategory` are plain `Codable` structs decoded directly from the network response.

```
AchievementsScreen ── observes ──> AchievementsViewModel ── depends on ──> NetworkService (protocol)
                                                                                  │
                                                                     MockNetworkService (fixture-backed)
```

## Network layer

`NetworkService` is a small protocol (`fetchAchievements() async throws -> [Achievement]`), so the view model is testable and unaware of the concrete data source. `MockNetworkService` implements it against bundled JSON fixtures, with an injectable `Scenario` (`success`, `empty`, `error`, `slow`) to exercise every `ViewState` on demand — see `ScenarioDemoView`, reachable from Profile's Debug section in debug builds.

## Idealized response shape

Achievement categories are **server-driven**, not client-hardcoded:

```json
{
  "id": "personalRecord",
  "displayName": "Personal Records",
  "sortOrder": 0
}
```

The backend owns the category's display name and sort order, so adding, renaming, or reordering categories is purely a backend change — no client release required, and no client-side switch statement mapping category ids to display strings. `displayName`/`sortOrder` are required fields: a category missing either fails decoding loudly rather than silently guessing, since that would be a backend contract violation.

## Styling

`Styles/Colors`, `Styles/Fonts`, and `Styles/Spacing` define theme tokens (`primaryColor`, `secondaryFont`, `spacingOne`, etc.) matching the provided mock, used throughout the view layer instead of magic numbers/hex values.

## Tests

`AchievementsViewModelTests` covers every `MockNetworkService.Scenario`, category grouping/ordering, and the decoding contract for `AchievementCategory`.
