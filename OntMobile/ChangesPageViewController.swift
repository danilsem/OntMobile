//
//  ChangesPageViewController.swift
//  OntMobile
//
//  Created by Admin on 25/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ChangesPageViewController: UIPageViewController {
    
    lazy var subViewControllers: [UIViewController?] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondViewControllerID"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TimetableViewControllerID")
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.delegate = self
        self.dataSource = self
        
        setViewControllers([subViewControllers[0]!], direction: .forward, animated: true, completion: nil)
    }
    

}

extension ChangesPageViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex <= 0 {
            return nil
        }
        return subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex >= subViewControllers.count-1 {
            return nil
        }
        return subViewControllers[currentIndex+1]
    }
    
    
}
