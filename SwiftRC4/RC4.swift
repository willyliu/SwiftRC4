//
//  RC4.swift
//  SwiftRC4
//
//  Created by Willy Liu on 2015/1/14.
//  Copyright (c) 2015年 Willy Liu. All rights reserved.
//

import Foundation

public class RC4 {
	internal var box = [Byte](count: 256, repeatedValue: 0)
	internal var x = 0
	internal var y = 0
	public class func crypt(data: NSData, key: String) -> NSData {
		let cryptor = RC4(key: key)
		return cryptor.crypt(data)
	}
	
	public init(key:String) {
		// initializes box, x and y. remember to reset x and y after intializing box
		let keyData = key.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
		assert(keyData.length == countElements(key), "Length of key data must match length of key")
		let keyByteArray = UnsafePointer<Byte>(keyData.bytes)
		
		for var i = 0; i < 256; i++ {
			box[i] = Byte(i)
		}
		for var i = 0; i < 256; i++ {
			let keyIndex = i % keyData.length
			let keyChar = keyByteArray[keyIndex]
			x = (x + Int(box[i]) + Int(keyChar)) % 256
			(box[i], box[x]) = (box[x], box[i])
		}
		x = 0
		y = 0
	}
	
	public func crypt(data: NSData) -> NSData {
		var outData = NSMutableData(length: data.length)!
		var out = UnsafeMutablePointer<Byte>(outData.bytes)
		let dataByteArray = UnsafePointer<Byte>(data.bytes)
		for i in Range(start: 0, end: data.length) {
			x = (x + 1) % 256
			y = (y + Int(box[x])) % 256
			(box[x], box[y]) = (box[y], box[x])
			let char = dataByteArray[i]
			out[i] = char ^ box[(Int(box[x]) + Int(box[y])) % 256]
		}
		return outData
	}
}