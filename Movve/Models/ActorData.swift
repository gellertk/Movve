//
//  Actor.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import Foundation

struct ActorData: Codable {
    
    let cast: [ActorResult]
}

struct ActorResult: Codable {
    
    let original_name: String        // Имя актера
    let character: String            //Кого играет
    let profile_path: String         //фото актера
}
