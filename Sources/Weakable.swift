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
    func weakify<ReturnType>(defaultValue: ReturnType, _ code: @escaping (Self) -> ReturnType) -> () -> ReturnType {
        return { [weak self] in
            guard let self = self else { return defaultValue }

            return code(self)
        }
    }

    func weakify(_ code: @escaping (Self) -> Void) -> () -> Void {
        return weakify(defaultValue: (), code)
    }

    func weakify<ReturnType, A>(defaultValue: ReturnType, _ code: @escaping (Self, A) -> ReturnType) -> (A) -> ReturnType {
        return { [weak self] a in
            guard let self = self else { return defaultValue }

            return code(self, a)
        }
    }

    func weakify<A>(_ code: @escaping (Self, A) -> Void) -> (A) -> Void {
        return weakify(defaultValue: (), code)
    }

    func weakify<ReturnType, A, B>(defaultValue: ReturnType, _ code: @escaping (Self, A, B) -> ReturnType) -> (A, B) -> ReturnType {
        return { [weak self] a, b in
            guard let self = self else { return defaultValue }

            return code(self, a, b)
        }
    }
    
    func weakify<A, B>(_ code: @escaping (Self, A, B) -> Void) -> (A, B) -> Void {
        return weakify(defaultValue: (), code)
    }

    func weakify<ReturnType, A, B, C>(defaultValue: ReturnType, _ code: @escaping (Self, A, B, C) -> ReturnType) -> (A, B, C) -> ReturnType {
        return { [weak self] a, b, c in
            guard let self = self else { return defaultValue }

            return code(self, a, b, c)
        }
    }
    
    func weakify<A, B, C>(_ code: @escaping (Self, A, B, C) -> Void) -> (A, B, C) -> Void {
        return weakify(defaultValue: (), code)
    }

    func weakify<ReturnType, A, B, C, D>(defaultValue: ReturnType, _ code: @escaping (Self, A, B, C, D) -> ReturnType) -> (A, B, C, D) -> ReturnType {
        return { [weak self] a, b, c, d in
            guard let self = self else { return defaultValue }

            return code(self, a, b, c, d)
        }
    }

    func weakify<A, B, C, D>(_ code: @escaping (Self, A, B, C, D) -> Void) -> (A, B, C, D) -> Void {
        return weakify(defaultValue: (), code)
    }

    func weakify<ReturnType, A, B, C, D, E>(defaultValue: ReturnType, _ code: @escaping (Self, A, B, C, D, E) -> ReturnType) -> (A, B, C, D, E) -> ReturnType {
        return { [weak self] a, b, c, d, e in
            guard let self = self else { return defaultValue }

            return code(self, a, b, c, d, e)
        }
    }

    func weakify<A, B, C, D, E>(_ code: @escaping (Self, A, B, C, D, E) -> Void) -> (A, B, C, D, E) -> Void {
        return weakify(defaultValue: (), code)
    }

    func weakify<ReturnType, A, B, C, D, E, F>(defaultValue: ReturnType, _ code: @escaping (Self, A, B, C, D, E, F) -> ReturnType) -> (A, B, C, D, E, F) -> ReturnType {
        return { [weak self] a, b, c, d, e, f in
            guard let self = self else { return defaultValue }

            return code(self, a, b, c, d, e, f)
        }
    }

    func weakify<A, B, C, D, E, F>(_ code: @escaping (Self, A, B, C, D, E, F) -> Void) -> (A, B, C, D, E, F) -> Void {
        return weakify(defaultValue: (), code)
    }

    func weakify<ReturnType, A, B, C, D, E, F, G>(defaultValue: ReturnType, _ code: @escaping (Self, A, B, C, D, E, F, G) -> ReturnType) -> (A, B, C, D, E, F, G) -> ReturnType {
        return { [weak self] a, b, c, d, e, f, g in
            guard let self = self else { return defaultValue }

            return code(self, a, b, c, d, e, f, g)
        }
    }

    func weakify<A, B, C, D, E, F, G>(_ code: @escaping (Self, A, B, C, D, E, F, G) -> Void) -> (A, B, C, D, E, F, G) -> Void {
        return weakify(defaultValue: (), code)
    }
}
