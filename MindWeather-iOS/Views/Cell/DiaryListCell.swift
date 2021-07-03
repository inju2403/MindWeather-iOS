//
//  DiaryListCell.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/27.
//

import UIKit

class DiaryListCell: UITableViewCell {

    @IBOutlet weak var diaryCardImage: UIImageView!
    @IBOutlet weak var summaryView: UILabel!
    
    @IBOutlet weak var yearText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var dayText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
