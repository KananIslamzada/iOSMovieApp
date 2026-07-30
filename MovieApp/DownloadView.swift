//
//  DownloadView.swift
//  MovieApp
//
//  Created by Kanan Islamzada on 29.07.26.
//

import SwiftUI
import SwiftData

struct DownloadView: View {
    @Query var savedTitles: [Title]
    
    var body: some View {
        NavigationStack{
            if savedTitles.isEmpty{
                Text("No Downloads")
                    .padding()
                    .font(.title3)
                    .bold()
            } else{
                VerticalListView(titles: savedTitles,isDownload: true)
            }
        }
    }
}

#Preview {
    DownloadView()
}
