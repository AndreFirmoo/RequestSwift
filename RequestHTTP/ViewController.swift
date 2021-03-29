//
//  ViewController.swift
//  RequestHTTP
//
//  Created by ANDRE FIRMO on 27/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
//            MovieAPIServices.shared.fetchMovies(from: .nowPlaying) { (result: Result<MoviesResponse, MovieAPIServices.APIServiceError>) in
//                switch result {
//                case .success(let movieResponse):
//                    print (movieResponse.results)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
            MovieAPIServices.shared.fectchMovieByID(movieId: 399566) {(result: Result<Movie, MovieAPIServices.APIServiceError>) in
                switch result {
                case .success(let movie):
                    print(movie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }


}

