//
//  Observable.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 27.03.22.
//

import Foundation

class Observable<T> {
    typealias Listener = (_ value: T, _ oldValue: T?) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            self.listener?(value, oldValue)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value, nil)
    }
}
