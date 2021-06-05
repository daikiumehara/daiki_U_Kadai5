//
//  ViewController.swift
//  Kadai5
//
//  Created by daiki umehara on 2021/06/03.
//

import UIKit

struct CalcError: Error {
    enum Cause {
        case firstNumber
        case secondNumber
        case other
    }

    var message: String
    var cause: Cause
}

typealias CalcCompletionHandler<T> = (Result<T, CalcError>) -> Void

protocol CalculatorProtocol {
    func calculate(num1: Double, num2: Double, completion: CalcCompletionHandler<Double>)
}

class ViewController: UIViewController {
    @IBOutlet private var divideView: CalculateView!
    @IBOutlet private var answerLabel: UILabel!

    private let calculator: CalculatorProtocol = DivisionCalculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        divideView.configure(calculation: .division)
    }

    @IBAction private func didTapCalcButton(_ sender: Any) {
        guard let firstValue = divideView.firstValue else {
            makeAndShowAlert(message: "左側に数字を入力してください")
            return
        }
        guard let secondValue = divideView.secondValue else {
            makeAndShowAlert(message: "右側に数字を入力してください")
            return
        }

        calculator.calculate(num1: firstValue, num2: secondValue, completion: {
            switch $0 {
            case .success(let value):
                answerLabel.text = String(value)
            case .failure(let error):
                makeAndShowAlert(message: error.message)

                switch error.cause {
                case .firstNumber:
                    // 1つ目のテキストフィールドにフォーカスを移動する
                    break
                case .secondNumber:
                    // 2つ目のテキストフィールドにフォーカスを移動する
                    break
                case .other:
                    break
                }
            }
        })
    }

    private func makeAndShowAlert(message: String) {
        let alert = UIAlertController(title: "課題5", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
