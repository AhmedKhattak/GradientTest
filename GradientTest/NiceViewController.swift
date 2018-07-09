//
//  NiceViewController.swift
//  GradientTest
//
//  Created by Ahmed Khattak on 08/07/2018.
//  Copyright © 2018 Ahmed Khattak. All rights reserved.
//

import UIKit

class NiceViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let uiImage = UIImage(named: "model")
        let uiImageView = UIImageView(image:uiImage )
        
        
        uiImageView.contentMode = .scaleAspectFill
        uiImageView.clipsToBounds = true
        uiImageView.autoresizingMask = [.flexibleHeight]
        uiImageView.frame = (self.navigationController?.navigationBar.frame)!
        self.navigationController?.navigationBar.addSubview(uiImageView)
        
        //self.navigationController?.navigationBar.sendSubview(toBack: uiImageView)
        //self.navigationController?.navigationBar.sendSubview(toBack: uiImageView)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400)
        
        self.navigationController?.navigationBar.sizeThatFits(CGSize.zero)
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
    
}


extension NiceViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "hmm", for: indexPath)
        cell.clipsToBounds = false
        return cell
        
    }
    
    
    
    
}

extension NiceViewController: UITableViewDelegate {
    
    
    
}
