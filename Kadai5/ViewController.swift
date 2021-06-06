//
//  ViewController.swift
//  Kadai5
//
//  Created by daiki umehara on 2021/06/03.
//

import UIKit

//エラーの種類を複数用意するのではなく、計算が失敗するエラーを作成し、エラー文を渡すことでエラーの種類を一つにしている。
enum CalcError: Error {
    case invalidCalculation(String)
}

typealias CalcCompletionHandler<T> = (Result<T, CalcError>) -> Void

protocol CalculatorProtocol {
    func calculate(num1: Double, num2: Double, completion: CalcCompletionHandler<Double>)
}

class ViewController: UIViewController {
    @IBOutlet private var calculateView: CalculateView!
    @IBOutlet private var answerLabel: UILabel!
    @IBOutlet private var oparatorSegmented: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateView.configure(calculation: .division)
    }

    @IBAction private func didTapCalcButton(_ sender: Any) {
        guard let firstValue = calculateView.firstValue else {
            makeAndShowAlert(message: "左側の値を入力してください")
            return
        }
        guard let secondValue = calculateView.secondValue else {
            makeAndShowAlert(message: "右側の値を入力してください")
            return
        }
        calculateView.calculator.calculate(num1: firstValue, num2: secondValue) { result in
            switch result {
            case .success(let value):
                answerLabel.text = String(value)
            case .failure(.invalidCalculation(let message)):
                makeAndShowAlert(message: message)
            }
        }
    }
    @IBAction private func didChangedOparatorSegmentedValue(_ sender: Any) {
        let oparator = CalculationType(rawValue: oparatorSegmented.selectedSegmentIndex)
        calculateView.configure(calculation: oparator!)
    }
    
    private func makeAndShowAlert(message: String) {
        let alert = UIAlertController(title: "課題5", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
