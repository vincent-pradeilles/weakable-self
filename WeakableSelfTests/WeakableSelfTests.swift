//
//  WeakableSelfTests.swift
//  WeakableSelfTests
//
//  Created by Vincent on 04/10/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import XCTest
@testable import WeakableSelf

private var producerWasDeinit = false
private var consumerWasDeinit = false

private class Producer: NSObject {
    
    deinit {
        producerWasDeinit = true
    }
    
    private var handlerZeroArg: () -> Void = { }
    private var handlerZeroArgReturn: () -> Int = { return 2 }
    private var handlerOneArg: (Int) -> Void = { _ in }
    private var handlerOneArgReturn: (Int) -> Int = { return $0 }
    private var handlerTwoArgs: (Int, Int) -> Void = { _, _ in }
    private var handlerTwoArgsReturn: (Int, Int) -> Int = { return $1 }
    private var handlerThreeArgs: (Int, Int, Int) -> Void = { _, _, _ in }
    private var handlerThreeArgsReturn: (Int, Int, Int) -> Int = { return $2 }
    private var handlerFourArgs: (Int, Int, Int, Int) -> Void = { _, _, _, _ in }
    private var handlerFourArgsReturn: (Int, Int, Int, Int) -> Int = { return $3 }
    private var handlerFiveArgs: (Int, Int, Int, Int, Int) -> Void = { _, _, _, _, _ in }
    private var handlerFiveArgsReturn: (Int, Int, Int, Int, Int) -> Int = { return $4 }
    private var handlerSixArgs: (Int, Int, Int, Int, Int, Int) -> Void = { _, _, _, _, _, _ in }
    private var handlerSixArgsReturn: (Int, Int, Int, Int, Int, Int) -> Int = { return $5 }
    private var handlerSevenArgs: (Int, Int, Int, Int, Int, Int, Int) -> Void = { _, _, _, _, _, _, _ in }
    private var handlerSevenArgsReturn: (Int, Int, Int, Int, Int, Int, Int) -> Int = { return $6 }
    
    func registerZeroArg(handler: @escaping () -> Void) {
        self.handlerZeroArg = handler
        self.handlerZeroArg()
    }

    func registerZeroArgReturn(handler: @escaping () -> Int) {
        self.handlerZeroArgReturn = handler
        _ = self.handlerZeroArgReturn()
    }
    
    func registerOneArg(handler: @escaping (Int) -> Void) {
        self.handlerOneArg = handler
        self.handlerOneArg(42)
    }

    func registerOneArgReturn(handler: @escaping (Int) -> Int) {
        self.handlerOneArgReturn = handler
        _ = self.handlerOneArgReturn(42)
    }
    
    func registerTwoArgs(handler: @escaping (Int, Int) -> Void) {
        self.handlerTwoArgs = handler
        self.handlerTwoArgs(42, 42)
    }

    func registerTwoArgsReturn(handler: @escaping (Int, Int) -> Int) {
        self.handlerTwoArgsReturn = handler
        _ = self.handlerTwoArgsReturn(42, 42)
    }
    
    func registerThreeArgs(handler: @escaping (Int, Int, Int) -> Void) {
        self.handlerThreeArgs = handler
        self.handlerThreeArgs(42, 42, 42)
    }

    func registerThreeArgsReturn(handler: @escaping (Int, Int, Int) -> Int) {
        self.handlerThreeArgsReturn = handler
        _ = self.handlerThreeArgsReturn(42, 42, 42)
    }
    
    func registerFourArgs(handler: @escaping (Int, Int, Int, Int) -> Void) {
        self.handlerFourArgs = handler
        self.handlerFourArgs(42, 42, 42, 42)
    }

    func registerFourArgsReturn(handler: @escaping (Int, Int, Int, Int) -> Int) {
        self.handlerFourArgsReturn = handler
        _ = self.handlerFourArgsReturn(42, 42, 42, 42)
    }
    
    func registerFiveArgs(handler: @escaping (Int, Int, Int, Int, Int) -> Void) {
        self.handlerFiveArgs = handler
        self.handlerFiveArgs(42, 42, 42, 42, 42)
    }

    func registerFiveArgsReturn(handler: @escaping (Int, Int, Int, Int, Int) -> Int) {
        self.handlerFiveArgsReturn = handler
        _ = self.handlerFiveArgsReturn(42, 42, 42, 42, 42)
    }
    
    func registerSixArgs(handler: @escaping (Int, Int, Int, Int, Int, Int) -> Void) {
        self.handlerSixArgs = handler
        self.handlerSixArgs(42, 42, 42, 42, 42, 42)
    }

    func registerSixArgsReturn(handler: @escaping (Int, Int, Int, Int, Int, Int) -> Int) {
        self.handlerSixArgsReturn = handler
        _ = self.handlerSixArgsReturn(42, 42, 42, 42, 42, 42)
    }
    
