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
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.delegate = self
        self.dataSource = self
        
        setViewControllers([subViewControllers[0]!], direction: .forward, animated: false, completion: nil)
        
        pageControl = UIPageControl()
        
        //pageControll.pageIndicatorTintColor = UIColor.lightGray
        //pageControll.currentPageIndicatorTintColor = UIColor.darkGray
        
        self.pageControl.numberOfPages = subViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.white
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        self.view.addSubview(self.pageControl)

        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = self.pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = self.pageControl.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0)
        let widthConstraint = self.pageControl.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = self.pageControl.heightAnchor.constraint(equalToConstant: 50)
        self.view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.pageControl.currentPage = subViewControllers.firstIndex(of: pageViewController.viewControllers![0])!
    }
    
    
}
