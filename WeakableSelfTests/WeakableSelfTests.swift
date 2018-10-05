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
    private var handlerOneArg: (Int) -> Void = { _ in }
    private var handlerTwoArgs: (Int, Int) -> Void = { _, _ in }
    private var handlerThreeArgs: (Int, Int, Int) -> Void = { _, _, _ in }
    private var handlerFourArgs: (Int, Int, Int, Int) -> Void = { _, _, _, _ in }
    private var handlerFiveArgs: (Int, Int, Int, Int, Int) -> Void = { _, _, _, _, _ in }
    private var handlerSixArgs: (Int, Int, Int, Int, Int, Int) -> Void = { _, _, _, _, _, _ in }
    private var handlerSevenArgs: (Int, Int, Int, Int, Int, Int, Int) -> Void = { _, _, _, _, _, _, _ in }
    
    func registerZeroArg(handler: @escaping () -> Void) {
        self.handlerZeroArg = handler
        self.handlerZeroArg()
    }
    
    func registerOneArg(handler: @escaping (Int) -> Void) {
        self.handlerOneArg = handler
        self.handlerOneArg(42)
    }
    
    func registerTwoArgs(handler: @escaping (Int, Int) -> Void) {
        self.handlerTwoArgs = handler
        self.handlerTwoArgs(42, 42)
    }
    
    func registerThreeArgs(handler: @escaping (Int, Int, Int) -> Void) {
        self.handlerThreeArgs = handler
        self.handlerThreeArgs(42, 42, 42)
    }
    
    func registerFourArgs(handler: @escaping (Int, Int, Int, Int) -> Void) {
        self.handlerFourArgs = handler
        self.handlerFourArgs(42, 42, 42, 42)
    }
    
    func registerFiveArgs(handler: @escaping (Int, Int, Int, Int, Int) -> Void) {
        self.handlerFiveArgs = handler
        self.handlerFiveArgs(42, 42, 42, 42, 42)
    }
    
    func registerSixArgs(handler: @escaping (Int, Int, Int, Int, Int, Int) -> Void) {
        self.handlerSixArgs = handler
        self.handlerSixArgs(42, 42, 42, 42, 42, 42)
    }
    
    func registerSevenArgs(handler: @escaping (Int, Int, Int, Int, Int, Int, Int) -> Void) {
        self.handlerSevenArgs = handler
        self.handlerSevenArgs(42, 42, 42, 42, 42, 42, 42)
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
    
    func consumeOneArg() {
        producer.registerOneArg(handler: weakify { strongSelf, a in
            strongSelf.handleOneArg(a)
        })
    }
    
    func consumeTwoArgs() {
        producer.registerTwoArgs(handler: weakify { strongSelf, a, b in
            strongSelf.handleTwoArgs(a,b)
        })
    }
    
    func consumeThreeArgs() {
        producer.registerThreeArgs(handler: weakify { strongSelf, a, b, c in
            strongSelf.handleThreeArgs(a,b,c)
        })
    }
    
    func consumeFourArgs() {
        producer.registerFourArgs(handler: weakify { strongSelf, a, b, c, d in
            strongSelf.handleFourArgs(a,b,c,d)
        })
    }
    
    func consumeFiveArgs() {
        producer.registerFiveArgs(handler: weakify { strongSelf, a, b, c, d, e in
            strongSelf.handleFiveArgs(a,b,c,d,e)
        })
    }
    
    func consumeSixArgs() {
        producer.registerSixArgs(handler: weakify { strongSelf, a, b, c, d, e, f in
            strongSelf.handleSixArgs(a,b,c,d,e,f)
        })
    }
    
    func consumeSevenArgs() {
        producer.registerSevenArgs(handler: weakify { strongSelf, a, b, c, d, e, f, g in
            strongSelf.handleSevenArgs(a,b,c,d,e,f,g)
        })
    }
    
    private func handleZeroArg() {
        print("🎉")
    }
    
    private func handleOneArg(_ a: Int) {
        print("🎉 \(a)")
    }
    
    private func handleTwoArgs(_ a: Int, _ b: Int) {
        print("🎉 \(a) \(b)")
    }
    
    private func handleThreeArgs(_ a: Int, _ b: Int, _ c: Int) {
        print("🎉 \(a) \(b) \(c)")
    }
    
    private func handleFourArgs(_ a: Int, _ b: Int, _ c: Int, _ d: Int) {
        print("🎉 \(a) \(b) \(c) \(d)")
    }
    
    private func handleFiveArgs(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int) {
        print("🎉 \(a) \(b) \(c) \(d) \(e)")
    }
    
    private func handleSixArgs(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int, _ f: Int) {
        print("🎉 \(a) \(b) \(c) \(d) \(e) \(f)")
    }
    
    private func handleSevenArgs(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int, _ f: Int, _ g: Int) {
        print("🎉 \(a) \(b) \(c) \(d) \(e) \(f) \(g)")
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
    
    func testWeakifyOneArgument() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeOneArg()
        
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
    
    func testWeakifyThreeArguments() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeThreeArgs()
        
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
    
    func testWeakifyFiveArguments() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeFiveArgs()
        
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
    
    func testWeakifySevenArguments() {
        var consumer: Consumer? = Consumer()
        
        consumer?.consumeSevenArgs()
        
        XCTAssertFalse(producerWasDeinit, "producerWasDeinit")
        XCTAssertFalse(consumerWasDeinit, "consumerWasDeinit")
        
        consumer = nil
        
        XCTAssertTrue(producerWasDeinit, "producerWasDeinit")
        XCTAssertTrue(consumerWasDeinit, "consumerWasDeinit")
    }
}

