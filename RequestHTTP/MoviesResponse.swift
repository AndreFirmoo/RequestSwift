//
//  Data.swift
//  RequestHTTP
//
//  Created by ANDRE FIRMO on 27/03/21.
//

import Foundation


struct MoviesResponse: Codable {
    public let page: Int
    public let totalPages: Int
    public let results: [Movie]
    
}

struct Movie: Codable {
    public let id: Int
    public let adult: Bool
    public let title: String
    public let overview: String
    public let posterPath: String
    public let voteAverage: Double
    public let releaseDate: String
}
