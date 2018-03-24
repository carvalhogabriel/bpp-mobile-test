//
//  TimeLine.swift
//  bpp-mobile-test
//
//  Created by School Picture on 24/03/2018.
//  Copyright © 2018 GabrielGuerrero. All rights reserved.
//

import Foundation
import UIKit

class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(3)
        //        return self.numberofRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let timeLineCell = tableView.dequeueReusableCell(withIdentifier: "timeLIneCell", for: indexPath) as!  TimeLineTableViewCell
        return timeLineCell
    }
}
