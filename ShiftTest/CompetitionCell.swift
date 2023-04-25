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
    var name: String
    var start_time: String
    var end_time: String
}
