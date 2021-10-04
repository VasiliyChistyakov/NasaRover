//
//  NetworkingManager.swift
//  NasaRover
//
//  Created by Чистяков Василий Александрович on 27.09.2021.
//

import Foundation
import UIKit

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() { }
    
    func fetchData(url: String, complitionHandler: @escaping (Model)-> Void) {
    
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response , error in
            guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode(Model.self, from: data)
                complitionHandler(model)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fecthImage(urlString: String, complitionHandler: @escaping (UIImage)-> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response , error in
            guard let data = data, let iamge = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                complitionHandler(iamge)
            }
        }.resume()
    }
}

//    func fetchJson(data: Data, complitionHandler: @escaping (Model)-> Void ) {
//        let json = JSONDecoder()
//        do {
//            let model =  try json.decode(Model.self, from: data)
//            complitionHandler(model)
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }

