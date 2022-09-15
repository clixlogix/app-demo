//
//  ProfileBAPCell.swift
//  Doityourself
//

import UIKit


protocol ProfileBAPCellDelegate: NSObject {
    
    func chartArcTapped(arcType: String?)
    func chartBarTapped(barIndex: Int?, bapRaceDetails: [BapRaceDetails])
    
}


class ProfileBAPCell: UICollectionViewCell, SimplePieChartViewDelegate, TutorialChartViewDelegate {
    
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let yourStatsSideLineView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.orange
        view.layer.cornerRadius = 3
        return view
    }()

    let yourStatsLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "B.A.P.").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = AppColors.darkBlue
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let yourStatsView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.image = #imageLiteral(resourceName: "RectangleBack").withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let BxImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "B.A.P.").withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var overallStandingLabel: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Overall ", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.openSansBoldFontWith(size: 12)
        button.setTitleColor(AppColors.white, for: .normal)
        button.setImage(UIImage(named: "VectorDown")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageToRight()
//        button.addTarget(self, action: #selector(handleOverallTapped), for: .touchUpInside)
        return button
    }()
   
    lazy var chartView: SimplePieChartView = {
        let chartView = SimplePieChartView()
        chartView.clipsToBounds = false
        chartView.isUserInteractionEnabled = true
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.delegate = self
        return chartView
    }()
    
    let chartBgView: UIView = {
        let chartView = UIView()
        chartView.layer.cornerRadius = 125
        chartView.layer.borderWidth = 2
        chartView.layer.borderColor = AppColors.white?.cgColor
        chartView.clipsToBounds = true
        chartView.isUserInteractionEnabled = true
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()

    
    let overallBXScore: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.borderColor = AppColors.blueColor.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 15
        return view
    }()
    let overallScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.buttonDisabledTextColor
        label.text = "00:00"
        label.font = UIFont.openSansBoldItalicFontWith(size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    let overallBxImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "B.A.P.").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = AppColors.blueColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let overallBxScoreUPDownImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Polygon 1bxUp").withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    let linechartView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    
    
    lazy var chartViewBar: TutorialChartView = {
        let view = TutorialChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    let graphTopDatelbl: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.blueColor
        label.text = "March 23, 2021"
        label.font = UIFont.openSansSemiBoldFontWith(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    let graphLineView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightBlue2
        return view
    }()
    
    let graphBottomDatelbl: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.lightBlue2
        label.text = "Sep, 2020"
        label.font = UIFont.openSansSemiBoldFontWith(size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    let graphBottomDatelbl1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.lightBlue2
        label.text = "Dec, 2020"
        label.font = UIFont.openSansSemiBoldFontWith(size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    
    let graphBottomDatelbl2: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = AppColors.lightBlue2
        label.text = "March, 2021"
        label.font = UIFont.openSansSemiBoldFontWith(size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    
    let lastRaceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.black
        label.text = NSLocalizedString("Last Race", comment: "")
        label.font = UIFont.tekoSemiBoldFontWith(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var moreLastRaceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "add_circle_outline-24px 1addIcon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.setTitle(NSLocalizedString("View More", comment: ""), for: .normal)
        button.setTitleColor(AppColors.blueColor, for: .normal)
        button.contentHorizontalAlignment = .trailing
        button.tintColor = AppColors.blueColor
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.titleLabel?.font = UIFont.openSansBoldFontWith(size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        return button
    }()
    
    
    lazy var lastRacesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bounces = false
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = true
        tableView.register(ProfileBapLastCell.self, forCellReuseIdentifier: "CellId")
        return tableView
    }()
    
    
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var yourStatsViewHeightConstarint: NSLayoutConstraint?
    private var initalYourStatsViewHeight: CGFloat = 530
    private var linechartViewHeightConstraint: NSLayoutConstraint?
    private var initialLinechartHeight: CGFloat = 150
    
    var bapRaceDetails = [BapRaceDetails]() {
        
        didSet {
            
            DispatchQueue.main.async {
                
                self.lastRacesTableView.reloadData()
                
            }
            
        }
        
    }
    
    
    private var isShowingBAPChartRaces = false
    private var bapRaceType: String?
    var barChartWeeklyRaceData = [BarChartWeeklyRaceData]()
    weak var delegate: ProfileBAPCellDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        chartBgView.layer.borderColor = AppColors.white?.cgColor
        self.yourStatsView.isUserInteractionEnabled = true
        self.yourStatsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChartTapped(_: ))))
        
        let date = Date()
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM"
        let calendar = Calendar.current
        
        let year =  calendar.component(.year, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let currentMonthName = DateFormatter().monthSymbols[month - 1]
        
        var dateComponent = DateComponents()
        dateComponent.month = -1
        let threeMonthsDate = Calendar.current.date(byAdding: dateComponent, to: date) ?? Date()
        let threeMonth = calendar.component(.month, from: threeMonthsDate)
        let threeMonthName = DateFormatter().monthSymbols[threeMonth - 1]
        let threeYear = calendar.component(.year, from: threeMonthsDate)
        
        dateComponent.month = -2
        let sixMonthsDate = Calendar.current.date(byAdding: dateComponent, to: date) ?? Date()
        let sixMonth = calendar.component(.month, from: sixMonthsDate)
        let sixMonthName = DateFormatter().monthSymbols[sixMonth - 1]
        let sixYear = calendar.component(.year, from: sixMonthsDate)
        
        
        graphTopDatelbl.text = "\(currentMonthName) \(day), \(year)"
        
        graphBottomDatelbl.text = "\(sixMonthName.prefix(3)), \(sixYear)"
        graphBottomDatelbl1.text = "\(threeMonthName.prefix(3)), \(threeYear)"
        graphBottomDatelbl2.text = "\(currentMonthName.prefix(3)), \(year)"
        
        addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
       
        self.containerView.addSubview(yourStatsSideLineView)
        
        yourStatsSideLineView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: 4, height: 35))
        
        self.containerView.addSubview(yourStatsLabel)
        
        yourStatsLabel.centerYAnchor.constraint(equalTo: yourStatsSideLineView.centerYAnchor).isActive = true
        yourStatsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        
        yourStatsLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.containerView.addSubview(yourStatsView)
        
        yourStatsView.anchor(top: yourStatsSideLineView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 15, left: 20, bottom: 0, right: 20))
        
        yourStatsViewHeightConstarint = yourStatsView.heightAnchor.constraint(equalToConstant: initalYourStatsViewHeight)
        yourStatsViewHeightConstarint?.isActive = true
        
        self.yourStatsView.addSubview(BxImage)
        
        BxImage.anchor(top: yourStatsView.topAnchor, leading: yourStatsView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0), size: .init(width: 0, height: 40))
        
        self.yourStatsView.addSubview(overallStandingLabel)
        
        overallStandingLabel.anchor(top: yourStatsView.topAnchor, leading: nil, bottom: nil, trailing: yourStatsView.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 20), size: .init(width: 0, height: 12))
        
        
        self.yourStatsView.addSubview(chartBgView)
        chartBgView.centerXAnchor.constraint(equalTo: yourStatsView.centerXAnchor).isActive = true
        chartBgView.anchor(top: BxImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 35, left: 0, bottom: 0, right: 0), size: .init(width: 250, height: 250))
        
        self.yourStatsView.addSubview(chartView)
        
        chartView.centerXAnchor.constraint(equalTo: chartBgView.centerXAnchor).isActive = true
        chartView.centerYAnchor.constraint(equalTo: chartBgView.centerYAnchor).isActive = true
        chartView.widthAnchor.constraint(equalToConstant: 260).isActive = true
        chartView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        
        
        self.chartView.addSubview(overallBXScore)
        overallBXScore.centerXAnchor.constraint(equalTo: chartView.centerXAnchor).isActive = true
        overallBXScore.centerYAnchor.constraint(equalTo: chartView.centerYAnchor).isActive = true
        overallBXScore.heightAnchor.constraint(equalToConstant: 30).isActive = true
        overallBXScore.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        self.chartView.addSubview(overallScoreLabel)
        overallScoreLabel.centerXAnchor.constraint(equalTo: chartView.centerXAnchor).isActive = true
        overallScoreLabel.centerYAnchor.constraint(equalTo: chartView.centerYAnchor).isActive = true
        overallScoreLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let size = overallScoreLabel.text?.size(withAttributes: [.font: UIFont.openSansBoldItalicFontWith(size: 24)])
        overallScoreLabel.widthAnchor.constraint(equalToConstant: size!.width + 5).isActive = true
        
        self.chartView.addSubview(overallBxImage)
        overallBxImage.leftAnchor.constraint(equalTo: overallScoreLabel.leftAnchor, constant: -25).isActive = true
        overallBxImage.centerYAnchor.constraint(equalTo: chartView.centerYAnchor).isActive = true
        overallBxImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        overallBxImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        self.chartView.addSubview(overallBxScoreUPDownImage)
        overallBxScoreUPDownImage.leftAnchor.constraint(equalTo: overallScoreLabel.rightAnchor, constant: 5).isActive = true
        overallBxScoreUPDownImage.centerYAnchor.constraint(equalTo: chartView.centerYAnchor).isActive = true
        overallBxScoreUPDownImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
        overallBxScoreUPDownImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        
        self.yourStatsView.addSubview(linechartView)
        linechartView.anchor(top: chartView.bottomAnchor, leading: yourStatsView.leadingAnchor, bottom: nil, trailing: yourStatsView.trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 10))
        
        linechartViewHeightConstraint = linechartView.heightAnchor.constraint(equalToConstant: self.initialLinechartHeight)
        
        linechartViewHeightConstraint?.isActive = true
        
        
        self.yourStatsView.addSubview(chartViewBar)
        chartViewBar.anchor(top: chartView.bottomAnchor, leading: yourStatsView.leadingAnchor, bottom: nil, trailing: yourStatsView.trailingAnchor, padding: .init(top: 50, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 80))
    
        
        self.yourStatsView.addSubview(graphTopDatelbl)
        graphTopDatelbl.anchor(top: linechartView.topAnchor, leading: linechartView.leadingAnchor, bottom: nil, trailing: yourStatsView.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 18))
        
        
        self.yourStatsView.addSubview(graphLineView)
        graphLineView.anchor(top: chartViewBar.bottomAnchor, leading: linechartView.leadingAnchor, bottom: nil, trailing: linechartView.trailingAnchor, padding: .init(top: 12, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 1))
        
        self.yourStatsView.addSubview(graphBottomDatelbl)
        graphBottomDatelbl.anchor(top: chartViewBar.bottomAnchor, leading: linechartView.leadingAnchor, bottom: nil, trailing: linechartView.trailingAnchor, padding: .init(top: 15, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 12))
        
        self.yourStatsView.addSubview(graphBottomDatelbl1)
        graphBottomDatelbl1.anchor(top: chartViewBar.bottomAnchor, leading: linechartView.leadingAnchor, bottom: nil, trailing: linechartView.trailingAnchor, padding: .init(top: 15, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 12))
        
        self.yourStatsView.addSubview(graphBottomDatelbl2)
        graphBottomDatelbl2.anchor(top: chartViewBar.bottomAnchor, leading: linechartView.leadingAnchor, bottom: nil, trailing: linechartView.trailingAnchor, padding: .init(top: 15, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 12))
        
        
        self.linechartView.addSubview(lastRaceLabel)
        lastRaceLabel.anchor(top: chartViewBar.bottomAnchor, leading: linechartView.leadingAnchor, bottom: nil, trailing: yourStatsView.trailingAnchor, padding: .init(top: 50, left: 10, bottom: 0, right: 10))
        
        self.linechartView.addSubview(moreLastRaceButton)
        moreLastRaceButton.centerYAnchor.constraint(equalTo: lastRaceLabel.centerYAnchor).isActive = true
        moreLastRaceButton.trailingAnchor.constraint(equalTo: linechartView.trailingAnchor, constant: -10).isActive = true
        moreLastRaceButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.linechartView.addSubview(lastRacesTableView)
        
        lastRacesTableView.anchor(top: lastRaceLabel.bottomAnchor, leading: lastRaceLabel.leadingAnchor, bottom: linechartView.bottomAnchor, trailing: lastRaceLabel.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 15, right: 10))
        
        
    }
    
    @objc private func handleChartTapped(_ gesture: UITapGestureRecognizer) {
      
        print("Tapping on chart")
        let location = gesture.location(in: self.yourStatsView)
       
        if self.chartView.frame.contains(location) {
            
             
        }
        
    }
    
    func bapArcTapped(arcType: String?) {
     
        if self.bapRaceType == arcType {
            
            return
        }
        
        
        self.isShowingBAPChartRaces = true
        self.bapRaceType = arcType
        delegate?.chartArcTapped(arcType: arcType)
        
    }
    
    
    func barChartTapped(barIndex: Int) {
        
        isShowingBAPChartRaces = true
        self.bapRaceDetails.removeAll()
        self.lastRacesTableView.reloadData()
        self.bapRaceDetails = self.barChartWeeklyRaceData[barIndex - 1000].raceDetails
        self.lastRacesTableView.reloadData()
        delegate?.chartBarTapped(barIndex: barIndex, bapRaceDetails: self.bapRaceDetails)
        
    }
    
    
    func udpateChartHeight() {
        
        var bapRaceTableHeight: CGFloat = 0
        
        if self.isShowingBAPChartRaces == true {
            
            let count = self.bapRaceDetails.count
            
            if count == 0 {
                
                bapRaceTableHeight = 0
                
            } else {
                
                bapRaceTableHeight = CGFloat((55 * min(5, self.bapRaceDetails.count)) + 70)
            }
            
        } else {
            
            bapRaceTableHeight = 0
        }
        
        linechartViewHeightConstraint?.constant = initialLinechartHeight + bapRaceTableHeight
        yourStatsViewHeightConstarint?.constant = initalYourStatsViewHeight + bapRaceTableHeight
        
    }
    
    func updateBapData(userBapChartData: UserBapChartData) {
        
        if self.isShowingBAPChartRaces == false {
           
            chartView.segments = [
                
                Segment(color: piechart.ColorRace2 ?? UIColor(), value: 50, type: "PR", valueType: userBapChartData.prScore ?? "", scoreImage: "UP", selected: 0),
                Segment(color: piechart.ColorRace3 ?? UIColor(), value: 50, type: "SPDWRK", valueType: userBapChartData.spdwrkScore ?? "00:00", scoreImage: "", selected: 0),
                Segment(color: piechart.ColorRace1 ?? UIColor(), value: 50, type: "Race", valueType: userBapChartData.raceScore ?? "00:00", scoreImage: "UP", selected: 0)
                
            ]
            
            chartView.updateChart()
            
        }
        
        overallScoreLabel.text = userBapChartData.bxScore
        
        let bxScoreNo = Float(userBapChartData.bxScoreNo ?? 0)
        let oldBxScoreNo = Float(userBapChartData.oldBxScoreNo ?? 0)
        
        if bxScoreNo > oldBxScoreNo {
            
            self.overallBxScoreUPDownImage.image = #imageLiteral(resourceName: "Polygon 1bxUp")
            
        } else {
            
            self.overallBxScoreUPDownImage.image = #imageLiteral(resourceName: "Polygon 2")
        }
        
        var dataPoints = [Double]()
    
        for data in userBapChartData.userChartData {
            
            for race in data.raceDetails {
                
                dataPoints.append(race.paceTime)
                
            }
           
        }
        
        if dataPoints.count == 1 {
            
            for _ in 0...11 {
                
                dataPoints.append(0.0)
                
            }
                    
            
        }
        
        chartViewBar.setData(dataPoints)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ProfileBAPCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isShowingBAPChartRaces == true {
            
            return min(5, bapRaceDetails.count)
            
        } else {
            
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as? ProfileBapLastCell
        
        cell?.selectionStyle = .none
        
        let raceDetails = bapRaceDetails[indexPath.item]
        cell?.raceNameLabel.text = raceDetails.raceName
        cell?.racePaceDetailsLabel.text = raceDetails.timeElapsed
        
        let startDate = "\(raceDetails.startDate ?? "")"
        let epocTime = TimeInterval(startDate)! / 1000
        let date = Date(timeIntervalSince1970: epocTime)
        let eventDate = Alert.dateStringDesign(date)
        
        var timeStr = ""
        if raceDetails.startTime != nil {
            
            let dateTime = raceDetails.startTime ?? ""
            if dateTime != "" {
                timeStr = Alert.dateTimeDesign(date)
            }
        }
        
        cell?.raceDetailsLabel.text = "\(eventDate) / @\(timeStr)"
        
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 55
    }
    
    
}
