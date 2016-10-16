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
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
    }


}

