//
//  ReportsFetcher.swift
//  CoronaTracker
//
//  Created by Lucas Stettner on 3/8/20.
//  Copyright © 2020 Lucas Stettner. All rights reserved.
//

import Combine
import SwiftUI
import Foundation

class ReportsFetcher: NSObject, ObservableObject {
    private static let apiUrlString = "http://localhost:8080/all"
    var didChange = PassthroughSubject<ReportsFetcher, Never>()
    
    var state: LoadableState<Root> = .loading {
        didSet {
            didChange.send(self)
        }
    }
    
    override init() {
        super.init()
        
        guard let apiUrl = URL(string: ReportsFetcher.apiUrlString) else {
            state = .fetched(.failure(.error("Malformed API URL.")))
            return
        }
        
        URLSession.shared.dataTask(with: apiUrl) { [weak self] (data, _, error) in
            if let error = error {
                self?.state = .fetched(.failure(.error(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                self?.state = .fetched(.failure(.error("Malformed response data")))
                return
            }
            
            let root = try! JSONDecoder().decode(Root.self, from: data)
            
            DispatchQueue.main.async { [weak self] in
                self?.state = .fetched(.success(root))
            }
        }.resume()
    }
}

struct Root: Decodable {
    var reports: [Report]
}

struct Report: Decodable & Identifiable {
    var id: Int
    
    let description, type, location: String
}


enum LoadableState<T> {
    case loading
    case fetched(Result<T, FetchError>)
}

enum FetchError: Error {
    case error(String)
    
    var localizedDescription: String {
        switch self {
        case .error(let message):
            return message
        }
    }
}
