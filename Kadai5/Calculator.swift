//
//  Calculator.swift
//  Kadai5
//
//  Created by akio0911 on 2021/06/05.
//

import Foundation

struct DivisionCalculator: CalculatorProtocol {
    func calculate(num1: Double, num2: Double, completion: CalcCompletionHandler<Double>) {
        guard num2 != 0 else {
            return completion(
                .failure(
                    .invalidCalculation("割る数には0を入力しないでください")
                )
            )
        }
        return completion(.success(num1 / num2))
    }
}
