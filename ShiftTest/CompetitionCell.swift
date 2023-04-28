//
//  CompetitionCell.swift
//  ShiftTest
//
//  Created by Константин Березовский on 2023-04-24.
//

import UIKit

class CompetitionCell: UITableViewCell {
    
    @IBOutlet weak var competitionNameLabel: UILabel!
    @IBOutlet weak var startEndTimeLabel: UILabel!
    
}

struct Competition: Codable {
    let name: String
    let start_time: String
    let end_time: String
    let url: String
}
