//
//  ViewController.swift
//  GradientTest
//
//  Created by Ahmed Khattak on 05/07/2018.
//  Copyright © 2018 Ahmed Khattak. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    //@IBOutlet weak var navbar: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    var imageView: UIImageView!
    let magicNumber: CGFloat = 147
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         //navbar.delegate = self
        
                imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: magicNumber))
                imageView.image = UIImage.init(named: "model")
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
        
        
        
        //        let uiView = UIView()
        //        uiView.addSubview(imageView)
        //        tableView.backgroundView = uiView
        
        
        view.addSubview(imageView)
        tableView.clipsToBounds = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.contentInset = UIEdgeInsetsMake(magicNumber, 0, 0, 0)
        tableView.reloadData()
        
       
        view.exchangeSubview(at: 1, withSubviewAt: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        
        
        
        
        
        //tableView.setContentOffset(CGPoint(x: 0, y: 250), animated: false)
        
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        //        self.navigationController?.navigationBar.isTranslucent = false
        //        self.navigationController?.view.backgroundColor = .clear
        
        //        if let navigationBar = self.navigationController?.navigationBar {
        //            print(navigationBar)
        //            navigationBar.isTranslucent = false
        //            navigationBar.shadowImage = UIImage()
        //            navigationBar.setBackgroundImage(UIImage(), for: .default)
        //
        //        }
        
        
        
    }
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    
    
    
}


extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "hmm", for: indexPath)
            cell.clipsToBounds = false
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "hmm2", for: indexPath)
            return cell
            
        }
    }
 
  
    
    
}

extension ViewController: UITableViewDelegate {
    
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("Content Offset Y: \(scrollView.contentOffset.y)")
        print("Content Inset: \(scrollView.contentInset)")

        let y = magicNumber - (scrollView.contentOffset.y + magicNumber)
        let height = min(max(y, self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height), 500)
        print(height)
        
      imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
                    print("hmmm")
        
        
        
      
        
        
   
        
        
    }
}

extension ViewController: UINavigationBarDelegate{
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}


