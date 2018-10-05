//
//  Weakable.swift
//  WeakableSelf
//
//  Created by Vincent on 04/10/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import Foundation

public protocol Weakable: class { }

extension NSObject: Weakable { }

public extension Weakable {
    
    public func weakify(_ code: @escaping (Self) -> Void) -> () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            
            code(self)
        }
    }
    
    public func weakify<A>(_ code: @escaping (Self, A) -> Void) -> (A) -> Void {
        return { [weak self] a in
            guard let self = self else { return }
            
            code(self, a)
        }
    }
    
    public func weakify<A, B>(_ code: @escaping (Self, A, B) -> Void) -> (A, B) -> Void {
        return { [weak self] a, b in
            guard let self = self else { return }
            
            code(self, a, b)
        }
    }
    
    public func weakify<A, B, C>(_ code: @escaping (Self, A, B, C) -> Void) -> (A, B, C) -> Void {
        return { [weak self] a, b, c in
            guard let self = self else { return }
            
            code(self, a, b, c)
        }
    }
    
    public func weakify<A, B, C, D>(_ code: @escaping (Self, A, B, C, D) -> Void) -> (A, B, C, D) -> Void {
        return { [weak self] a, b, c, d in
            guard let self = self else { return }
            
            code(self, a, b, c, d)
        }
    }
    
    public func weakify<A, B, C, D, E>(_ code: @escaping (Self, A, B, C, D, E) -> Void) -> (A, B, C, D, E) -> Void {
        return { [weak self] a, b, c, d, e in
            guard let self = self else { return }
            
            code(self, a, b, c, d, e)
        }
    }
    
    public func weakify<A, B, C, D, E, F>(_ code: @escaping (Self, A, B, C, D, E, F) -> Void) -> (A, B, C, D, E, F) -> Void {
        return { [weak self] a, b, c, d, e, f in
            guard let self = self else { return }
            
            code(self, a, b, c, d, e, f)
        }
    }
    
    public func weakify<A, B, C, D, E, F, G>(_ code: @escaping (Self, A, B, C, D, E, F, G) -> Void) -> (A, B, C, D, E, F, G) -> Void {
        return { [weak self] a, b, c, d, e, f, g in
            guard let self = self else { return }
            
            code(self, a, b, c, d, e, f, g)
        }
    }
}
