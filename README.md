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

## Environment

- Xcode 26.6 (17F113)
- macOS 26.5.2
- iOS 26.5 deployment target

## Running

1. Open `Runkeeper_achievements.xcodeproj` in Xcode.
2. Select the `Runkeeper_achievements` scheme and any iOS 26.5+ simulator.
3. Build & run (`Cmd+R`).
4. From the Profile screen, tap **Achievements**, or expand the **Debug** section to open **Scenario Demo** and pick a `MockNetworkService` scenario (success, empty, error, slow) to exercise any `ViewState`.

To run tests: `Cmd+U`, or `xcodebuild -scheme Runkeeper_achievements -destination 'platform=iOS Simulator,name=<simulator>' test`.
