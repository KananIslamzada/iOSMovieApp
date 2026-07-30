//
//  Constants.swift
//  MovieApp
//
//  Created by Kanan Islamzada on 27.07.26.
//

import Foundation
import SwiftUI

struct Constants {
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downloadString = "Download"
    static let removeString = "Remove"
    static let playString = "Play"
    static let trendingMovieString = "Trending Movies"
    static let trendingTVString = "Trending TV"
    static let topRatedMovieString = "Top Rated Movies"
    static let topRatedTVString = "Top Rated TV"
    static let movieSearchString = "Movie Search"
    static let tvSearchString = "TV Search"
    static let moviePlaceHolderString = "Search for a Movie"
    static let tvPlaceHolderString = "Search for a TV Show"
    
    
    static let homeIconString = "house"
    static let upcomingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let downloadIconString = "arrow.down.to.line"
    static let tvIconString = "tv"
    static let movieIconString = "movieclapper"
    
    static let testTitleUrl = "https://m.media-amazon.com/images/M/MV5BZTA3OWVjOWItNjE1NS00NzZiLWE1MjgtZDZhMWI1ZTlkNzYwXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"
    static let testTitleUrl2 = "https://m.media-amazon.com/images/M/MV5BMjgyYjgyMWYtOGE2MC00ZjVlLWFkMWQtN2E3ZWRmNDVkMjFlXkEyXkFqcGc@._V1_.jpg"
    static let testTitleUrl3 = "https://m.media-amazon.com/images/M/MV5BZTI1YTBiNmEtYWUxZi00YzFkLWIzNjMtMmZjMmY2NzM0ZWMzXkEyXkFqcGc@._V1_.jpg"
    
    static let posterURLStart = "https://image.tmdb.org/t/p/w500"
    
    static func addPosterPath(to titles: inout[Title]){
        for index in titles.indices {
            if let path = titles[index].posterPath {
                titles[index].posterPath = Constants.posterURLStart + path
            }
        }
    }

}


enum YoutubeURLStrings:String {
    case trailer = "trailer"
    case queryShorten = "q"
    case space = " "
    case key = "key"
}

extension Text {
    func ghostButton() -> some View {
        self
            .foregroundStyle(.buttonText)
            .bold()
            .frame(width: 100,height: 50)
            .background{
            RoundedRectangle(cornerRadius: 20,style: .continuous)
                .stroke(.buttonBorder,lineWidth: 5)
            }
    }
}

extension Image {
    func heroTitle ()-> some View {
        self
            .resizable()
            .scaledToFit()
            .overlay {
                LinearGradient(
                    stops: [Gradient.Stop(color: .clear, location: 0.8),
                            Gradient.Stop(color: .gradient, location: 1)
                           ],
                    startPoint: .top,
                    endPoint: .bottom)
            }
    }
}

extension View {
    func liquidGlassButton() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.buttonBorder)
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .glassEffect(.regular.interactive(), in: Capsule())
           
    }
}
