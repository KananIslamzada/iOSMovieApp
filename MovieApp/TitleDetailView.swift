//
//  TitleDetailView.swift
//  MovieApp
//
//  Created by Kanan Islamzada on 28.07.26.
//

import SwiftUI
import SwiftData

struct TitleDetailView: View {
    let title: Title
    var titleName:String {
        return (title.name ?? title.title) ?? ""
    }
    @State private var hasDownloaded: Bool? = nil
    
    let viewModel = ViewModel()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    switch viewModel.videoIdStatus {
                    case .notStarted, .fetching:
                        ZStack {
                               Color.black

                               ProgressView()
                           }
                           .frame(width: geometry.size.width)
                           .aspectRatio(1.3, contentMode: .fit)
                        
                    case .success:
                        YoutubePlayer(videoId: viewModel.videoId)
                            .aspectRatio(1.3, contentMode: .fit)
                        
                    case .failed(let error):
                        Text(error.localizedDescription)
                            .frame(width: geometry.size.width)
                            .aspectRatio(1.3, contentMode: .fit)
                    }
                    
                    Text(titleName)
                        .bold()
                        .font(.title2)
                        .padding(5)
                    
                    Text(title.overview ?? "")
                        .padding(5)
                    
                    HStack {
                        Spacer()
                        
                        if let isDownloaded = hasDownloaded {
                            Button {
                                if isDownloaded {
                                    deleteSavedTitle(id: title.id ?? 0, context: modelContext)
                                    self.hasDownloaded = false
                                } else {
                                    let savedTitle = Title(
                                        id: title.id,
                                        title: title.title,
                                        name: title.name,
                                        overview: title.overview,
                                        posterPath: title.posterPath
                                    )
                                    
                                    modelContext.insert(savedTitle)
                                    try? modelContext.save()
                                    self.hasDownloaded = true
                                }
                            } label: {
                                Text(isDownloaded ? Constants.removeString : Constants.downloadString)
                                    .liquidGlassButton()
                            }
                        } else {
                            ProgressView()
                        }
                        
                        Spacer()
                    }
                }
            }
        }
        .task {
            hasDownloaded = movieExists(id: title.id ?? 0, context: modelContext)
            await viewModel.getVideoId(for: titleName)
        }
        
    }
}


#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
