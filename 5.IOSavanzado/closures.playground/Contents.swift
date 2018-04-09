//: Playground - noun: a place where people can play

import UIKit

var operateClosure: (Int, Int) -> Int

operateClosure = { (a: Int, b: Int) in return a+b }
operateClosure = { a, b in return a+b }
operateClosure = { a, b in a+b }
operateClosure = { $0 + $1 }
// Todas son lo mismo, diferentes maneras de escribirlo

print(operateClosure(5, 7))


func operateTwoInts(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

let result = operateTwoInts(a: 3, b: 4, operation: { $0 * $1 })
let result2 = operateTwoInts(a: 3, b: 4, operation: * )

print(result)
print(result2)


// Trailing Closure
let result3 = operateTwoInts(a: 3, b: 4) { a, b in a + b }

// Se pueden declarar arrays de closures
let closures: [(Int, Int) -> Int]


