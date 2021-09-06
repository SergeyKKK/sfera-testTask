//
//  CellForTableView.swift
//  sferaTZ
//
//  Created by Serega Kushnarev on 28.09.2021.
//

import UIKit

// MARK: - CellForTableView

final class CellForTableView: UITableViewCell {
    
    // MARK: - Public properties
    
    static let cellIdentifier = "CellForTableView"
    var updateTable: (() -> ())?
    
    // MARK: - Private properties
    
    private var nameLabel = UILabel()
    private var secondsLabel = UILabel()
    private var countdownTimer: Timer?
    private var timer: Timer?
    private var timers: Timers?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(tap),
                                     userInfo: nil,
                                     repeats: true)
        
        backgroundColor = .gray.withAlphaComponent(0)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupCell()
    }
    
    // MARK: - Public methods
    
    func configuration(timers: Timers) {
        
        self.timers = timers
        let hour = timers.seconds / 3600
        let munutes = timers.seconds / 60
        let seconds = timers.seconds % 60
        
        nameLabel.text = timers.name
        secondsLabel.text = "\(hour):\(munutes):\(seconds)"
    }
    
    // MARK: - Private methods
    
    private func setupCell() {
        setupNameLabel()
        setupSecondsLabel()
    }
    
    private func setupNameLabel() {
        nameLabel.frame = CGRect(x: 10, y: 10, width: 150, height: 30)
        nameLabel.font = nameLabel.font.withSize(20)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
    }
    
    private func setupSecondsLabel() {
        secondsLabel.font = secondsLabel.font.withSize(20)
        secondsLabel.frame = CGRect(x: 200, y: 10, width: 150, height: 30)
        secondsLabel.textColor = .gray
        contentView.addSubview(secondsLabel)
    }
    
    // MARK: - Actions
    
    @objc
    private func tap() {
        if let timers = timers {
            timers.seconds -= 1
            let hour = timers.seconds / 3600
            let munutes = timers.seconds / 60
            let seconds = timers.seconds % 60
            secondsLabel.text = "\(hour):\(munutes):\(seconds)"
            
            if timers.seconds < 1 {
                timer?.invalidate()
                updateTable?()
            }
        }
    }
}


