//
//  ViewController.swift
//  Kadai5
//
//  Created by daiki umehara on 2021/06/03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var divideView: CalculateView!
    @IBOutlet private var answerLabel: UILabel!
    
    @IBAction private func didTapCalcButton(_ sender: Any) {
        divideView.calc { result in
            switch result {
            case .success(let value):
                answerLabel.text = String(value)
            case .failure(let error):
                makeAndShowAlert(error.detail)
            }
        }
    }
    
    private func makeAndShowAlert(_ detail: String) {
        let alert = UIAlertController(title: "課題5", message: detail, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
