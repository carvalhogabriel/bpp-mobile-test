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
    
    //Método para pegar a contagem de linhas que terá a tableView
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
            
            //Descricao do tipo de lugar que foi realizada a transacao
            let mccDescription = item["mccDescription"] as? String
            
            switch mccDescription {
            case MccDescriptionEnum.Restaurants.rawValue?:
                timeLineCell.icon.image = UIImage(named: MccDescriptionEnum.Restaurants.rawValue)
            case MccDescriptionEnum.FastFood.rawValue?:
                timeLineCell.icon.image = UIImage(named: MccDescriptionEnum.FastFood.rawValue)
            case MccDescriptionEnum.Convenience.rawValue?:
                timeLineCell.icon.image = UIImage(named: MccDescriptionEnum.ConvenienceImageString.rawValue)
            case MccDescriptionEnum.Bakery.rawValue?:
                timeLineCell.icon.image = UIImage(named: MccDescriptionEnum.Bakery.rawValue)
            case MccDescriptionEnum.Wholesale.rawValue?:
                timeLineCell.icon.image = UIImage(named: MccDescriptionEnum.Wholesale.rawValue)
            default: break

            }
            timeLineCell.merchantDescription.text = mccDescription
            //Nome do local da transacao
            timeLineCell.name.text = item["merchantName"] as? String
            //Valor da transacao
            if let amount = item["transactionAmount"] as? Double {
                timeLineCell.amount.text = "$ \(amount.description)"
            }
            //Data da transacao
            if let dateString = item["transactionFormattedDate"] as? String {
                let dateComponents = dateString.components(separatedBy: "T")
                let splitDate = dateComponents[0]
                let splitTime = dateComponents[1]
                let date = DateUtils.sharedInstance.dateBR(splitDate)
                let stringDateBR = DateUtils.sharedInstance.dateToLocalDateStringBR(date!)
                timeLineCell.date.text = "\(stringDateBR) \(splitTime)"
            }
            //Status da transacao
            if let status = item["transactionStatus"] as? String {
                timeLineCell.status.text = status
                switch status {
                case StatusEnum.Settled.rawValue:
                    timeLineCell.status.textColor = UIColor(red: 0/255, green: 135/255, blue: 0/255, alpha: 1.0)
                case StatusEnum.Declined.rawValue:
                    timeLineCell.status.textColor = UIColor(red: 150/255, green: 38/255, blue: 0/255, alpha: 1.0)
                case StatusEnum.Pending.rawValue:
                    timeLineCell.status.textColor = UIColor(red: 210/255, green: 170/255, blue: 0/255, alpha: 1.0)
                default: break
                }
                
            }
            
            return timeLineCell
        }
        return UITableViewCell()
    }
}
