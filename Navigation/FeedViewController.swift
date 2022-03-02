//
//  FirstViewController.swift
//  Navigation
//
//  Created by Арсений Корнилов on 23.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    struct post11 {
        var title: String = "Дожить бы до завтра"
        var textOfPost: String = "На улице дубак, на сердце тлен и мрак, В интернете, как всегда, кто-то не прав, но мне плевать, На улице дубак, скорее бы весна, Что мне ваши катастрофы и теракты, мне б не знать о них..."
    }

    @IBOutlet weak var showNewsButton: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTransitionButton()
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
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

