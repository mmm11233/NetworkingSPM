//
//  WebServiceManager.swift
//  CatsApp
//
//  Created by Mariam Joglidze on 19.11.23.
//

import Foundation

public protocol WebServiceManaging: AnyObject {
    func httpGet<T: Decodable>(url: URL, completion: @escaping ((Result<T, Error>) -> Void))
}

public class WebServiceManger: WebServiceManaging {
    
    public init() {}
    
    public func httpGet<T: Decodable>(url: URL, completion: @escaping ((Result<T, Error>) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
}
