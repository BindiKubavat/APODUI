//
//  NetworkKitTests.swift
//  NetworkKitTests
//
//  Created by Bindi Kubavat on 18/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import XCTest
@testable import NetworkKit

class NetworkKitTests: XCTestCase {

    var sut: NetworkManager?
    var asyncExpectation: XCTestExpectation?
    
    override func setUp() {
        sut = NetworkManager.init(delegate: self)
        
    }

    override func tearDown() {
       sut = nil
    }

    func testAPICall() {
        asyncExpectation = XCTestExpectation(description: "To test the api call and the data")
        // Given the URL
        let url = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2011-11-11"

        // When we pass it into the method
        sut?.makeAPICall(responseType: TestAPODModel.self ,requestType: .get, url: url)
        
        wait(for: [asyncExpectation!], timeout: 5)
    }
    
    func testDecodable() {
        // Given the model
        let model = TestAPODModel.init()
        model.title = "Test title"
        
        let encoder = JSONEncoder.init()
        let data = try? encoder.encode(model)
        
        // when we parse it
        let newModel = try? sut?.decode(responseType: TestAPODModel.self, data: data ?? Data())
        
        // then the value should be equal
        XCTAssertEqual(newModel?.title, model.title)
    }

    func testImageDownloading() {
         asyncExpectation = XCTestExpectation(description: "To test the api call and the data")
     
        // given the url
        let url = "https://apod.nasa.gov/apod/image/1111/M83_HSTgendler600h.jpg"
        
        // When we download the image from a URL
        sut?.downloadImage(url: url, completion: { (imgData, erEnum) in
            // Then image data should come
            
            if imgData == nil || erEnum != nil {
                XCTAssert(false, "Error while downloading the image")
            }
            
            self.asyncExpectation?.fulfill()
        })
        wait(for: [asyncExpectation!], timeout: 5)
    }
}

extension NetworkKitTests: NetworkManagerDelegate {
    // Then result should be come
    func serviceResponded(with result: Result<Codable, EnumAPIError>) {
        switch result {
        case .success:
            asyncExpectation?.fulfill()
        case .failure:
            asyncExpectation = XCTestExpectation(description: "To test the api call and the data")
        }
    }
}
