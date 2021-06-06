//
//  CalculateView.swift
//  Kadai5
//
//  Created by daiki umehara on 2021/06/03.
//

import UIKit

enum CalculationType: Int {
    case addition
    case subtraction
    case multiplication
    case division
    
    var text: String {
        switch self {
        case .addition:
            return "+"
        case .subtraction:
            return "−"
        case .multiplication:
            return "×"
        case .division:
            return "÷"
        }
    }
    
    var calclator: CalculatorProtocol {
        switch self {
        case .addition:
            return AddtionCalculator()
        case .subtraction:
            return SubtractionCalclator()
        case .multiplication:
            return MultiplicationCalculator()
        case .division:
            return DivisionCalculator()
        }
    }
}

class CalculateView: UIView {
    
    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet private weak var operatorLabel: UILabel!
    
    private(set) var calculator: CalculatorProtocol!
    
    var firstValue: Double? {
        Double(firstTextField.text!)
    }
    
    var secondValue: Double? {
        Double(secondTextField.text!)
    }
    
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
    
    func configure(calculation: CalculationType) {
        operatorLabel.text = calculation.text
        calculator = calculation.calclator
    }

}