    func registerSevenArgs(handler: @escaping (Int, Int, Int, Int, Int, Int, Int) -> Void) {
        self.handlerSevenArgs = handler
        self.handlerSevenArgs(42, 42, 42, 42, 42, 42, 42)
    }

    func registerSevenArgsReturn(handler: @escaping (Int, Int, Int, Int, Int, Int, Int) -> Int) {
        self.handlerSevenArgsReturn = handler
        _ = self.handlerSevenArgsReturn(42, 42, 42, 42, 42, 42, 42)
    }
}

private class Consumer: NSObject {
    
    deinit {
        consumerWasDeinit = true
    }
    
    let producer = Producer()

    func consumeWithoutWeakify() {
        producer.registerZeroArg(handler: {
            self.handleZeroArg()
        })
    }

    func consumeZeroArg() {
        producer.registerZeroArg(handler: weakify { strongSelf in
            strongSelf.handleZeroArg()
        })
    }

    func consumeZeroArgReturn() {
        producer.registerZeroArgReturn(handler: weakify(defaultValue: 0) { strongSelf in
            return strongSelf.handleZeroArgReturn()
        })
    }
    
    func consumeOneArg() {
        producer.registerOneArg(handler: weakify { strongSelf, a in
            strongSelf.handleOneArg(a)
        })
    }

    func consumeOneArgReturn() {
        producer.registerOneArgReturn(handler: weakify(defaultValue: 0) { strongSelf, a in
            return strongSelf.handleOneArgReturn(a)
        })
    }
    
    func consumeTwoArgs() {
        producer.registerTwoArgs(handler: weakify { strongSelf, a, b in
            strongSelf.handleTwoArgs(a,b)
        })
    }

    func consumeTwoArgsReturn() {
        producer.registerTwoArgsReturn(handler: weakify(defaultValue: 0) { strongSelf, a, b in
            return strongSelf.handleTwoArgsReturn(a,b)
        })
    }
    
    func consumeThreeArgs() {
        producer.registerThreeArgs(handler: weakify { strongSelf, a, b, c in
            strongSelf.handleThreeArgs(a,b,c)
        })
    }

    func consumeThreeArgsReturn() {
        producer.registerThreeArgsReturn(handler: weakify(defaultValue: 0) { strongSelf, a, b, c in
            return strongSelf.handleThreeArgsReturn(a,b,c)
        })
    }
    
    func consumeFourArgs() {
        producer.registerFourArgs(handler: weakify { strongSelf, a, b, c, d in
            strongSelf.handleFourArgs(a,b,c,d)
        })
    }

    func consumeFourArgsReturn() {
        producer.registerFourArgsReturn(handler: weakify(defaultValue: 0) { strongSelf, a, b, c, d in
            return strongSelf.handleFourArgsReturn(a,b,c,d)
        })
    }
    
    func consumeFiveArgs() {
        producer.registerFiveArgs(handler: weakify { strongSelf, a, b, c, d, e in
            strongSelf.handleFiveArgs(a,b,c,d,e)
        })
    }

    func consumeFiveArgsReturn() {
        producer.registerFiveArgsReturn(handler: weakify(defaultValue: 0) { strongSelf, a, b, c, d, e in
            return strongSelf.handleFiveArgsReturn(a,b,c,d,e)
        })
    }
    
    func consumeSixArgs() {
        producer.registerSixArgs(handler: weakify { strongSelf, a, b, c, d, e, f in
            strongSelf.handleSixArgs(a,b,c,d,e,f)
        })
    }

    func consumeSixArgsReturn() {
        producer.registerSixArgsReturn(handler: weakify(defaultValue: 0) { strongSelf, a, b, c, d, e, f in
            return strongSelf.handleSixArgsReturn(a,b,c,d,e,f)
        })
    }
    
    func consumeSevenArgs() {
        producer.registerSevenArgs(handler: weakify { strongSelf, a, b, c, d, e, f, g in
            strongSelf.handleSevenArgs(a,b,c,d,e,f,g)
        })
    }

    func consumeSevenArgsReturn() {
        producer.registerSevenArgsReturn(handler: weakify(defaultValue: 0) { strongSelf, a, b, c, d, e, f, g in
            return strongSelf.handleSevenArgsReturn(a,b,c,d,e,f,g)
        })
    }
    
    private func handleZeroArg() {
        print("🎉")
    }

    private func handleZeroArgReturn() -> Int {
        print("🎉")
        return 2
    }
    
    private func handleOneArg(_ a: Int) {
        print("🎉 \(a)")
    }

    private func handleOneArgReturn(_ a: Int) -> Int {
        print("🎉 \(a)")
        return 2
    }
    
