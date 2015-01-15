//
//  main.swift
//  SwiftRC4
//
//  Created by Willy Liu on 2015/1/15.
//  Copyright (c) 2015年 Willy Liu. All rights reserved.
//

import Foundation

let plaintext = "pedia"
let plaintextData = plaintext.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
let key = "Wiki"
let encodedData = RC4.crypt(plaintextData!, key: key)
println("plaintext: " + plaintext)
println("key: " + key)
println("RC4 cipher text: " + encodedData.description)

