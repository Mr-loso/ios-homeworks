//
//  InfoViewController.swift
//  Navigation
//
//  Created by Арсений Корнилов on 24.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMainButton()
        
    }

 
    
    
    @IBOutlet weak var AlertButton: UIButton!
    
    private func setupMainButton() {
    self.AlertButton.layer.cornerRadius = 12
    self.AlertButton.clipsToBounds = true
    self.AlertButton.setTitle("Пожаловаться на пост", for: .normal)
    self.AlertButton.backgroundColor = .systemBlue
    self.AlertButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func Alert(_ sender: Any) {
        let alert = UIAlertController(title: "Пожаловаться на новость", message: "Расскажите, что Вам не понравилось?", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Разжигание ненависти", style: .default, handler: { (_) in
                    print("User click Approve button")
                }))

                alert.addAction(UIAlertAction(title: "Недостоверная информация", style: .default, handler: { (_) in
                    print("User click Edit button")
                }))

                alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (_) in
                    print("User click Dismiss button")
                }))

                self.present(alert, animated: true, completion: {
                    print("completion block")
                })
    }
}
