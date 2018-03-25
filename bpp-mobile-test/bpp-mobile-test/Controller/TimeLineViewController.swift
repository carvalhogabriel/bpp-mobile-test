//
//  TimeLine.swift
//  bpp-mobile-test
//
//  Created by Gabriel Carvalho on 24/03/2018.
//  Copyright © 2018 GabrielGuerrero. All rights reserved.
//

import Foundation
import UIKit

class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Private Var's
    var timeLineResults: [NSDictionary]!
    var numberOfRowsInSection = 0
    
    // MARK: - Private Functions
    private func buildAlertError() {
        let genericError = UIAlertController(title: "Error!", message: "Generic Error", preferredStyle: .alert)
        genericError.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (_ in) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(genericError, animated: true, completion: nil)
    }
    
    private func prepareTableView() {
        if self.timeLineResults.count > 0 {
            self.numberOfRowsInSection = self.timeLineResults.count
        }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.prepareTableView()
        //Para fechar o loading
        self.dismiss(animated: true, completion: nil)
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
        return self.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = self.timeLineResults[indexPath.row] as? NSDictionary {
            let timeLineCell = tableView.dequeueReusableCell(withIdentifier: "TimeLineCell", for: indexPath) as!  TimeLineTableViewCell
            
            let mccDescription = item["mccDescription"] as? String
            
            switch mccDescription {
            case MccDescriptionEnum.Restaurants.rawValue?:
                timeLineCell.icon.image = UIImage(named: MccDescriptionEnum.Restaurants.rawValue)
            case MccDescriptionEnum.FastFood.rawValue?:
                timeLineCell.icon.image = UIImage(named: MccDescriptionEnum.FastFood.rawValue)
            case MccDescriptionEnum.Convenience.rawValue?:
                timeLineCell.icon.image = UIImage(named: MccDescriptionEnum.Convenience.rawValue)
            case MccDescriptionEnum.Bakery.rawValue?:
                timeLineCell.icon.image = UIImage(named: MccDescriptionEnum.Bakery.rawValue)
            default: break

            }
            timeLineCell.merchantDescription.text = mccDescription
            timeLineCell.name.text = item["merchantName"] as? String
            
            if let amount = item["transactionAmount"] as? Double {
                timeLineCell.amount.text = "$ \(amount.description)"
            }
            
            if let date = item["transactionFormattedDate"] as? String {
                timeLineCell.date.text = date
            }
            
            timeLineCell.status.text = item["transactionStatus"] as? String
            
            return timeLineCell
        }
        return UITableViewCell()
    }
}
