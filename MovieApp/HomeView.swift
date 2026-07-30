//
//  HomeView.swift
//  MovieApp
//
//  Created by Kanan Islamzada on 27.07.26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    let viewModel = ViewModel()
    
    @State private var titleDetailPath = NavigationPath()
    @Environment(\.modelContext) var modelContext
    @State private var hasDownloaded:Bool? = nil
    
    var body: some View {
        NavigationStack(path: $titleDetailPath) {
            GeometryReader {geo in
                ScrollView(.vertical) {
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width,height: geo.size.height)
                    case .success:
                        LazyVStack {
                            AsyncImage(url:URL(string: viewModel.heroTitle.posterPath ?? "")){ image  in
                                image
                                    .heroTitle()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                                
                            }
                            .frame(width: geo.size.width,height: geo.size.height * 0.85)
                            
                            HStack {
                                Button {
                                    titleDetailPath.append(viewModel.heroTitle)
                                    
                                }label: {
                                    Text(Constants.playString)
                                        .liquidGlassButton()
                                    
                                }
                                if let hasDownloaded {
                                Button {
                                    if hasDownloaded {
                                        deleteSavedTitle(id: viewModel.heroTitle.id ?? 0, context: modelContext)
                                        self.hasDownloaded = false
                                    }else {
                                        let savedTitle = Title(
                                            id: viewModel.heroTitle.id,
                                            title: viewModel.heroTitle.title,
                                            name: viewModel.heroTitle.name,
                                            overview: viewModel.heroTitle.overview,
                                            posterPath: viewModel.heroTitle.posterPath
                                        )
                                        modelContext.insert(savedTitle)
                                        try? modelContext.save()
                                        self.hasDownloaded = true
                                    }
                                    
                                }label: {
                                    Text(hasDownloaded ? Constants.removeString:Constants.downloadString)
                                        .liquidGlassButton()
                                }
                                } else {
                                    ProgressView()
                                }
                            }
                            HorizontalListView(header: Constants.trendingMovieString,titles: viewModel.trendingMovies){title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedTVString,titles: viewModel.topRatedTV){title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedMovieString,titles: viewModel.topRatedMovies){title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.trendingTVString,titles: viewModel.trendingTV){title in
                                titleDetailPath.append(title)
                            }
                            
                        }
                        
                    case .failed(let underlyingError):
                        Text("Error: \(underlyingError.localizedDescription)")
                    }
                }
                .task {
                    await viewModel.getTitles()
                    hasDownloaded = movieExists(id: viewModel.heroTitle.id ?? 0, context: modelContext)
                }
                .navigationDestination(for: Title.self) { title in
                    TitleDetailView(title: title)
                }
                
            }
            .ignoresSafeArea(edges: .top)

        }
    }

}

#Preview {
    HomeView()
}
