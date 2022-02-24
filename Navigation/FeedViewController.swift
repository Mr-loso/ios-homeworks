//
//  FirstViewController.swift
//  Navigation
//
//  Created by Арсений Корнилов on 23.02.2022.
//

import UIKit

var pot: String = "Кто я?"

class FeedViewController: UIViewController {
    
    struct post11 {
        var title: String = "Путин - молодец!"
        var textOfPost: String = "Владимир Путин молодец! Политик, лидер и борец! Наш президент страну поднял! Россию Путин не предал!"
    }

    @IBOutlet weak var showNewsButton: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTransitionButton()
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Заголовок"
        self.navigationItem.backButtonTitle = "Назад"
    }
    
    private func setupTransitionButton() {
        self.showNewsButton.layer.cornerRadius = 12
        self.showNewsButton.clipsToBounds = true
        self.showNewsButton.setTitle(FeedViewController.post11.init().title, for: .normal)
        self.showNewsButton.backgroundColor = .systemBlue
        self.showNewsButton.setTitleColor(.white, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "showPostSegue",
            let postViewController = segue.destination as? PostViewController
        else { return }

        postViewController.ViewPost1 = FeedViewController.post11.init()
    }
}

