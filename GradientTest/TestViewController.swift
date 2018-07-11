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
    
    
    @IBOutlet weak var gradientView: GraphView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    
    // the strechy header default height
    private let headerDefaultHeight:CGFloat = 160
    
    // the minimum height of the header which is equal to the navbar + status bar height
    private var minimumHeaderHeight: CGFloat =  0
    
    private let maxHeaderHeight: CGFloat = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set minimum header height
        minimumHeaderHeight = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)!
        
        
        
        // table view setup
        tableView.dataSource = self
        tableView.delegate = self
        
        // set the contentInset to be equal to headers height to the cells show
        // below the headerview
        tableView.contentInset = UIEdgeInsetsMake(headerDefaultHeight, 0, 0, 0)
        
        tableView.reloadData()
        
        
        // scroll to top to show header view in streched mode
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        
    
        // set the bg color to clear to show headerview behind it
        tableView.backgroundColor = .clear
        
    
        // apply ios parallax effect on header view
        applyMotionEffect(to: imageView, magnitude: 30)
    }

    
    /// Maps a value from one range to another range
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
        
        return (value - oldMin) * (newMax - newMin) / ( oldMax - oldMin ) + newMin
        
    }
    
    

    /// Converts a range to a percentage percentage
    /// https://stackoverflow.com/questions/4241492/maths-range-to-percentage
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
    
    
    /// Applies a default ios wallpaper like motion effect to a view
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
            //cell.weeow.transform = CGAffineTransform.identity
            //cell.weeow.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
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
            return 223.0
        } else {
            return 60.0
        }
    }
    
    
    
    
}

extension TestViewController: UITableViewDelegate {
    
}


// Where all the magic happens
extension TestViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
       
        // calculate height for header
        let y = headerDefaultHeight - (scrollView.contentOffset.y + headerDefaultHeight)
        let height = min(max(y, 44 + UIApplication.shared.statusBarFrame.height), maxHeaderHeight)
       
        // set the header height
        headerHeight.constant = height
        
        // get offset and negate its sign
        let offset = -scrollView.contentOffset.y
        print(offset)
    
        // check if offset has reached min height and check subview position
        // then exchange their positions based on the condition
        // We need to do that so that the circle profile is behind the header view when it
        // reaches near it so it can move behind it
        // vice versa when it moves below it
        
        if offset <= minimumHeaderHeight && self.view.subviews.index(of: tableView) != 0 && self.view.subviews.index(of: headerView) != 1  {

            self.view.exchangeSubview(at: 0, withSubviewAt: 1)

        } else if offset >= minimumHeaderHeight && self.view.subviews.index(of: tableView) == 0 && self.view.subviews.index(of: headerView) == 1 {
            
            self.view.exchangeSubview(at: 1, withSubviewAt: 0)
        }
        
    
    
        // Get table view cells
        let cells = tableView.visibleCells
        
        // Check if cells are empty and then get the 0th cell and cast it
        guard !cells.isEmpty , let cell = cells[0] as? NoiceTableViewCell  else {
            return
        }
        
        
      
        // The real magic happens below
        // Check if offset is between minheaderheight and defaultheaderheight
        if offset >= minimumHeaderHeight && offset <= headerDefaultHeight  {
            
           

            // Convert the range to percentage and get the percent based on current offset value
            // 0.0% to 100.0%
            let hmm  =  convertRangeToPercentage(value: offset, min: minimumHeaderHeight, max: headerDefaultHeight)
            
            
            print(offset)
    
            
          
           
            print("")
            
            // Map the current percentage from one range to another to get a value that is clamped between our provided min and max range
            // 40 is the minimum profile pic height and 120 is the max and it should animate between the minheader and defualtheaderheight ranges !
            let mapRangeOutput =  mapRange(value: hmm, oldMin: 0.0, oldMax: 100.0, newMin: 0.45, newMax: 1.0)
            
            print("map generator output : \(mapRangeOutput)")
            print("percentage:  \(hmm )")
            print("offset inside block  \(offset)")
            print("image height: \(cell.weeow.frame.height)")

            print("")
            
           
            
            

        

            cell.weeow.applyTransform(withScale: mapRangeOutput, anchorPoint: CGPoint(x: 0.5, y: 1))
            // And recalculate the radius
            cell.weeow.layer.cornerRadius = cell.imageHeight.constant / 2
        

            // Convert the value from current range to 1.0 and 0.0 and set as alpha
            blurView.alpha = mapRange(value: hmm, oldMin: 0.0, oldMax: 100.0, newMin: 1.0, newMax: 0.0)
            
            
            
        

        } else if offset >= headerDefaultHeight {
            // If offset goes beyond headerDefaultHeight as the table view is strechy and bouncy
            // this block fixes the overscroll visual artifacts

            // Set the views to their end values in the animation

            blurView.alpha = 0.0
            cell.weeow.applyTransform(withScale: 1.0, anchorPoint: CGPoint(x: 0.5, y: 1))
            cell.weeow.layer.cornerRadius = cell.imageHeight.constant / 2


        } else if offset <= minimumHeaderHeight {

            // If offset goes behind minimumHeaderHeight as the table view is strechy and bouncy
            // this block fixes the underscroll visual artifacts

            // Set the views to their start values in the animation

            blurView.alpha = 1.0

              cell.weeow.applyTransform(withScale: 0.45, anchorPoint: CGPoint(x: 0.5, y: 1))
            cell.weeow.layer.cornerRadius = cell.imageHeight.constant / 2
        }
    
 
        
    }
}
