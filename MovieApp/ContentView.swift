//
//  ContentView.swift
//  MovieApp
//
//  Created by Kanan Islamzada on 27.07.26.
//

import SwiftUI


struct ContentView: View {
 
     
    var body: some View {
        TabView{
            Tab(Constants.homeString,systemImage:Constants.homeIconString){
                HomeView()
            }
            Tab(Constants.upcomingString,systemImage: Constants.upcomingIconString){
                UpcomingView()
            }
            Tab(Constants.searchString,systemImage: Constants.searchIconString){
                SearchView()
            }
            Tab(Constants.downloadString,systemImage: Constants.downloadIconString){
               DownloadView()
            }
            
        }
        .tint(.buttonBorder)
        .onAppear{
            
            if let config = APIConfig.shared{
                
                print(config.tmdbAPIKey)
                print(config.tmdbBaseUrl)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
