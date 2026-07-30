//
//  UpcomingView.swift
//  MovieApp
//
//  Created by Kanan Islamzada on 29.07.26.
//

import SwiftUI

struct UpcomingView: View {
    var viewModel = ViewModel()
    
 
    
    var body: some View {
        NavigationStack {
            GeometryReader {geo in
                switch viewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                        .frame(width: geo.size.width,height: geo.size.height)
                case .success:
                    VerticalListView(titles: viewModel.upcomingMovies)
                case .failed(let underlyingError):
                    Text(underlyingError.localizedDescription)
                }
            }
            .task {
                await viewModel.getUpcomingMovies()
            }
            .navigationDestination(for: Title.self){title in
                TitleDetailView(title: title)
            }
        }
       
    }

}

#Preview {
    UpcomingView()
}
