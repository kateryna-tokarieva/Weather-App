//
//  InfoViewController.swift
//  WeatherBrick
//
//  Created by Екатерина Токарева on 23/12/2022.
//  Copyright © 2022 VAndrJ. All rights reserved.
//

import UIKit

final class InfoViewController: UIViewController {
    
    @IBOutlet private weak var frontView: UIView!
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var hideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frontView.layer.cornerRadius = 10
        frontView.layer.masksToBounds = true
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
        backView.layer.masksToBounds = false
        backView.layer.shadowOffset = CGSize(width: 0, height: 4)
        backView.layer.shadowColor = Colors.shadowColor
        backView.layer.shadowRadius = 4
        backView.layer.shadowOpacity = 1
        hideButton.layer.cornerRadius = 15
        hideButton.layer.masksToBounds = true
        hideButton.layer.borderWidth = 1
        hideButton.layer.borderColor = Colors.boarderColor
    }
    
    @IBAction private func hideAction() {
        dismiss(animated: true)
    }
}

extension InfoViewController {
    
    private struct Colors {
        static let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        static let boarderColor = UIColor(red: 0.34, green: 0.34, blue: 0.34, alpha: 1).cgColor
    }
}
