//
//  APIFacade.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 20/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

class URLComposer {
    
    private var currentString =  "https://rickandmortyapi.com/api/"
    func withCharacters() -> URLComposer {
        self.currentString += "characters/"
        
        return self
    }
    
    func toURL() -> URL { URL(string: self.currentString)! }
    
}

class APIFacade {
    
    var session: URLSession!
    
    init() {
        self.session = URLSession(configuration: .default)
    }
    
    func doGet(_ url: URL, body: Data? = nil, completion: @escaping (Data?, Error?) -> () ) {
        
        var request = URLRequest(url:url)

        request.httpMethod = "GET"
        request.httpBody = body
        
        
        self.session.dataTask(with: request) { data, response, error in

            print("[API] Recvd!", url)
            guard let data = data, let response = response as? HTTPURLResponse else {
                
                completion(nil, error)
                
                return
            }
            
            guard response.statusCode == 200 else {
                completion(nil, APIError.wrongMethod(response.statusCode))
                return
            }
            
            guard let deserialized = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("OPS!", String(data: data, encoding: .utf8))
                completion(nil, APIError.failedToParseJSON)
                return
                
            }
            
            let isSuccess = (deserialized["status"] as! String) != "error"
            
            if isSuccess {

                
                let payload = try! JSONSerialization.data(withJSONObject: deserialized["payload"], options: [])

                completion(payload, nil)
                return
            }
            
            completion(nil, APIError.runtimeError(deserialized["payload"] as! String ))
            
        }.resume()
        print("[API] Fired!", url)
        
    }
    
    
    func validateAndCompleteRequest<T: Codable>(data: Data?, error: Error?, completion: @escaping (T?, Error?) -> ()) {
        
        guard let data = data else {
            completion(nil, error)
            return
        }
        
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("troxa")
        }
        
        completion(decoded, nil)
    }
    
    // MARK: - GET Characters
    func getCharacters(url: URL, completion: @escaping ([Character]?, Error?) -> ()) {
        
        self.doGet(url) { (data, error) in
            self.validateAndCompleteRequest(data: data, error: error, completion: completion)
        }
    }
    
}
