//
//  CalculateView.swift
//  Kadai5
//
//  Created by daiki umehara on 2021/06/03.
//

import UIKit

class CalculateView: UIView {
    enum CalculationType {
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
    }

    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet private weak var operatorLabel: UILabel!

    var firstText: String? {
        firstTextField.text
    }

    var secondText: String? {
        secondTextField.text
    }

    var firstValue: Double? {
        firstText.flatMap(Double.init)
    }

    var secondValue: Double? {
        secondText.flatMap(Double.init)
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
    }
}