    private func handleTwoArgs(_ a: Int, _ b: Int) {
        print("🎉 \(a) \(b)")
    }

    private func handleTwoArgsReturn(_ a: Int, _ b: Int) -> Int {
        print("🎉 \(a) \(b)")
        return 2
    }
    
    private func handleThreeArgs(_ a: Int, _ b: Int, _ c: Int) {
        print("🎉 \(a) \(b) \(c)")
    }

    private func handleThreeArgsReturn(_ a: Int, _ b: Int, _ c: Int) -> Int {
        print("🎉 \(a) \(b) \(c)")
        return 2
    }
    
    private func handleFourArgs(_ a: Int, _ b: Int, _ c: Int, _ d: Int) {
        print("🎉 \(a) \(b) \(c) \(d)")
    }

    private func handleFourArgsReturn(_ a: Int, _ b: Int, _ c: Int, _ d: Int) -> Int {
        print("🎉 \(a) \(b) \(c) \(d)")
        return 2
    }
    
    private func handleFiveArgs(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int) {
        print("🎉 \(a) \(b) \(c) \(d) \(e)")
    }

    private func handleFiveArgsReturn(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int) -> Int {
        print("🎉 \(a) \(b) \(c) \(d) \(e)")
        return 2
    }
    
    private func handleSixArgs(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int, _ f: Int) {
        print("🎉 \(a) \(b) \(c) \(d) \(e) \(f)")
    }

    private func handleSixArgsReturn(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int, _ f: Int) -> Int {
        print("🎉 \(a) \(b) \(c) \(d) \(e) \(f)")
        return 2
    }
    
    private func handleSevenArgs(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int, _ f: Int, _ g: Int) {
        print("🎉 \(a) \(b) \(c) \(d) \(e) \(f) \(g)")
    }

    private func handleSevenArgsReturn(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int, _ f: Int, _ g: Int) -> Int {
        print("🎉 \(a) \(b) \(c) \(d) \(e) \(f) \(g)")
        return 2
    }
}

class SharedTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        producerWasDeinit = false
        consumerWasDeinit = false
    }

    /// This test proves that without the use of weakify a memory leak is indeed created.
    func testWithoutWeakifying() {
        var consumer: Consumer? = Consumer()
        consumer?.consumeWithoutWeakify()

        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")

        consumer = nil

        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")
    }
    
    func testWeakifyZeroArgument() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeZeroArg()
        
        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")
        
        consumer = nil
        
        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }

    func testWeakifyZeroArgumentWithReturn() {
        var consumer: Consumer? = Consumer()

        consumer?.consumeZeroArgReturn()

        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")

        consumer = nil

        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }
    
    func testWeakifyOneArgument() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeOneArg()
        
        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")
        
        consumer = nil
        
        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }

    func testWeakifyOneArgumentWithReturn() {
        var consumer: Consumer? = Consumer()

        consumer?.consumeOneArgReturn()

        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")

        consumer = nil

        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }
    
    func testWeakifyTwoArguments() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeTwoArgs()
        
        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")
        
        consumer = nil
        
        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }

    func testWeakifyTwoArgumentsWithReturn() {
        var consumer: Consumer? = Consumer()

        consumer?.consumeTwoArgsReturn()

        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")

        consumer = nil

        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }
    
    func testWeakifyThreeArguments() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeThreeArgs()
        
        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")
        
        consumer = nil
        
        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }

    func testWeakifyThreeArgumentsWithReturn() {
        var consumer: Consumer? = Consumer()

        consumer?.consumeThreeArgsReturn()

        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")

        consumer = nil

        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }
    
    func testWeakifyFourArguments() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeFourArgs()
        
        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")
        
        consumer = nil
        
        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }

    func testWeakifyFourArgumentsWithReturn() {
        var consumer: Consumer? = Consumer()

        consumer?.consumeFourArgsReturn()

        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")

        consumer = nil

        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }
    
    func testWeakifyFiveArguments() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeFiveArgs()
        
        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")
        
        consumer = nil
        
        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }

    func testWeakifyFiveArgumentsWithReturn() {
        var consumer: Consumer? = Consumer()

        consumer?.consumeFiveArgsReturn()

        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")

        consumer = nil

        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }
    
    func testWeakifySixArguments() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeSixArgs()
        
        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")
        
        consumer = nil
        
        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }

    func testWeakifySixArgumentsWithReturn() {
        var consumer: Consumer? = Consumer()

        consumer?.consumeSixArgsReturn()

        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")

        consumer = nil

        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }
    
    func testWeakifySevenArguments() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeSevenArgs()
        
        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")
        
        consumer = nil
        
        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }

    func testWeakifySevenArgumentsWithReturn() {
        var consumer: Consumer? = Consumer()

        consumer?.consumeSevenArgsReturn()

        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")

        consumer = nil

        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }
}

