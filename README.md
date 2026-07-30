# MovieApp

MovieApp is a SwiftUI iOS app for browsing movies and TV shows. It uses The Movie Database API for title data and YouTube search results to play trailers inside the app.

## Features

- Home screen with a featured title and horizontal sections for trending and top-rated content
- Upcoming movies screen
- Movie and TV search with a short debounce while typing
- Detail screen with title overview and an embedded YouTube trailer player
- Download/remove flow for saving titles locally
- Local persistence with SwiftData
- Custom Liquid Glass button styling for iOS 26

## Tech Stack

- Swift
- SwiftUI
- SwiftData
- Observation
- URLSession with async/await
- WebKit for embedded YouTube playback
- TMDB API
- YouTube Data API

## Requirements

- Xcode 26 or later
- iOS 26.0 or later
- TMDB API key
- YouTube Data API key

## Setup

1. Open `MovieApp.xcodeproj` in Xcode.
2. Add an `APIConfig.json` file to the `MovieApp` target if it is not already present.
3. Configure the API values using this shape:

```json
{
  "tmdbBaseUrl": "https://api.themoviedb.org/",
  "tmdbAPIKey": "YOUR_TMDB_API_KEY",
  "youtubeBaseURL": "https://www.youtube.com/embed/",
  "youtubeAPIKey": "YOUR_YOUTUBE_API_KEY",
  "youtubeSearchURL": "YOUR_YOUTUBE_SEARCH_URL"
}
```

4. Build and run the app in Xcode.

## Project Structure

```text
MovieApp/
  APIConfig.swift
  ContentView.swift
  DataFetcher.swift
  HomeView.swift
  SearchView.swift
  TitleDetailView.swift
  UpcomingView.swift
  DownloadView.swift
  ViewModel.swift
  SearchViewModel.swift
  YoutubePlayer.swift
```

## Notes

- `APIConfig.json` must be included in the app bundle because `APIConfig.swift` loads it with `Bundle.main.url(forResource:withExtension:)`.
- Do not commit real API keys to a public repository. Use placeholder values or keep local secrets out of Git.
- The current deployment target is iOS 26, so Liquid Glass APIs can be used directly. If the deployment target is lowered later, wrap iOS 26-only APIs in availability checks.
