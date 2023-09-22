//
//  BaseNetworkCall.swift
//  Astra
//
//  Created by Amit Shah on 22/09/23.
//

import UIKit

struct ApiHandler{
    
    func request(comp: @escaping(Bool, Data?)-> Void){
        
        var request = URLRequest(url: URL(string: "https://www.omdbapi.com/?apikey=2c0d1dab&s=dark")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
              comp(false, nil)
            return
          }
            
          comp(true, data)
            
        }

        task.resume()
    }
}
