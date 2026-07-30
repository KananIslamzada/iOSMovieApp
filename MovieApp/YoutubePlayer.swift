//
//  YoutubePlayer.swift
//  MovieApp
//
//  Created by Kanan Islamzada on 28.07.26.
//

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    let webView = WKWebView()
    let videoId:String
    let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL
    
    func makeUIView(context: Context) -> some UIView {
        webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let baseURLString = youtubeBaseURL,
              let baseURL = URL(string: baseURLString) else {return}
        let fullURL = baseURL.appending(path: videoId)

        let bundleId = Bundle.main.bundleIdentifier ?? ""
            let referrer = "https://\(bundleId)".lowercased()
            let referrerUrl = URL(string: referrer)!

            var request = URLRequest(url: fullURL)
            request.addValue(referrerUrl.absoluteString, forHTTPHeaderField: "Referer")
            request.addValue(referrerUrl.absoluteString, forHTTPHeaderField: "origin")
        webView.load(request)
    }
}
