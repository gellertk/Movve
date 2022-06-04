//
//  Constants.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 03.06.2022.
//

import UIKit

struct K {
    
    struct Numeric {
        
        static let hightSectionImageHeight = CGFloat(190)
        static let lowSectionImageHeight = CGFloat(160)
        static let betweenImagesHeight = CGFloat(60)
        
    }
    
    struct Url {
        
        static let urlMovie = "https://api.themoviedb.org/3/discover/movie?api_key=7822759433d26b0333c1c26e943ac26f&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        
        static let urlTv = "https://api.themoviedb.org/3/discover/tv?api_key=7822759433d26b0333c1c26e943ac26f&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false&with_watch_monetization_types=flatrate&with_status=0&with_type=0"
        
        static let urlActorFirst = "https://api.themoviedb.org/3/"
        static let urlActorSecond = "/credits?api_key=7822759433d26b0333c1c26e943ac26f&language=en-US"
        
        static let urlImage = "https://image.tmdb.org/t/p/w300"
    }
    
    
}
