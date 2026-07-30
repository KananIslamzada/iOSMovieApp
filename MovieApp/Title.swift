//
//  Title.swift
//  MovieApp
//
//  Created by Kanan Islamzada on 28.07.26.
//

import SwiftData
import Foundation

struct TMDBAPIObject: Decodable {
    var results: [Title] = []
}

@Model
class Title: Decodable, Identifiable, Hashable {
    var id:Int?
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?
    
    init(id: Int? = nil, title: String? = nil, name: String? = nil, overview: String? = nil, posterPath: String? = nil) {
        self.id = id
        self.title = title
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
    }
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case name
        case overview
        case posterPath
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        
    }
    
    static var previewTitles = [
        Title(id: 1,title: "Beetle",name: "Beetle",overview: "A movie",posterPath: Constants.testTitleUrl),
        Title(id:2,title: "Toy Story",name: "Toy Story",overview: "A Toy story",posterPath: Constants.testTitleUrl2),
        Title(id: 3,title: "The Dark Knight",name: "The Dark Knight",overview: "A Batman film",posterPath: Constants.testTitleUrl3)
    ]
    
    

}

func movieExists(id: Int, context: ModelContext) -> Bool {
    let descriptor = FetchDescriptor<Title>(
        predicate: #Predicate { title in
            title.id == id
        }
    )

    do {
        let results = try context.fetch(descriptor)
        return !results.isEmpty
    } catch {
        print("Fetch failed:", error)
        return false
    }
}

func deleteSavedTitle(id: Int, context: ModelContext) {
    var descriptor = FetchDescriptor<Title>(
        predicate: #Predicate { saved in
            saved.id == id
        }
    )
    descriptor.fetchLimit = 1

    do {
        if let savedTitle = try context.fetch(descriptor).first {
            context.delete(savedTitle)
            try context.save()
        }
    } catch {
        print("Delete failed:", error)
    }
}

