# SwiftRC4
Swift implementation of RC4.
Usage: 
`
let data: NSData // the NSData to crypt
let key: String // the key to crypt
let encodedData = RC4.crypt(data, key)`
Or streaming encryption:
`
let key: String
let cryptor = RC4(key: key)
while true {
    let data = ... // fetch data
    let encodedData = cryptor.crypt(data)
    // handles encodedData
    // break on finish loading
}`
