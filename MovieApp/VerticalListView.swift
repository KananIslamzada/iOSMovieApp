//
//  VerticalListView.swift
//  MovieApp
//
//  Created by Kanan Islamzada on 29.07.26.
//

import SwiftUI
import SwiftData

struct VerticalListView: View {
    var titles: [Title]
    var isDownload:Bool? = false
    @State private var showRemoveAlert = false
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        GeometryReader { geo in
            List(titles) { title in
                
                NavigationLink {
                    TitleDetailView(title: title)
                }label: {
                    HStack {
                        AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 140)
                        
                        Text((title.name ?? title.title) ?? "")
                            .font(.system(size: 14))
                            .bold()
                        
                        Spacer()
                        
                    }
                    .frame(maxWidth: .infinity, minHeight: 150, alignment: .leading)
                    .contentShape(Rectangle())
                }
               
                .simultaneousGesture(
                        LongPressGesture().onEnded { _ in
                            if isDownload == true {
                                showRemoveAlert = true
                            }
                        }
                    )
                .alert("Want to remove \(title.name ?? title.title ?? "")?", isPresented: $showRemoveAlert) {
                    Button("Cancel", role: .cancel) { }
                        

                    Button("Remove", role: .destructive) {
                        deleteSavedTitle(id: title.id ?? 0, context: modelContext)
                    }
                }
                .tint(.white)
               
            }
        }
    }
}

#Preview {
    VerticalListView(titles:Title.previewTitles,isDownload: false)
}
