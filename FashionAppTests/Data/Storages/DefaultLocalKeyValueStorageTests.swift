//
//  DefaultLocalKeyValueStorageTests.swift
//  FashionAppTests
//
//  Created by Azat Kaiumov on 28.05.22.
//

import XCTest
@testable import FashionApp

class DefaultLocalKeyValueStorageTests: XCTestCase {
    
    var storage: LocalKeyValueStorage!
    
    override func setUp() async throws {

        storage = DefaultLocalKeyValueStorage()
    }
    
    func test_get_not_existing_key() {
        
        XCTAssertNil(storage.getItem(key: "test", as: String.self))
    }
    
    func test_remove_not_existing_key() {
        
        XCTAssertNoThrow({
            self.storage.removeItem(key: "test")
        })
    }
    
    func test_remove_existing_key() {
        
        storage.setItem(key: "test1", value: "value1")
        storage.setItem(key: "test2", value: "value2")
        
        storage.removeItem(key: "test1")
        
        XCTAssertNil(storage.getItem(key: "test1", as: String.self))
        XCTAssertEqual(storage.getItem(key: "test2", as: String.self), "value2")
    }

    func test_set_get_item() {
        
        storage.setItem(key: "test1", value: "value1")
        storage.setItem(key: "test2", value: "value2")
        
        XCTAssertEqual(storage.getItem(key: "test1", as: String.self), "value1")
        XCTAssertEqual(storage.getItem(key: "test2", as: String.self), "value2")
    }
}
