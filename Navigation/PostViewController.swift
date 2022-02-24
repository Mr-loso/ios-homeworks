//
//  PostViewController.swift
//  Navigation
//
//  Created by Арсений Корнилов on 23.02.2022.
//

import UIKit



class PostViewController: UIViewController {
    
    var ViewPost1: FeedViewController.post11?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPost(postTitle: ViewPost1 ?? FeedViewController.post11 () )

        // Do any additional setup after loading the view.
    }
                      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func loadPost(postTitle: FeedViewController.post11) {
        self.navigationItem.title = postTitle.title
        
    }
}
    
