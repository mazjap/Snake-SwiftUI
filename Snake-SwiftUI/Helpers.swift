//
//  Helpers.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 12/6/20.
//

import Foundation

extension BinaryInteger {
    @discardableResult
    static postfix func ++ (lhs: inout Self) -> Self {
        lhs += 1
        
        return lhs
    }
    
    @discardableResult
    static postfix func -- (lhs: inout Self) -> Self {
        lhs -= 1
        
        return lhs
    }
    
    @discardableResult
    static postfix func ++ (lhs: Self) -> Self {
        return lhs + 1
    }
    
    @discardableResult
    static postfix func -- (lhs: Self) -> Self {
        return lhs - 1
    }
}

extension BinaryFloatingPoint {
    @discardableResult
    static postfix func ++ (lhs: inout Self) -> Self {
        lhs += 1
        
        return lhs
    }
    
    @discardableResult
    static postfix func -- (lhs: inout Self) -> Self {
        lhs -= 1
        
        return lhs
    }
    
    @discardableResult
    static postfix func ++ (lhs: Self) -> Self {
        return lhs + 1
    }
    
    @discardableResult
    static postfix func -- (lhs: Self) -> Self {
        return lhs - 1
    }
}
