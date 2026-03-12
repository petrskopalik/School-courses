//
//  main.swift
//  seminar2
//
//  Created by Petr Skopalík on 17.02.2026.
//

import Foundation

struct Stack<T> {
    var items: [T] = []

    mutating func push(_ item: T) {
        items.append(item)
    }

    mutating func pop() -> T? {
        return items.isEmpty ? nil : items.removeLast()
    }

    func peek() -> T? {
        return items.isEmpty ? nil : items.last
    }
}

enum rpnError: Error {
    case unknowToken
    case notEnoughArguments
    case divisionByZero
    case stackLeftovers
    case noArguments
}

let relationOperators : [String] = ["==", "<", ">"]
let binaryOperators: [String] = ["+", "-", "*", "/"]
let ternaryOperators: [String] = ["?:"]
let unaryOperators: [String] = ["neg"]

func execute(expresionList: [String]) throws -> Double{
    var stack = Stack<Double>()
    for expresion in expresionList{
        if relationOperators.contains(expresion) || binaryOperators.contains(expresion) {
            guard let secondNum = stack.pop() else {
                throw rpnError.notEnoughArguments
            }
            guard let firstNum = stack.pop() else {
                throw rpnError.notEnoughArguments
            }
            
            switch expresion {
            case "==":
                stack.push(firstNum == secondNum ? 1 : 0)
            case "<":
                stack.push(firstNum < secondNum ? 1 : 0)
            case ">":
                stack.push(firstNum > secondNum ? 1 : 0)
            case "+":
                stack.push(firstNum + secondNum)
            case "-":
                stack.push(firstNum - secondNum)
            case "*":
                stack.push(firstNum * secondNum)
            case "/":
                if secondNum == 0 {
                    throw rpnError.divisionByZero
                }
                stack.push(firstNum / secondNum)
            default:
                throw rpnError.unknowToken
            }
        } else if ternaryOperators.contains(expresion) {
            guard let falseValue = stack.pop() else {
                throw rpnError.notEnoughArguments
            }
            guard let trueValue = stack.pop() else {
                throw rpnError.notEnoughArguments
            }
            guard let condition = stack.pop() else {
                throw rpnError.notEnoughArguments
            }
            
            switch condition {
            case 0:
                stack.push(falseValue)
            case 1:
                stack.push(trueValue)
            default:
                throw rpnError.unknowToken
            }
        } else if unaryOperators.contains(expresion){
            guard let value = stack.pop() else {
                throw rpnError.notEnoughArguments
            }
            stack.push(-1 * value)
        } else {
            guard let number = Double(expresion) else{
                throw rpnError.noArguments
            }
            stack.push(number)
        }
    }
    
    guard let lastElement = stack.pop() else {
        throw rpnError.notEnoughArguments
    }
    if stack.peek() != nil {
        throw rpnError.stackLeftovers
    }
    
    return lastElement
}

func rpnCalculator(){
    guard let expr = readLine() else {
        print("Error: Nelze zadat prázdný vstup")
        return
    }
    let expresionList: [String] = expr.components(separatedBy: " ")
    let result: Double
    do {
        try result = execute(expresionList: expresionList)
        print(result)
    } catch rpnError.divisionByZero {
        print("Error: Dělení nulou")
    } catch rpnError.noArguments {
        print("Error: Nelze zadat prázdný vstup")
    } catch rpnError.notEnoughArguments {
        print("Error: Operace nemá dostatek argumetnů")
    } catch rpnError.stackLeftovers {
        print("Error: Na konci výpočtu zásobník nebyl prázdný")
    } catch rpnError.unknowToken {
        print("Error: Nelze použít neznámý token")
    } catch {
        print("Neočekávaný error")
    }
}

rpnCalculator()
