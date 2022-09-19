//
//  NetworkManager.swift
//  NetworkKit
//
//  Created by Bindi Kubavat on 18/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation

// This is a custom enum to handle the user defined errors
public enum EnumAPIError: Error {
    case invalidURL
    case other(error: Error)
    case unothorised(errorCode: Int)
    case noDataReturned
    case dataParsingFailed(error: Error)
    case unableToDownloadImage
    case dateOutOfRange
}

// Enum for HTTPMethod
public enum HTTPRequestType: String {
    case get = "GET"
    case post = "POST"
}

// Protocol for sharing the network layer result
public protocol NetworkManagerDelegate {
    func serviceResponded(with result: Result<Codable, EnumAPIError>)
}

// This is a Single Responsibility network calss being used for network interaction
public class NetworkManager {
    
    let session: URLSession!
    var delegate: NetworkManagerDelegate?

    // Dependency inversion by adding a protocol as a dependancy
    public init(delegate: NetworkManagerDelegate) {
        self.delegate = delegate
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = false
        session = URLSession.init(configuration: config)
    }

    // A generic method for parsing the codable type and handle data Task
    public func makeAPICall<T: Codable>(responseType: T.Type, requestType: HTTPRequestType, url: String,  parameter: [String: Any]? = nil) {
        
        guard let urlVal = URL.init(string: url) else {
            delegate?.serviceResponded(with: .failure(.invalidURL))
            return
        }
        print("=============")
        print(url)
        
        var request = URLRequest.init(url: urlVal)
        request.httpMethod = requestType.rawValue
        
        session.dataTask(with: request) { (data, response, error) in
            if let errorVal = error {
                self.delegate?.serviceResponded(with: .failure(.other(error: errorVal)))
                return
            }
            
//            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
//            guard 200..<300 ~= code else {
//                self.delegate?.serviceResponded(with: .failure(.unothorised(errorCode: code)))
//                return
//            }
//            
            guard let dataVal = data else {
                self.delegate?.serviceResponded(with: .failure(.noDataReturned))
                return
            }
    
                do {
                    let obj = try  self.decode(responseType: responseType.self , data: dataVal)
                    self.delegate?.serviceResponded(with: .success(obj))
                } catch let error as NSError {
                    self.delegate?.serviceResponded(with: .failure(.dataParsingFailed(error: error)))
                }
        }
        .resume()
    }
    
    // User this method to donload the image data
  public  func downloadImage(url: String, completion: @escaping (Data?,EnumAPIError?) -> Void) {
        guard let urlVal = URL.init(string: url) else {
            completion(nil, .invalidURL)
            return
        }
        session.dataTask(with: urlVal) { (data, response, er) in
            guard let dataVal = data else {
                completion(nil, .noDataReturned)
                return
            }
            completion(dataVal, nil)
        }.resume()
    }
    
    // Generic decode method, considering it might throw an error
    func decode<T: Codable>(responseType: T.Type, data: Data) throws ->  T? {
        let decode = JSONDecoder.init()
        do {
            let object = try decode.decode(T.self, from: data)
            return object
        }
        catch {
            throw error
        }
    }
    
}
