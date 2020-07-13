//
//  Results.swift
//  TopAlbums
//
//  Created by Shreenath on 05/07/20.
//

import Foundation

struct Results: Codable {
    
    let artistName: String?
    let id: String?
    let releaseDate: String?
    let name: String?
    let kind: String?
    let copyright: String?
    let artistId: String?
    let contentAdvisoryRating: String?
    let artistUrl: String?
    let artworkUrl100: String?
    let genres: [Genres]?
    let url: String?
    
    private enum CodingKeys: String, CodingKey {
        case artistName = "artistName"
        case id = "id"
        case releaseDate = "releaseDate"
        case name = "name"
        case kind = "kind"
        case copyright = "copyright"
        case artistId = "artistId"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case artistUrl = "artistUrl"
        case artworkUrl100 = "artworkUrl100"
        case genres = "genres"
        case url = "url"
    }
}

struct Feed: Codable {
    
    let results: [Results]?
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct Genres: Codable {
    
    let genreId: String?
    let name: String?
    let url: String?
    
    private enum CodingKeys: String, CodingKey {
        case genreId = "genreId"
        case name = "name"
        case url = "url"
    }
}
