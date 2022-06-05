//
//  FilmNetworkManager.swift
//  Movve
//
//  Created by Fed on 04.06.2022.
//
import UIKit
import Alamofire

struct NetworkManager {
    
    func fetchMovie() {
        
        AF.request(K.URL.urlMovie, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { (responseData) in
            guard let data = responseData.data else {return}
            do {
                let FilmData = try JSONDecoder().decode(FilmData.self, from: data)
                
                //                print(FilmData.results[0].original_title)
                //                print(FilmData.results[0].overview)
                //                print(FilmData.results[0].original_language)
                //                print(FilmData.results[0].release_date)
                //                print(FilmData.results[0].vote_average)m
                // Здесь нужно вернуть весь массив FilmData.results[0]
                
            } catch {
                print("Error with loadind Film list: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTV() {
        AF.request(K.URL.urlTv, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { (responseData) in
            guard let data = responseData.data else {return}
            do {
                let tvData = try JSONDecoder().decode(TvData.self, from: data)
                
//                print(tvData.results[0].original_name)
//                print(tvData.results[0].overview)
//                print(tvData.results[0].original_language)
//                print(tvData.results[0].first_air_date)
//                print(tvData.results[0].vote_average)
//                print(tvData.results[0].id)
                // Здесь нужно вернуть весь массив tvData.results[]
                
            } catch {
                print("Error with loading TV List: \(error.localizedDescription)")
            }
            
        }
    }
    
    
    func fetchActors(id: Int, cinemaType: String) {
        let apiRequest = "\(K.URL.urlActorFirst + cinemaType)/\(String(id) + K.URL.urlActorSecond)"
        
        AF.request(apiRequest, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { (responseData) in
            guard let data = responseData.data else {return}
            do {
                let tvActorData = try JSONDecoder().decode(ActorData.self, from: data)
                
                //print(tvActorData.cast[0].original_name)
                // Функцию нужно будет вызвать в вью моделе с подробностями о фильме, также нужно будет вернуть весь массив
            } catch {
                print("Error with loading info about Actors: \(error.localizedDescription)")
            }
            
        }
        
    }
    
    
    func fetchImage(image: String) {
        AF.download(K.URL.urlImage + image).responseData { (responce) in
            if let data = responce.value {
                let downloadedImage = UIImage(data: data)
                
                
            } else {
                print("Image Loading error")
                
            }
        }
    }
}
