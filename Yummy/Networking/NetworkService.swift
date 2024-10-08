//
//  NetworkService.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 13/08/2024.
//

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    // MARK: - Fetch all categories
    func fetchAllCategories(completion: @escaping(Result<AllDishes, Error>) -> Void){
        requests(route: .fetchAllCategories, method: .get, completion: completion)
    }
    
    // MARK: - Place order
    func placeOrder(dishId: String, name: String, completion: @escaping(Result<Order, Error>) -> Void) {
        let params = ["name": name]
        
        requests(route: .placeOrder(dishId), method: .post, parameters: params, completion: completion)
    }
    
    // MARK: - fetch category dishes
    func fetchCategorydishes(categoryId: String, completion: @escaping(Result<[Dish], Error>) -> Void){
        requests(route: .fetchCategoryDishes(categoryId), method: .get, completion: completion)
    }
    
    func fetchOrders(completion: @escaping(Result<[Order], Error>) -> Void) {
        requests(route: .fetchOrders, method: .get, completion: completion)
    }
    
    private func requests<T: Codable>(route: Route,
                                      method: Method,
                                      parameters: [String: Any]? = nil,
                                      completion: @escaping(Result<T, Error>) -> Void){
        
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringfy our data"
                print("The response is: \(responseString)")
            }else if let error = error {
                print("The error is \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.handleRequest(result: result, completion: completion)
            }
        }.resume()
    }
    
    private func handleRequest<T: Codable>(result: Result<Data, Error>?, completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }
            
            if let decodedData = response.data {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.unknownError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    /// This func help us to generate URLRequest
    /// - Parameters:
    ///   - route: the path to the resource in the backend
    ///   - method: The type or the request method
    ///   - parameters: Whatever extra prameters you want to pass to the backend
    /// - Returns: Return the URLRequest after preparing it
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
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
