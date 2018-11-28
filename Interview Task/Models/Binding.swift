//
//  Binding.swift
//  Interview Task
//
//  Created by Apple on 11/27/18.
//  Copyright © 2018 Dtech. All rights reserved.
//

import Foundation

class  Binding<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value:T{
        didSet {
            listener?(value)
        }
    }
    init(_ value:T) {
        self.value=value
        
    }
    func bind(listener:Listener?){
        self.listener=listener
        listener?(value)
        
    }
}
