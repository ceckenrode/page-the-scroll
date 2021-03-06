//
//  ViewController.swift
//  PageTheScroll
//
//  Created by Christian Eckenrode Work on 10/15/16.
//  Copyright © 2016 Christian Eckenrode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var images = [UIImageView]()
    //setting constants for max and min pages, variable for current page
    let MAX_PAGE = 2
    let MIN_PAGE = 0
    var currentPage = 0
    
    //need a reference to the scrollview
    @IBOutlet weak var scrollView: UIScrollView!

    //loading happens first
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //view did appear is more like document.ready
    override func viewDidAppear(_ animated: Bool) {
        //CGFloat is a unit for measuring screen size
        var contentWidth: CGFloat = 0.0
        let scrollWidth: CGFloat = scrollView.frame.size.width
        print("ScrollView Width: \(scrollView.frame.size.width)")
        for x in 0...2 {
            //programatically creating uiImages and UIImage views
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            //this will find our center of the screen, then add a screen width per index
            var newX: CGFloat = 0.0
            newX = scrollWidth / 2 + scrollWidth * CGFloat(x)
            //our content width is as wide as it needs to be to hold all the content
            contentWidth += newX
            //puts a view inside our scroll view
            scrollView.addSubview(imageView)
            //setting the size and position of our imageView
            imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
        }
        //adjusting the contentSize property of the scroll view. Since its a horizontal list we adjust the width, but not the height
        //prevents content in the view from cliping to bounds of view
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
    }
    
    
    //listener is on both swipe gestures
    @IBAction func detectSwipe(_ sender: UISwipeGestureRecognizer) {
        //sender has a direction property of UISwipeGestureRecognizerDirection.left or UISwipeGestureRecognizerDirection.right
        //if we arent on the last page and are swiping to the left, run moveScrollView func
        if (currentPage < MAX_PAGE && sender.direction == UISwipeGestureRecognizerDirection.left) {
            moveScrollView(direction: 1)
            
        }
        
        if (currentPage > MIN_PAGE && sender.direction == UISwipeGestureRecognizerDirection.right) {
            moveScrollView(direction: -1)
        }
    }
    
    func moveScrollView(direction: Int){
        //current page is itself + direction
        currentPage = currentPage + direction
        //point is the far most right point
        let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        //moves the scrollview
        scrollView.setContentOffset(point, animated: true)
        
        // Create a animation to increase the actual icon on screen
        UIView.animate(withDuration: 0.4){
            //the new current image grows larger
            self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
            
            // Revert icon size of the non-active pages
            for x in 0..<self.images.count {
                if (x != self.currentPage) {
                    self.images[x].transform = CGAffineTransform.identity
                }
            }
        }
    }



}

