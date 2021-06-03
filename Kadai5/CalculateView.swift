//
//  CalculateView.swift
//  Kadai5
//
//  Created by daiki umehara on 2021/06/03.
//

import UIKit

typealias CalcResult<T> = (Result<T, CalcError>) -> Void

protocol Calculator: AnyObject {
    func calc(_ completion: CalcResult<Double>)
}

enum CalcError: Error {
    case noneLeftValue, noneRightValue, zero
    var detail: String {
        switch self {
        case .noneLeftValue: return "左側に数字を入力してください"
        case .noneRightValue: return "右側に数字を入力してください"
        case .zero: return "割る数には0を入力しないでください"
        }
    }
}

class CalculateView: UIView, Calculator {
    @IBOutlet private var firstTextField: UITextField!
    @IBOutlet private var secondTextField: UITextField!
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    private func loadNib() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func calc(_ completion: CalcResult<Double>) {
        guard let firstValue = Double(firstTextField.text!) else {
            return completion(.failure(.noneLeftValue))
        }
        guard let secondValue = Double(secondTextField.text!) else {
            return completion(.failure(.noneRightValue))
        }
        if secondValue == 0 {
            return completion(.failure(.zero))
        }
        return completion(.success(firstValue / secondValue))
    }
}
