//
//  RC4Tests.swift
//  RC4Tests
//
//  Created by Willy Liu on 2015/1/15.
//  Copyright (c) 2015年 Willy Liu. All rights reserved.
//

import Cocoa
import XCTest

class RC4Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func testRC4() {
		let plaintext = "pedia"
		let plaintextData = plaintext.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
		let encodedData = RC4.crypt(plaintextData!, key: "Wiki")
		var bytes = [Byte](count: encodedData.length, repeatedValue: 0)
		encodedData.getBytes(&bytes, length: encodedData.length)
		XCTAssertTrue(bytes == [0x10, 0x21, 0xBF, 0x04, 0x20], "Encoded data must match")
	}
	
	func testRC4Case2() {
		let plaintext = "Plaintext"
		let plaintextData = plaintext.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
		let encodedData = RC4.crypt(plaintextData!, key: "Key")
		var bytes = [Byte](count: encodedData.length, repeatedValue: 0)
		encodedData.getBytes(&bytes, length: encodedData.length)
		XCTAssertTrue(bytes == [0xBB, 0xF3, 0x16, 0xE8, 0xD9, 0x40, 0xAF, 0x0A, 0xD3], "Encoded data must match")
	}
	
	func testRC4Case3() {
		let plaintext = "Attack at dawn"
		let plaintextData = plaintext.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
		let encodedData = RC4.crypt(plaintextData!, key: "Secret")
		var bytes = [Byte](count: encodedData.length, repeatedValue: 0)
		encodedData.getBytes(&bytes, length: encodedData.length)
		XCTAssertTrue(bytes == [0x45, 0xA0, 0x1F, 0x64, 0x5F, 0xC3, 0x5B, 0x38, 0x35, 0x52, 0x54, 0x4B, 0x9B, 0xF5], "Encoded data must match")
	}
	
	func testRC4EncryptionTwice() {
		let plaintext = "pedia"
		let plaintextData = plaintext.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
		let encodedData = RC4.crypt(plaintextData!, key: "Wiki")
		let decodedData = RC4.crypt(encodedData, key: "Wiki")
		XCTAssertTrue(decodedData == plaintextData, "Decoded data must match plaintext data")
	}
	
	func testRC4Streaming() {
		let plaintext = "pedia"
		let plaintextData = plaintext.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
		let cryptor = RC4(key: "Wiki")
		let expectedData = NSData(bytes: [0x10, 0x21, 0xBF, 0x04, 0x20] as [Byte], length: 5)
		var result = NSMutableData()
		for i in Range<Int>(start: 0, end: plaintextData.length) {
			let textData = plaintextData.subdataWithRange(NSMakeRange(i, 1))
			let encodedData = cryptor.crypt(textData)
			result.appendData(encodedData)
		}
		XCTAssertTrue(expectedData.isEqualToData(result), "Encoded data must match")
	}
    
}
