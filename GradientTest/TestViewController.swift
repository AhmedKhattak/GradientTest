//
//  TestViewController.swift
//  GradientTest
//
//  Created by Ahmed Khattak on 06/07/2018.
//  Copyright © 2018 Ahmed Khattak. All rights reserved.
//

import UIKit


class TestViewController: UIViewController {
    
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    
    private let magicNumber:CGFloat = 160
    
    private var offset_HeaderStop: CGFloat =  0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        offset_HeaderStop = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)!
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.contentInset = UIEdgeInsetsMake(magicNumber, 0, 0, 0)
        tableView.reloadData()
        
        
        //blurImageView.alpha = 0.0
        //blurImageView.image = UIImage(named: "audience")
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        
        //self.view.exchangeSubview(at: 0, withSubviewAt: 1)
        tableView.backgroundColor = .clear
        self.view.exchangeSubview(at: 0, withSubviewAt: 1)
        
        applyMotionEffect(to: imageView, magnitude: 30)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func mapRange<X:FloatingPoint>(value: X ,oldMin:X, oldMax:X, newMin:X, newMax:X ) -> X {
        
        /*
         
         map hmm from 0-100 to 50-100
         https://stackoverflow.com/questions/12931115/algorithm-to-map-an-interval-to-a-smaller-interval
         
         To map
         [A, B] --> [a, b]
         
         use this formula
         (val - A)*(b-a)/(B-A) + a
         
         so we can get the size we need !!!
         
         
         [0,100] --> [50,100]
         A = 0
         B = 100
         a = 50
         b = 100
         
         */
        
        let x = (value - oldMin) * (newMax - newMin) / ( oldMax - oldMin ) + newMin
        return x
    }
    
    

    func convertRangeToPercentage<X:FloatingPoint>(value: X ,min: X, max: X) -> X {
        
        /*
 
         percentage = (value - min) / (max - min)
         If you want to represent the percentage as a whole number instead of a decimal, simply multiply the result by 100.
         
         And here's the reverse (going from a percentage to a value):
         
         value = ((max - min) * percentage) + min
         The percentage here is a decimal. If your percentage is a whole number, simply divide it by 100 before inserting in this formula.
         
         */
        
        return 100 * abs((value - min) / (max - min))
        
        
    }
    
    
    func applyMotionEffect(to view: UIView, magnitude: CGFloat) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        
        let group = UIMotionEffectGroup()
        group.motionEffects =  [xMotion,yMotion]
        
        view.addMotionEffect(group)
        
    }

}

extension TestViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noice", for: indexPath) as! NoiceTableViewCell
            cell.weeow.layer.borderColor = UIColor.white.cgColor
            cell.weeow.layer.cornerRadius =  cell.weeow.frame.height / 2
            cell.weeow.layer.borderWidth = 4.0
            cell.weeow.layer.masksToBounds = true
            cell.weeow.clipsToBounds = true
            cell.selectionStyle = .none
            
            //cell.clipsToBounds = false
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "hmm2", for: indexPath)
            cell.selectionStyle = .none
            return cell
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100.0
        } else {
            return 60.0
        }
    }
    
    
    
    
}

extension TestViewController: UITableViewDelegate {
    
}

extension TestViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //print("Content Offset Y: \(scrollView.contentOffset.y)")
        //print("Content Inset: \(scrollView.contentInset)")
        
        let y = magicNumber - (scrollView.contentOffset.y + magicNumber)
        let height = min(max(y, 44 + UIApplication.shared.statusBarFrame.height), 500)
        //print(height)
        
        let offset = -scrollView.contentOffset.y

        
        
        if offset <= offset_HeaderStop && self.view.subviews.index(of: tableView) != 0 && self.view.subviews.index(of: headerView) != 1  {

            self.view.exchangeSubview(at: 0, withSubviewAt: 1)

        } else if offset >= offset_HeaderStop && self.view.subviews.index(of: tableView) == 0 && self.view.subviews.index(of: headerView) == 1 {
            self.view.exchangeSubview(at: 1, withSubviewAt: 0)
        }
        
        
        
        
        
        
        
        
        
        //        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
        headerHeight.constant = height
        self.view.layoutIfNeeded()
        
        
        
        
        guard let cells = tableView.visibleCells as? [UITableViewCell] else {
            print("no cell")

            return
        }


        

        guard let cell = cells[0] as? NoiceTableViewCell  else {
            return
           
            
        }
        
        
        //print(offset)
        if offset >= offset_HeaderStop && offset <= magicNumber  {
            // https://stackoverflow.com/questions/4241492/maths-range-to-percentage
           
            
            let hmm  =  convertRangeToPercentage(value: offset, min: offset_HeaderStop, max: magicNumber)
            
            // percent
            
            
            /*
             
             map hmm from 0-100 to 50-100
             https://stackoverflow.com/questions/12931115/algorithm-to-map-an-interval-to-a-smaller-interval
 
             To map
             [A, B] --> [a, b]
             
             use this formula
             (val - A)*(b-a)/(B-A) + a
             
             so we can get the size we need !!!
             
             
             [0,100] --> [50,100]
             A = 0
             B = 100
             a = 50
             b = 100
             
             */
            
           
            print("")
            
            
            let mapRangeOutput =  mapRange(value: hmm, oldMin: 0.0, oldMax: 100.0, newMin: 40, newMax: 120.0).rounded(.towardZero)
            
            print("map generator output : \(mapRangeOutput)")
            print("percentage:  \(hmm )")
            print("offset inside block  \(offset)")
            
            print("")
            
           
            

            //var t = CGAffineTransform.identity
            //t = t.scaledBy(x: mapRangeOutput, y: mapRangeOutput)
            // ... add as many as you want, then apply it to to the view
           // cell.weeow.transform = t
            
           
            cell.imageHeight.constant = mapRangeOutput
            cell.imageWidth.constant = mapRangeOutput
            
            cell.weeow.layer.cornerRadius = cell.imageHeight.constant / 2
            
//            let alpha = (hmm / 100).rounded(FloatingPointRoundingRule.toNearestOrEven)
//            print(alpha)
            //blurView.alpha = hmm / 100
            
           
            blurView.alpha = mapRange(value: hmm, oldMin: 0.0, oldMax: 100.0, newMin: 1.0, newMax: 0.0)
            //let x = mapRange(value: offset, oldMin: 0, oldMax: 100, newMin: 50, newMax: 100)
            //cell.imageYPosition.constant = x
           
            
            
            

        } else if offset > magicNumber {
            // this block fixes the overscroll visual artifacts
            blurView.alpha = 0.0
            cell.imageHeight.constant = 120
            cell.imageWidth.constant = 120
            
            cell.weeow.layer.cornerRadius = cell.imageHeight.constant / 2
        } else if offset <= offset_HeaderStop {
            blurView.alpha = 1.0
        }
        
        
        
         print("offset outsideblock  \(offset)")
        
        
        
//
//        if(scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 150.0) {
//            let  percent = (scrollView.contentOffset.y / 150.0);
//            self.headerView.layer.opacity = Float(percent);
//
//        } else if (scrollView.contentOffset.y > 150.0){
//             self.headerView.layer.opacity  = 1;
//
//        } else if (scrollView.contentOffset.y < 0) {
//            // do other ... ;
//        }
        
    
        
        

        
        
        
        
        
        
        
        
        
        
        
        
    }
}
