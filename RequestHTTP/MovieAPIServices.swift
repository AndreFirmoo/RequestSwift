//
//  MovieServicesAPI.swift
//  RequestHTTP
//
//  Created by ANDRE FIRMO on 27/03/21.
//

import Foundation

class MovieAPIServices {
    public static let shared = MovieAPIServices()
    
    private init() {}
    private let urlSession = URLSession.shared
    private let baseUrl = URL(string: "https://api.themoviedb.org/3/")!
    private let apiKey = "200973041619f1a673d25c9f0e03da8d"
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
     }()
    
    enum EndPoint: String {
        case nowPlaying = "now_playing"
        case upcomig
        case popular
        case topRated = "top_rated"
    }
    
    public enum APIServiceError: Error {
        case apiError
        case invalidEndPoint
        case invalidResponse
        case noData
        case decodeError
    }
    
    private func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        guard urlComponents.url != nil else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        urlSession.dataTask(with: urlComponents.url!) { [self]data, response, error in
            if error != nil {
                completion(.failure(APIServiceError.apiError))
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            if let data = data {
                do {
                    let values = try self.jsonDecoder.decode(T.self,  from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            }
           
        }.resume()
    }
    
    public func fetchMovies(from endpoint: EndPoint, result: @escaping (Result<MoviesResponse, APIServiceError>) -> Void) {
        let movieURL = baseUrl.appendingPathComponent("movie").appendingPathComponent(endpoint.rawValue)
        
        fetchResources(url: movieURL, completion: result)
    }
    public func fectchMovieByID(movieId: Int, result: @escaping (Result<Movie, APIServiceError>) -> Void) {
        let movieURL = baseUrl.appendingPathComponent("movie").appendingPathComponent(String(movieId))
        
        fetchResources(url: movieURL, completion: result)
    }
}
