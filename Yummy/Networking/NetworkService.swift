//
//  NetworkService.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 13/08/2024.
//

import Foundation

struct NetworkService {
    
    /// This func help us to generate URLRequest
    /// - Parameters:
    ///   - route: the path to the resource in the backend
    ///   - method: The type or the request method
    ///   - parameters: Whatever extra prameters you want to pass to the backend
    /// - Returns: Return the URLRequest after preparing it
    func createRequest(route: Route, method: Method, parameters: [String: Any]?) -> URLRequest? {
        let urlString = Route.baseURL + route.description
        guard let url = urlString.asURL else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map{URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
