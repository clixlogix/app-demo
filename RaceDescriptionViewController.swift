//
//  RaceDescriptionViewController.swift
//  Doityourself
//

import UIKit
import SkeletonView
import SDWebImage
import RealmSwift
import CoreLocation
import EventKit
import EventKitUI
import MGSwipeTableCell


class RaceDescriptionViewController: BaseViewController {
    
    
    // MARK: - UI Objects
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var customNavigationBar: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.titleLabel.textColor = AppColors.white
        view.navbarBackgroundView.backgroundColor = AppColors.navOrange
        view.rightMenuButton.setImage(#imageLiteral(resourceName: "arrow-backback").withRenderingMode(.alwaysTemplate), for: .normal)
        view.rightMenuButton.tintColor = AppColors.white
        return view
    }()
    
    let topSafeAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.navOrange
        return view
    }()
    
    let raceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bgupcomingRace")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.compositingFilter = "overlayBlendMode"
        return imageView
    }()
    
    let raceNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.blackWhite
        label.textAlignment = .left
        label.font = UIFont.tekoSemiBoldFontWith(size: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.isSkeletonable = true
        label.linesCornerRadius = 5
        return label
    }()
    
    let raceDateDetailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.font = UIFont.openSansSemiBoldFontWith(size: 14)
        button.setTitleColor(AppColors.lightBlue, for: .normal)
        return button
    }()
    
    lazy var raceAddToCalnderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "insert-invitation").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.openSansBoldFontWith(size: 14)
        button.setTitleColor(AppColors.white, for: .normal)
        button.backgroundColor = AppColors.orange
        button.layer.cornerRadius = AppConstants.buttonCornerRadius
        button.setTitle(NSLocalizedString("Add to Calendar", comment: ""), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 155).isActive = true
        button.addTarget(self, action: #selector(handleAddToCalenderTapped), for: .touchUpInside)
        return button
    }()
    
    let raceCreaterLabel: UILabel = {
        let label = UILabel()
        label.text = "Race Creator"
        label.textColor = AppColors.lightBlue
        label.font = UIFont.openSansSemiBoldFontWith(size: 14)
        return label
    }()
    
    let createrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    
    let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "premium badgepremiumIcon")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
    }()
    
    let createrNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.blackWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.openSansSemiBoldFontWith(size: 16)
        return label
    }()
    
    let bapView: BapView = {
        let view = BapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let raceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let raceActivityLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 8
        paragraphStyle.lineHeightMultiple = 1.05
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let raceFormatLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 8
        paragraphStyle.lineHeightMultiple = 1.05
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    let socialMediaSharingLabel: UILabel = {
        let label = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 8
        paragraphStyle.lineHeightMultiple = 1.05
        
        let attributedText = NSMutableAttributedString(string: "Social Media Sharing\n", attributes: [NSAttributedString.Key.foregroundColor: AppColors.lightBlue ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 14), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        attributedText.append(NSMutableAttributedString(string: "https://diyrace.com/pKtEa0Ke5", attributes: [NSAttributedString.Key.foregroundColor: AppColors.blackWhite ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 16), NSAttributedString.Key.paragraphStyle: paragraphStyle]))
        label.textAlignment = .left
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    let fbButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "share").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(hitFacebookShare), for: .touchUpInside)
        return button
    }()
    
    //    let twitterButton: UIButton = {
    //        let button = UIButton(type: .system)
    //        button.setImage(#imageLiteral(resourceName: "pnglot 1").withRenderingMode(.alwaysOriginal), for: .normal)
    //        button.addTarget(self, action: #selector(hitTwitterShare), for: .touchUpInside)
    //        return button
    //    }()
    
    let verticalSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.darkGrayColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var copyLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "content_copy_black_24dp 1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(hitCopyLink), for: .touchUpInside)
        return button
    }()
    
    let racersSideLineView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.orange
        view.layer.cornerRadius = 3
        return view
    }()
    
    let racersLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.darkBlue
        label.text = NSLocalizedString("Racers", comment: "")
        label.font = UIFont.tekoSemiBoldFontWith(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noRacersLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.darkBlue
        label.text = NSLocalizedString("No Racers", comment: "")
        label.font = UIFont.openSansRegularFontWith(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    lazy var racersDetailsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.estimatedRowHeight = 95
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = true
        tableView.isSkeletonable = true
        tableView.register(RacersTableViewCell.self, forCellReuseIdentifier: "CellId")
        return tableView
    }()
    
    lazy var raceDifficultyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RaceDifficultyCell.self, forCellReuseIdentifier: AppCellIds.raceDifficultyCellId.rawValue)
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.bounces = false
        tableView.delegate = self
        return tableView
    }()
    
    
    let remainingTimeView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.cellBgColor
        view.layer.cornerRadius = AppConstants.textFieldCornerRadius
        return view
    }()
    
    let topJoinView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomJoinButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .center
        button.setTitle(NSLocalizedString("Join", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.openSansBoldFontWith(size: 16)
        button.setTitleColor(AppColors.white, for: .normal)
        button.backgroundColor = AppColors.orange
        button.layer.cornerRadius = AppConstants.buttonCornerRadius
        button.addTarget(self, action: #selector(hitJoin), for: .touchUpInside)
        return button
    }()
    
    lazy var topJoinButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .center
        button.setTitle(NSLocalizedString("Join", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.openSansBoldFontWith(size: 16)
        button.setTitleColor(AppColors.white, for: .normal)
        button.backgroundColor = AppColors.orange
        button.layer.cornerRadius = AppConstants.buttonCornerRadius
        button.addTarget(self, action: #selector(hitJoin), for: .touchUpInside)
        return button
    }()
    
    let remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.timerBackgroundColor
        label.text = "00:00:00:00"
        label.textAlignment = .center
        label.font = UIFont.tekoBoldFontWith(size: 58)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.isSkeletonable = true
        label.linesCornerRadius = 5
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Days"
        label.textAlignment = .center
        label.textColor = AppColors.blackWhite
        label.font = UIFont.openSansSemiBoldFontWith(size: 10)
        return label
    }()
    
    let hoursLabel: UILabel = {
        let label = UILabel()
        label.text = "Hours"
        label.textAlignment = .center
        label.textColor = AppColors.blackWhite
        label.font = UIFont.openSansSemiBoldFontWith(size: 10)
        return label
    }()
    
    let minutesLabel: UILabel = {
        let label = UILabel()
        label.text = "Minutes"
        label.textAlignment = .center
        label.textColor = AppColors.blackWhite
        label.font = UIFont.openSansSemiBoldFontWith(size: 10)
        return label
    }()
    
    let secondsLabel: UILabel = {
        let label = UILabel()
        label.text = "Seconds"
        label.textAlignment = .center
        label.textColor = AppColors.blackWhite
        label.font = UIFont.openSansSemiBoldFontWith(size: 10)
        return label
    }()
    
    let weatherSideLineView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.orange
        view.layer.cornerRadius = 3
        return view
    }()
    
    let weatherDetailsView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 3
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.darkBlue
        label.text = NSLocalizedString("Weather Forecast", comment: "")
        label.font = UIFont.tekoSemiBoldFontWith(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.lightBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.openSansSemiBoldFontWith(size: 12)
        return label
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .center
        button.setTitle(NSLocalizedString("Edit Race", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.openSansBoldFontWith(size: 14)
        button.setTitleColor(AppColors.orange, for: .normal)
        button.backgroundColor = AppColors.lightOrange1
        button.isHidden = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "pencil")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = AppColors.orange
        button.addTarget(self, action: #selector(handleEditButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var yourstring = "https://diyrace.com/pKtEa0Ke5"
    private var secondsLeft = 600000
    private var timer: Timer?
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var racersTableViewHeightConstraint: NSLayoutConstraint?
    private var raceDetailViewModel = RaceDetailViewModel()
    private var raceDescriptionHeight: CGFloat = 0
    
    let locManager = CLLocationManager()
    
    private let raceDifficultyParamArray = [NSLocalizedString("Temp", comment: ""), NSLocalizedString("Humidity", comment: ""), NSLocalizedString("Altitude", comment: ""), NSLocalizedString("Wind", comment: "")]
    private var liveRaceViewModel = LiveRaceViewModel()
    private var raceDetailsArray = ["N/A", "N/A", "N/A", "N/A"]
    private var isWeatherDataAvailable = false
    private var isWeatherDataRequired = false
    var raceId = ""
    var navTitle = ""
    var raceData: GetRaceDataQuery.Data.GetRace.Datum?
    let realmData = try? Realm().objects(UserTable.self).first
    private var topJoinViewHeightConstraint: NSLayoutConstraint?
    private var editButtonHeightConstraint: NSLayoutConstraint?
    private var weatherDetailsHeightConstraint: NSLayoutConstraint?
    private let eventStore = EKEventStore()
    private var userCurrentLocation: CLLocation?
    private var futureRaceDateDifference = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar.delegate = self
        customNavigationBar.titleLabel.text = navTitle
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateRacersList), name: NSNotification.Name(rawValue: "RacersListUpdated"), object: nil)
        
        getData()
        configureHeader()
        configureRaceSubViews()
        
        
    }
    
    
    @objc private func handleUpdateRacersList() {
        
        getData()
        
    }
    
    
    func addInviteRacersFooter() {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: racersDetailsTableView.frame.width, height: 50))
        
        let button = UIButton(type: .system)
        button.setTitle("Invite Friends", for: .normal)
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = UIFont.openSansBoldFontWith(size: 16)
        button.setTitleColor(AppColors.orange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleInviteRacerTapped), for: .touchUpInside)
        
        footerView.addSubview(button)
        
        button.centerInSuperview()
        
        racersDetailsTableView.tableFooterView = footerView
        
    }
    
    
    @objc func updateTimer() {
        
        var hour: Int
        var minute: Int
        var second: Int
        var  day: Int
        secondsLeft -= 1
        
        print("secondsLeft -------->>>>>>", secondsLeft)
        
        let startDate = "\(self.raceData?.startDate ?? "0")"
        let epocTime = TimeInterval(startDate)! / 1000
        let date = Date(timeIntervalSince1970: epocTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        print("eventStartDateString date: ", date)
        let currentDateString = dateFormatter.string(from: Date())
        let eventDateString = dateFormatter.string(from: date)
        
        print("currentDateString: ", currentDateString)
        print("eventStartDateString: ", eventDateString)
        
        
        let currentDateTime = dateFormatter.date(from: currentDateString) ?? Date()
        let eventDate = dateFormatter.date(from: eventDateString) ?? Date()
        let eventStartTime = eventDate.addingTimeInterval(-10 * 60)
        
        print("currentDateTime: ", currentDateTime)
        print("eventStartTime: ", eventStartTime)
        
        if eventStartTime <= currentDateTime {
            
            timer?.invalidate()
            
            timer = nil
            
            let currentRaceDetails =  LiveRaceDataModel(raceFormat: self.raceData?.format?.name ?? "", raceFormatId: self.raceData?.format?._id ?? "", raceActivity: self.raceData?.activity?.name ?? "", raceActivityId: self.raceData?.activity?._id ?? "", raceStartDate: self.raceData?.startDate ?? "", raceStartTime: self.raceData?.startTime ?? "", raceName: self.raceData?.eventName ?? "", raceId: self.raceData?._id ?? "", recurrings: self.raceData?.interval ?? 0, raceLength: self.raceData?.raceLength ?? 0, recoveryLength: self.raceData?.recoveryLength ?? 0)
            
            let vc = LiveRaceViewController(isLiveRace: false, currentRaceData: currentRaceDetails)
            
            self.moveToController(viewController: vc, presentationType: .automatic, transitionAnimation: true)
            
        } else {
            
            hour = secondsLeft / 3600
            minute = (secondsLeft % 3600) / 60
            second = (secondsLeft % 3600) % 60
            day = ( secondsLeft / 3600) / 24
            
            if day > 0 {
                
                hour = (secondsLeft / 3600) % (day * 24)
            }
            
            remainingTimeLabel.text = "\(day < 10 ? "0\(day)" : "\(day)"):\(hour < 10 ? "0\(hour)" : "\(hour)"):\(minute < 10 ? "0\(minute)" : "\(minute)"):\(second < 10 ? "0\(second)" : "\(second)")"
            
        }
        
        
    }
    
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLocationServices()

    }
    
    
    deinit {
        
        timer?.invalidate()
        timer = nil
        self.locManager.stopUpdatingLocation()
        NotificationCenter.default.removeObserver(self)
        
    }
    
    
    private func configureHeader() {
        
        self.view.addSubview(customNavigationBar)
        
        self.view.addSubview(topSafeAreaView)
        
        topSafeAreaView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: customNavigationBar.topAnchor, trailing: self.view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        customNavigationBar.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 60))
        
    }
    
    
    @objc private func handleInviteRacerTapped() {
        
        self.moveToController(viewController: AddFriendViewController(addUserType: .addRacers, teamId: "", raceId: self.raceId), presentationType: .automatic, transitionAnimation: true)
        
    }
    
    @objc private func handleEditButtonTapped() {
     
        self.moveToController(viewController: CreateRaceViewController(isChallengingFriend: false, challengedFriend: nil, existingRaceDetails: self.raceData), presentationType: .automatic, transitionAnimation: true)
        
    }
    
    
    private func configureRaceSubViews() {
        
        
        self.view.addSubview(scrollView)
        
        scrollView.anchor(top: customNavigationBar.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)
        
        self.scrollView.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 1270)
        containerViewHeightConstraint?.isActive = true
        
        containerView.addSubview(editButton)
        containerView.addSubview(raceImageView)
        containerView.addSubview(topJoinView)
        containerView.addSubview(raceCreaterLabel)
        containerView.addSubview(createrImageView)
        containerView.addSubview(badgeImageView)
        containerView.addSubview(createrNameLabel)
        containerView.addSubview(bapView)
        containerView.addSubview(raceDescriptionLabel)
        
        editButton.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        editButtonHeightConstraint = editButton.heightAnchor.constraint(equalToConstant: 0)
        editButtonHeightConstraint?.isActive = true
        
        raceImageView.anchor(top: editButton.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 110))
        
        topJoinView.topAnchor.constraint(equalTo: raceImageView.bottomAnchor, constant: 0).isActive = true
        topJoinView.leadingAnchor.constraint(equalTo: raceImageView.leadingAnchor, constant: 0).isActive = true
        topJoinView.trailingAnchor.constraint(equalTo: raceImageView.trailingAnchor, constant: 0).isActive = true
        topJoinViewHeightConstraint = topJoinView.heightAnchor.constraint(equalToConstant: 100)
        topJoinViewHeightConstraint?.isActive = true
        
        
        topJoinView.addSubview(topJoinButton)
        
        topJoinButton.anchor(top: topJoinView.topAnchor, leading: topJoinView.leadingAnchor, bottom: nil, trailing: topJoinView.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 60))
        
        
        raceCreaterLabel.anchor(top: topJoinView.bottomAnchor, leading: raceImageView.leadingAnchor, bottom: nil, trailing: raceImageView.trailingAnchor, padding: .init(top: 35, left: 16, bottom: 0, right: 16))
        
        
        createrImageView.anchor(top: raceCreaterLabel.bottomAnchor, leading: raceCreaterLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        
        badgeImageView.anchor(top: createrImageView.topAnchor, leading: nil, bottom: nil, trailing: createrImageView.trailingAnchor, padding: .init(top: -2, left: 0, bottom: 0, right: -5), size: .init(width: 18, height: 18))
        
        createrNameLabel.centerYAnchor.constraint(equalTo: createrImageView.centerYAnchor).isActive = true
        createrNameLabel.leadingAnchor.constraint(equalTo: createrImageView.trailingAnchor, constant: 10).isActive = true
        
        createrNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: raceCreaterLabel.trailingAnchor, constant: -107).isActive = true
        
        bapView.leadingAnchor.constraint(equalTo: createrNameLabel.trailingAnchor, constant: 10).isActive = true
        bapView.centerYAnchor.constraint(equalTo: createrImageView.centerYAnchor).isActive = true
        bapView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        bapView.heightAnchor.constraint(equalToConstant: 26).isActive = true
       
        
        raceDescriptionLabel.anchor(top: createrImageView.bottomAnchor, leading: createrImageView.leadingAnchor, bottom: nil, trailing: raceCreaterLabel.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0))
        
        let horizontalLabelStackView = UIStackView(arrangedSubviews: [raceActivityLabel, raceFormatLabel])
        horizontalLabelStackView.axis = .horizontal
        horizontalLabelStackView.spacing = 10
        horizontalLabelStackView.alignment = .fill
        horizontalLabelStackView.distribution = .fillProportionally
        
        
        containerView.addSubview(horizontalLabelStackView)
        
        horizontalLabelStackView.anchor(top: raceDescriptionLabel.bottomAnchor, leading: raceDescriptionLabel.leadingAnchor, bottom: nil, trailing: raceDescriptionLabel.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0))
        
        let shareButtonStackView = UIStackView(arrangedSubviews: [fbButton])
        shareButtonStackView.axis = .horizontal
        shareButtonStackView.spacing = 0
        shareButtonStackView.alignment = .fill
        shareButtonStackView.distribution = .fillProportionally
        shareButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(shareButtonStackView)
        containerView.addSubview(verticalSeperatorView)
        containerView.addSubview(copyLinkButton)
        containerView.addSubview(socialMediaSharingLabel)
        
        
        shareButtonStackView.centerYAnchor.constraint(equalTo: socialMediaSharingLabel.centerYAnchor, constant: 18).isActive = true
        shareButtonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        shareButtonStackView.widthAnchor.constraint(equalToConstant: 27).isActive = true
        
        verticalSeperatorView.centerYAnchor.constraint(equalTo: shareButtonStackView.centerYAnchor).isActive = true
        verticalSeperatorView.trailingAnchor.constraint(equalTo: shareButtonStackView.leadingAnchor, constant: -15).isActive = true
        verticalSeperatorView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        verticalSeperatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        copyLinkButton.centerYAnchor.constraint(equalTo: verticalSeperatorView.centerYAnchor).isActive = true
        copyLinkButton.trailingAnchor.constraint(equalTo: verticalSeperatorView.leadingAnchor, constant: -15).isActive = true
        copyLinkButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        copyLinkButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        socialMediaSharingLabel.anchor(top: horizontalLabelStackView.bottomAnchor, leading: horizontalLabelStackView.leadingAnchor, bottom: nil, trailing: copyLinkButton.leadingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 10))
        
        containerView.addSubview(self.weatherDetailsView)
        
        self.weatherDetailsView.anchor(top: socialMediaSharingLabel.bottomAnchor, leading: self.containerView.leadingAnchor, bottom: nil, trailing: self.containerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        weatherDetailsHeightConstraint = self.weatherDetailsView.heightAnchor.constraint(equalToConstant: 305)
        weatherDetailsHeightConstraint?.isActive = true
        
        
        self.weatherDetailsView.addSubview(weatherSideLineView)
        
        weatherSideLineView.anchor(top: weatherDetailsView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: 4, height: 35))
        
        weatherDetailsView.addSubview(weatherLabel)
        
        weatherLabel.centerYAnchor.constraint(equalTo: weatherSideLineView.centerYAnchor).isActive = true
        weatherLabel.leadingAnchor.constraint(equalTo: weatherDetailsView.leadingAnchor, constant: 16).isActive = true
        
        weatherDetailsView.addSubview(raceDifficultyTableView)
        
        raceDifficultyTableView.anchor(top: weatherLabel.bottomAnchor, leading: weatherDetailsView.leadingAnchor, bottom: nil, trailing: weatherDetailsView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 205))
        
        
        self.containerView.addSubview(racersSideLineView)
        
        racersSideLineView.anchor(top: weatherDetailsView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: 4, height: 35))
        
        self.containerView.addSubview(racersLabel)
        
        racersLabel.centerYAnchor.constraint(equalTo: racersSideLineView.centerYAnchor).isActive = true
        racersLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        
        containerView.addSubview(racersDetailsTableView)
        
        racersDetailsTableView.topAnchor.constraint(equalTo: racersLabel.bottomAnchor, constant: 12).isActive = true
        racersDetailsTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        racersDetailsTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        
        racersTableViewHeightConstraint = racersDetailsTableView.heightAnchor.constraint(equalToConstant: 0)
        racersTableViewHeightConstraint?.isActive = true
        
        containerView.addSubview(raceNameLabel)
        
        raceNameLabel.topAnchor.constraint(equalTo: raceImageView.topAnchor, constant: 16).isActive = true
        raceNameLabel.trailingAnchor.constraint(equalTo: raceImageView.trailingAnchor, constant: -16).isActive = true
        raceNameLabel.leadingAnchor.constraint(equalTo: raceImageView.leadingAnchor, constant: 16).isActive = true
        
        let raceDetailsStackView = UIStackView(arrangedSubviews: [raceDateDetailsButton, raceAddToCalnderButton])
        raceDetailsStackView.axis = .horizontal
        raceDetailsStackView.spacing = 5
        raceDetailsStackView.distribution = .fillProportionally
        raceDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(raceDetailsStackView)
        
        raceDetailsStackView.bottomAnchor.constraint(equalTo: raceImageView.bottomAnchor, constant: -16).isActive = true
        raceDetailsStackView.leadingAnchor.constraint(equalTo: raceImageView.leadingAnchor, constant: 16).isActive = true
        raceDetailsStackView.trailingAnchor.constraint(equalTo: raceImageView.trailingAnchor, constant: -16).isActive = true
        
        
        containerView.addSubview(remainingTimeView)
        
        remainingTimeView.anchor(top: racersDetailsTableView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 35, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 110))
        
        containerView.addSubview(bottomJoinButton)
        
        bottomJoinButton.anchor(top: remainingTimeView.bottomAnchor, leading: remainingTimeView.leadingAnchor, bottom: nil, trailing: remainingTimeView.trailingAnchor, padding: .init(top: 44, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 60))
        
        
        let daysStackView = UIStackView(arrangedSubviews: [dayLabel, hoursLabel, minutesLabel, secondsLabel])
        daysStackView.alignment = .fill
        daysStackView.distribution = .fillEqually
        daysStackView.axis = .horizontal
        daysStackView.spacing = 0
        daysStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let remaningTimeStackView = UIStackView(arrangedSubviews: [remainingTimeLabel, daysStackView])
        remaningTimeStackView.axis = .vertical
        remaningTimeStackView.spacing = -22
        remaningTimeStackView.alignment = .fill
        remaningTimeStackView.distribution = .fillProportionally
        remaningTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        remainingTimeView.addSubview(remaningTimeStackView)
        
        remaningTimeStackView.centerXAnchor.constraint(equalTo: remainingTimeView.centerXAnchor).isActive = true
        remaningTimeStackView.centerYAnchor.constraint(equalTo: remainingTimeView.centerYAnchor).isActive = true
        
        remaningTimeStackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.containerView.addSubview(noRacersLabel)
        noRacersLabel.centerYAnchor.constraint(equalTo: racersDetailsTableView.centerYAnchor).isActive = true
        noRacersLabel.centerXAnchor.constraint(equalTo: racersDetailsTableView.centerXAnchor).isActive = true
        
        containerView.addSubview(cityNameLabel)
        
        cityNameLabel.centerYAnchor.constraint(equalTo: weatherLabel.centerYAnchor).isActive = true
        cityNameLabel.leadingAnchor.constraint(equalTo: weatherLabel.trailingAnchor, constant: 10).isActive = true
        cityNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        
    }
    
    @objc func hitCopyLink(_ sender: UIButton) {
        
        UIPasteboard.general.string = yourstring
        showToast(message: NSLocalizedString("Link Copied", comment: ""))
        
    }
    
    
    @objc func hitFacebookShare(_ sender: UIButton) {
        // set up activity view controller
        let textToShare = [ yourstring ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFlickr, UIActivity.ActivityType.postToVimeo, UIActivity.ActivityType.postToTencentWeibo, UIActivity.ActivityType.postToWeibo ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //    @objc func hitTwitterShare(_ sender: UIButton) {
    //        // set up activity view controller
    //        let textToShare = [ yourstring ]
    //        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    //        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
    //
    //        // exclude some activity types from the list (optional)
    //        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToFlickr, UIActivity.ActivityType.postToVimeo, UIActivity.ActivityType.postToTencentWeibo, UIActivity.ActivityType.postToWeibo ]
    //
    //        // present the view controller
    //        self.present(activityViewController, animated: true, completion: nil)
    //    }
    //
    
    
    func getData() {
        
        if  Alert.netwokStatus() {
            
            DispatchQueue.main.async { [weak self] in
                
                Alert.hudShow(self?.view ?? UIView())
            }
            
            raceDetailViewModel.getRaceData(raceId: self.raceId) { [weak self] error, apiResponse in
                
                DispatchQueue.main.async { [weak self] in
                    
                    Alert.hudHide(self?.view ?? UIView())
                }
                
                if error != nil || apiResponse?.success == false {
                    
                    if apiResponse?.statusCode == 401 {
                        
                        Alert.logoutSession()
                        
                        return
                    }
                    
                    self?.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: error?.localizedDescription ?? apiResponse?.message)
                    
                    return
                    
                } else {
                    
                    
                    DispatchQueue.main.async { [weak self] in
                        
                        self?.raceData = apiResponse?.data
                        self?.setData()
                        self?.racersDetailsTableView.reloadData()
                        
                    }
                    
                    return
                    
                }
                
            }
            
        } else {
            
            DispatchQueue.main.async { [weak self] in
                
                Alert.hudHide(self?.view ?? UIView())
            }
            
            self.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: NSLocalizedString("networkIssue", comment: ""))
            
            return
        }
    }
    
    func setData() {
        
        self.editButton.isHidden = true
        
        let bxScoreNo = Float(raceData?.creater?.bxScoreNo ?? 0)
        let oldBxScoreNo = Float(raceData?.creater?.oldBxScoreNo ?? 0)
        
        bapView.updateBapView(bxScore: raceData?.creater?.bxScore, oldBxScore: oldBxScoreNo, newBxScore: bxScoreNo)
        
        if self.raceData?.creater?._id == self.realmData?.userId {
            
            self.editButton.isHidden = false
            
            addInviteRacersFooter()
            
        } else if let coCreator = self.raceData?.coCreator {
            
            if coCreator.contains(self.realmData?.userId) {
                
                self.editButton.isHidden = false
                
                addInviteRacersFooter()
                
            }
            
        }
        
        
        let startDate = "\(raceData?.startDate ?? "")"
        let epocTime = TimeInterval(startDate)! / 1000
        let date = Date(timeIntervalSince1970: epocTime)
        let eventDate = Alert.dateStringDesign(date)
        
        print("eventDate------121212121", eventDate)
        
        var timeStr = ""
        var dateTimedata = Date()
        
        if raceData?.startTime != nil {
            
            let dateTime = raceData?.startTime ?? ""
            
            if dateTime != "" {
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(identifier: "UTC")!
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateTimedata = dateFormatter.date(from: "\(Alert.dateString(date)) \(dateTime)") ?? Date()
                timeStr = Alert.timeString(dateTimedata)
                
            }
            
        }
        
        if self.raceData?.addToCalendar == true {
            
            self.raceAddToCalnderButton.isHidden = true
            
        }
        
        raceImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        raceImageView.sd_setImage(with: URL(string: "\(raceData?.image ?? "")"), placeholderImage: #imageLiteral(resourceName: "bgupcomingRace"))
        raceImageView.alpha = 0.5
        raceNameLabel.text = "\(raceData?.eventName ?? "")"
        
        raceDateDetailsButton.setTitle("\(eventDate) / @\(timeStr)", for: .normal)
        
        let nameLetter = "\(raceData?.creater?.userName?.prefix(1) ?? "")".capitalizingFirstLetter()
        let placeholderImage: UIImage = Alert.imageWith(name: nameLetter, fontSize: 50)!
        
        
        createrImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        createrImageView.sd_setImage(with: URL(string: "\(raceData?.creater?.profilePic ?? "")"), placeholderImage: placeholderImage)
        yourstring = raceData?.socialMediaUrl ?? ""
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 8
        paragraphStyle.lineHeightMultiple = 1.05
        
        
        if raceData?.creater?.hideRealName == false {
            
            createrNameLabel.text = "\(raceData?.creater?.firstName?.capitalizingFirstLetter() ?? "") \(raceData?.creater?.lastName?.capitalizingFirstLetter() ?? "")"
            
        } else {
            
            createrNameLabel.text = "\(raceData?.creater?.userName ?? "")"
            
        }
        
        
        let attributedTextDescription = NSMutableAttributedString(string: "Description\n", attributes: [NSAttributedString.Key.foregroundColor: AppColors.lightBlue ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 14), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        attributedTextDescription.append(NSMutableAttributedString(string: "\(raceData?.description ?? "")", attributes: [NSAttributedString.Key.foregroundColor: AppColors.blackWhite ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 16), NSAttributedString.Key.paragraphStyle: paragraphStyle]))
        raceDescriptionLabel.attributedText = attributedTextDescription
        
        let attributedTextFormat = NSMutableAttributedString(string: "Format\n", attributes: [NSAttributedString.Key.foregroundColor: AppColors.lightBlue ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 14), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        attributedTextFormat.append(NSMutableAttributedString(string: "\(raceData?.format?.name ?? "")", attributes: [NSAttributedString.Key.foregroundColor: AppColors.blackWhite ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 16), NSAttributedString.Key.paragraphStyle: paragraphStyle]))
        raceFormatLabel.attributedText = attributedTextFormat
        
        let attributedTextActivity = NSMutableAttributedString(string: "Activity\n", attributes: [NSAttributedString.Key.foregroundColor: AppColors.lightBlue ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 14), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        attributedTextActivity.append(NSMutableAttributedString(string: "\(raceData?.activity?.name ?? "")", attributes: [NSAttributedString.Key.foregroundColor: AppColors.blackWhite ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 16), NSAttributedString.Key.paragraphStyle: paragraphStyle]))
        raceActivityLabel.attributedText = attributedTextActivity
        
        let isoDate = "\(Alert.dateString(date)) \(Alert.timeToStr(dateTimedata)) +0000"
        let endDate = Alert.finalstrToDate(isoDate)
        let sstartDate = Date()
        let differenceInSeconds = Int(endDate.timeIntervalSince(sstartDate))
        
        let secondsInADay = 86400
        
        let dayDifference = (differenceInSeconds / secondsInADay)
        
        self.futureRaceDateDifference = dayDifference
        
        if dayDifference > 3 {
            
            self.isWeatherDataRequired = false
            print("No Need to show weather-----")
            
        } else {
            
            self.isWeatherDataRequired = true
            self.getWeatherData(dateDifference: self.futureRaceDateDifference)
            print("Show Weather data----")
            
        }
        
        
        secondsLeft = differenceInSeconds
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            
            self?.updateTimer()
        }
        
        raceDescriptionHeight = heightForString(attributedTextDescription, width: self.view.frame.width - 32)
        
        setupViewHeight()
        
    }
    
    @objc private func handleAddToCalenderTapped() {
        
        let startDate = "\(raceData?.startDate ?? "")"
        
        let eventRepeatEndDate = "\(raceData?.eventRepeatEndDate ?? "")"
        
        let currentRaceType = self.raceData?.format?.name
        
        print("currentRaceType---->", currentRaceType)
        
        let raceDistance = RaceConversionToMiles().raceToMiles(raceType: currentRaceType ?? "")
        
        print("raceDistance---->", raceDistance)
        
        let raceDistanceInKm = raceDistance * 1.609 // For conversion from miles to km
        
        print("raceDistanceInKm---->", raceDistanceInKm)
        
        let raceEndTimeInMinutes = raceDistanceInKm * 24
        
        print("raceEndTimeInMinutes---->", raceEndTimeInMinutes)
        
        let raceStartEpocTime = TimeInterval(startDate)! / 1000
        let raceStartDate = Date(timeIntervalSince1970: raceStartEpocTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        
        let raceStartDateString = dateFormatter.string(from: raceStartDate)
        
        let calendar = Calendar.current
        
        let convertedRaceStart = dateFormatter.date(from: raceStartDateString) ?? Date()
        
        let raceEndDate = calendar.date(byAdding: .minute, value: Int(raceEndTimeInMinutes), to: convertedRaceStart) ?? Date()
        
        print("raceEndDate---->", raceEndDate)
        
        let reminderDate = calendar.date(byAdding: .minute, value: -10, to: convertedRaceStart) ?? Date()
        
        var raceEndEpocTime = 0.0
        
        var recurrence: EKRecurrenceRule?
        
        if eventRepeatEndDate != "" {
            
            raceEndEpocTime = TimeInterval(eventRepeatEndDate)! / 1000
          
            let recurrenceEnd = EKRecurrenceEnd(end: dateFormatter.date(from: "\(Date(timeIntervalSince1970: raceEndEpocTime))") ?? Date())
            
            if self.raceData?.eventRepeat == "Daily" {
                
                recurrence = EKRecurrenceRule(recurrenceWith: EKRecurrenceFrequency.daily, interval: 1, end: recurrenceEnd)
                
                
            } else if self.raceData?.eventRepeat == "Weekly" {
                
                recurrence = EKRecurrenceRule(recurrenceWith: EKRecurrenceFrequency.weekly, interval: 1, end: recurrenceEnd)
                
            } else if self.raceData?.eventRepeat == "Monthly" {
                
                recurrence = EKRecurrenceRule(recurrenceWith: EKRecurrenceFrequency.monthly, interval: 1, end: recurrenceEnd)
                
            }
            
            
        }
        
        
        addEventInUserCalnder(raceName: raceData?.eventName ?? "", startDate: convertedRaceStart, endDate: raceEndDate, reminderDate: reminderDate, recurrence: recurrence)
        
    }
    
    
    
    private func addEventInUserCalnder(raceName: String, startDate: Date, endDate: Date, reminderDate: Date, recurrence: EKRecurrenceRule?) {
        
        eventStore.requestAccess( to: EKEntityType.event, completion: { [weak self] (granted, error) in
            
            DispatchQueue.main.async {
                
                guard let self = self else { return }
                
                if (granted) && (error == nil) {
                    
                    var attendees = [EKParticipant]()
                    
                    let invterCount = self.raceData?.inviter?.count ?? 0
                    
                    for i in 0 ..< invterCount - 1 {
                        
                        if let attendee = self.createParticipant(email: self.raceData?.inviter?[i]?.userName ?? "") {
                            
                            attendees.append(attendee)
                            
                        }
                        
                    }
                    
                    let event = EKEvent(eventStore: self.eventStore)
                    event.title = raceName
                    event.startDate = startDate
                    event.notes = self.raceData?.description
                    event.endDate = endDate
                    event.calendar = self.eventStore.defaultCalendarForNewEvents
                    event.setValue(attendees, forKey: "attendees")
                    event.url = URL(string: self.raceData?.socialMediaUrl ?? "")
                    
                    if recurrence != nil {
                        
                        event.addRecurrenceRule(recurrence!)
                        
                    }
                    
                    event.isAllDay = false
                    event.addAlarm(EKAlarm(absoluteDate: reminderDate))
                    
                    
                    
                    let eventController = EKEventEditViewController()
                    eventController.event = event
                    eventController.eventStore = self.eventStore
                    eventController.editViewDelegate = self
                    
                    self.present(eventController, animated: true, completion: nil)
                    
                } else if error != nil && granted == true {
                    
                    self.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: error?.localizedDescription)
                    
                    return
                    
                } else if granted == false {
                    
                    self.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: NSLocalizedString("Please allow calendar access to DIY", comment: ""))
                    
                    return
                }
                
            }
            
        })
        
    }
    
    private func createParticipant(email: String) -> EKParticipant? {
        
        let clazz: AnyClass? = NSClassFromString("EKAttendee")
        if let type = clazz as? NSObject.Type {
            let attendee = type.init()
            attendee.setValue(email, forKey: "emailAddress")
            return attendee as? EKParticipant
        }
        return nil
    }
    
    private func setupViewHeight() {
        
        var joinButtonHeight: CGFloat = 120
        var topJoinButtonHeight: CGFloat = 100
        var iniviteRaceButtonHeight: CGFloat = 0
        var editButtonHeight: CGFloat = 0
        var weatherTableHeight: CGFloat = 0
        
        if self.raceData?.creater?._id == self.realmData?.userId {
            
            iniviteRaceButtonHeight = 50
            editButtonHeight = 50
            
        } else if let coCocreatorDetails = self.raceData?.coCreator {
            
            if coCocreatorDetails.contains(self.realmData?.userId) {
                
                iniviteRaceButtonHeight = 50
                editButtonHeight = 50
            }
            
        }
        
        if self.isWeatherDataRequired == true {
            
            self.weatherDetailsView.isHidden = false
            weatherTableHeight = 305
            
        } else {
            
            self.weatherDetailsView.isHidden = true
            weatherTableHeight = 0
        }
        
        print("iniviteRaceButtonHeight---->", iniviteRaceButtonHeight)
        
        if self.raceData?.creater?._id == self.realmData?.userId {
            
            joinButtonHeight = 10
            topJoinButtonHeight = 0
            topJoinView.isHidden = true
            bottomJoinButton.isHidden = true
            
        } else {
            
            self.raceData?.inviter?.forEach({ inviter in
                
                if inviter?.isJoin == true && inviter?._id == self.realmData?.userId {
                    
                    topJoinButtonHeight = 0
                    joinButtonHeight = 10
                    bottomJoinButton.isHidden = true
                    topJoinView.isHidden = true
                    
                }
                
            })
            
        }
        
        
        let tableViewCellCount = self.raceData?.inviter?.count ?? 0
        
        
        let raceTypeLabelHeight: CGFloat = raceDescriptionHeight
        
        var racersTableHeight: CGFloat = CGFloat(tableViewCellCount * 80)
        
        if racersTableHeight == 0 {
            
            racersTableHeight = 160
            racersDetailsTableView.isHidden = true
            noRacersLabel.isHidden = false
            
        } else {
            
            racersDetailsTableView.isHidden = false
            noRacersLabel.isHidden = true
            
        }
        
        var initalHeight: CGFloat = 0
        
        print("self.view.safeAreaInsets.top: ", self.view.safeAreaInsets.bottom )
        
        initalHeight = 660 + racersTableHeight + raceTypeLabelHeight + joinButtonHeight + topJoinButtonHeight + iniviteRaceButtonHeight + editButtonHeight
        
        self.weatherDetailsHeightConstraint?.constant = weatherTableHeight
        editButtonHeightConstraint?.constant = editButtonHeight
        topJoinViewHeightConstraint?.constant = topJoinButtonHeight
        racersTableViewHeightConstraint?.constant = racersTableHeight + iniviteRaceButtonHeight
        containerViewHeightConstraint?.constant = initalHeight + weatherTableHeight
        
        containerView.isHidden = false
        
        DispatchQueue.main.async { [weak self] in
            
            Alert.hudHide(self?.view ?? UIView())
            
        }
        
    }
    
    private func heightForString(_ str: NSAttributedString, width: CGFloat) -> CGFloat {
        
        let ts = NSTextStorage(attributedString: str)
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let tc = NSTextContainer(size: size)
        tc.lineFragmentPadding = 0.0
        
        let lm = NSLayoutManager()
        lm.addTextContainer(tc)
        
        ts.addLayoutManager(lm)
        lm.glyphRange(forBoundingRect: CGRect(origin: .zero, size: size), in: tc)
        
        let rect = lm.usedRect(for: tc)
        
        return rect.integral.size.height
    }
    
    
    @objc func hitJoin(_ button: UIButton) {
        
        if  Alert.netwokStatus() {
            
            DispatchQueue.main.async { [weak self] in
                
                Alert.hudShow(self?.view ?? UIView())
            }
            
            
            raceDetailViewModel.joinRace(raceId: self.raceId) { [weak self] error, apiResponse in
                
                
                if error != nil || apiResponse?.success == false {
                    
                    DispatchQueue.main.async { [weak self] in
                        
                        Alert.hudHide(self?.view ?? UIView())
                    }
                    
                    if apiResponse?.statusCode == 401 {
                        
                        Alert.logoutSession()
                        
                        return
                    }
                    
                    self?.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: error?.localizedDescription ?? apiResponse?.message)
                    
                    return
                    
                } else {
                    
                    self?.getData()
                    
                    return
                    
                }
                
            }
            
        } else {
            
            DispatchQueue.main.async { [weak self] in
                
                Alert.hudHide(self?.view ?? UIView())
            }
            
            self.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: NSLocalizedString("networkIssue", comment: ""))
            
            return
        }
    }
    
}



extension RaceDescriptionViewController: UITableViewDelegate, SkeletonTableViewDataSource, CustomNavigationBarDelegate, MGSwipeTableCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
            
        case raceDifficultyTableView:
            
            return raceDifficultyParamArray.count
            
        case racersDetailsTableView:
            
            return self.raceData?.inviter?.count ?? 0
            
        default:
            
            return 0
        }
        
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        
        return "CellId"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
            
        case raceDifficultyTableView:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AppCellIds.raceDifficultyCellId.rawValue, for: indexPath) as? RaceDifficultyCell
            
            cell?.sepertatorView.isHidden = true
            cell?.selectionStyle = .none
            cell?.backgroundColor = AppColors.lightPink
            cell?.optionLabel.text = raceDifficultyParamArray[indexPath.item]
            cell?.valueLabel.text = raceDetailsArray[indexPath.item]
            
            return cell ?? UITableViewCell()
            
        case racersDetailsTableView:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellId") as? RacersTableViewCell
            cell?.backgroundColor = .clear
            cell?.selectionStyle = .none
            cell?.isSkeletonable = true
            
            let inviterData = self.raceData?.inviter?[indexPath.item]
            if inviterData?.hideRealName == false {
                cell?.racerNameLabel.text = "\(inviterData?.firstName?.capitalizingFirstLetter() ?? "") \(inviterData?.lastName?.capitalizingFirstLetter() ?? "")"
            } else {
                cell?.racerNameLabel.text = inviterData?.userName
            }
        
            
            cell?.bapView.updateBapView(bxScore: inviterData?.bxScore, oldBxScore: Float(inviterData?.oldBxScoreNo ?? 0.0), newBxScore: Float(inviterData?.bxScoreNo ?? 0.0))
            
            
            if self.raceData?.creater?._id == self.realmData?.userId || ((self.raceData?.coCreator?.contains(self.realmData?.userId)) ?? false) {
                
                cell?.delegate = self
                cell?.layer.cornerRadius = AppConstants.textFieldCornerRadius
                cell?.clipsToBounds = true
                cell?.leftSwipeSettings.transition = .drag
                cell?.rightSwipeSettings.transition = .drag
                
                if inviterData?._id != self.raceData?.creater?._id && !(self.raceData?.coCreator?.contains(inviterData?._id) ?? false) && inviterData?._id != self.realmData?.userId {
                    
                    if inviterData?.isJoin == false {
                        
                        cell?.leftButtons = [MGSwipeButton(title: "", icon: UIImage(named: "resend_invite"), backgroundColor: AppColors.orange), MGSwipeButton(title: "", icon: UIImage(named: "add_cocreator"), backgroundColor: AppColors.coCreatorBgColor)]
                        
                    } else {
                        
                        cell?.leftButtons = [MGSwipeButton(title: "", icon: UIImage(named: "add_cocreator"), backgroundColor: AppColors.coCreatorBgColor)]
                        
                    }
                    
                    
                } else if inviterData?._id != self.raceData?.creater?._id {
                    
                    if inviterData?.isJoin == false {
                        
                        cell?.leftButtons = [MGSwipeButton(title: "", icon: UIImage(named: "resend_invite"), backgroundColor: AppColors.orange)]
                        
                    }
                    
                }
                
                if self.raceData?.creater?._id != inviterData?._id {
                    
                    if self.raceData?.coCreator?.contains(self.realmData?.userId) ?? false && inviterData?._id == self.realmData?.userId {
                        
                        
                    } else {
                        
                        cell?.rightButtons = [MGSwipeButton(title: "", icon: UIImage(named: "remove_invite"), backgroundColor: AppColors.blueColor)]
                        
                    }
                    
                }
                
            }
            
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.paragraphSpacing = 4
            paragraphStyle.lineHeightMultiple = 1.05
            
            let attributedTextFriends = NSMutableAttributedString(string: "Friends Rank\n", attributes: [NSAttributedString.Key.foregroundColor: AppColors.lightBlue ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 8), NSAttributedString.Key.paragraphStyle: paragraphStyle])
            
            attributedTextFriends.append(NSMutableAttributedString(string: "\(inviterData?.friendsRank ?? "NA")", attributes: [NSAttributedString.Key.foregroundColor: AppColors.blackWhite ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 14), NSAttributedString.Key.paragraphStyle: paragraphStyle]))
            cell?.friendsRankButton.setAttributedTitle(attributedTextFriends, for: .normal)
            
            
            let attributedTextGlobal = NSMutableAttributedString(string: "Global Rank\n", attributes: [NSAttributedString.Key.foregroundColor: AppColors.lightBlue ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 8), NSAttributedString.Key.paragraphStyle: paragraphStyle])
            
            attributedTextGlobal.append(NSMutableAttributedString(string: "\(Int(inviterData?.globalRank ?? 0.0))", attributes: [NSAttributedString.Key.foregroundColor: AppColors.blackWhite ?? UIColor.white, NSAttributedString.Key.font: UIFont.openSansSemiBoldFontWith(size: 14), NSAttributedString.Key.paragraphStyle: paragraphStyle]))
            
            cell?.globalRankButton.setAttributedTitle(attributedTextGlobal, for: .normal)
            
            let nameLetter = "\(inviterData?.userName?.prefix(1) ?? "")".capitalizingFirstLetter()
            let placeholderImage: UIImage = Alert.imageWith(name: nameLetter, fontSize: 50)!
            
            
            cell?.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell?.userImageView.sd_setImage(with: URL(string: "\(inviterData?.profilePic ?? "")"), placeholderImage: placeholderImage)
            
            if inviterData?.isJoin == true || inviterData?._id == self.raceData?.creater?._id {
                
                cell?.cellBackgroundView.backgroundColor = AppColors.cellBgColor
                cell?.disableView.isHidden = true
                cell?.disableBadgeImageView.isHidden = true
                
            } else {
                
                cell?.cellBackgroundView.backgroundColor = .clear
                cell?.disableView.isHidden = false
                cell?.disableBadgeImageView.isHidden = false
            }
            
            cell?.backgroundColor = .clear
            
            return cell ?? UITableViewCell()
            
        default:
            
            return UITableViewCell()
            
        }
        
        
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        
        print("Button Index: ---->", index)
        
        if direction == .leftToRight {
            
            guard let indexPath = self.racersDetailsTableView.indexPath(for: cell) else {return true}
            
            print("Converted Delete Tapped.... at index: \(indexPath.item)")
            let inviterData = self.raceData?.inviter?[indexPath.item]
            
            if inviterData?.isJoin == false {
                
                if index == 1 {
                    
                    addCoCreatorInRace(userId: inviterData?._id)
                    
                } else if index == 0 {
                    
                    sendRequestForRace(userId: inviterData?._id ?? "")
                    
                }
                
            } else {
                
                if index == 0 {
                    
                    addCoCreatorInRace(userId: inviterData?._id)
                    
                }
                
            }
            
        }
        
        if direction == .rightToLeft {
            
            guard let indexPath = self.racersDetailsTableView.indexPath(for: cell) else { return true }
            
            print("Converted Delete Tapped.... at index: \(indexPath.item)")
            
            removeRacerFromRace(userId: self.raceData?.inviter?[indexPath.item]?._id)
            
        }
        
        return true
    }
    
    @objc func addCoCreatorInRace(userId: String?) {
        
        if  Alert.netwokStatus() {
            
            DispatchQueue.main.async { [weak self] in
                
                Alert.hudShow(self?.view ?? UIView())
            }
            
            raceDetailViewModel.addRaceCoCreator(raceId: self.raceId, userId: userId) { [weak self] error, apiResponse in
                
                DispatchQueue.main.async { [weak self] in
                    
                    Alert.hudHide(self?.view ?? UIView())
                }
                
                if error != nil || apiResponse?.success == false {
                    
                    if apiResponse?.statusCode == 401 {
                        
                        Alert.logoutSession()
                        
                        return
                    }
                    
                    self?.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: error?.localizedDescription ?? apiResponse?.message)
                    return
                    
                } else {
                    
                    self?.presentAlertWithAction(withTitle: NSLocalizedString("appName", comment: ""), message: apiResponse?.message, action: { action in
                        
                        self?.getData()
                        
                    })
                    
                    return
                    
                }
                
            }
            
        } else {
            
            self.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: NSLocalizedString("networkIssue", comment: ""))
            
            return
        }
        
    }
    
    private func sendRequestForRace(userId: String) {
        
        var inviteDetails = [String]()
        
        inviteDetails.append(userId)
        
        let inputFriends = InputInviteRace(raceId: self.raceId, inviter: inviteDetails)
        
        if  Alert.netwokStatus() {
            
            DispatchQueue.main.async { [weak self] in
                
                Alert.hudShow(self?.view ?? UIView())
            }
            
            FriendsAndTeamViewModel().sendUserInvitationForRace(inputInviteRace: inputFriends) { [weak self] (error, apiResponse) in
                
                DispatchQueue.main.async { [weak self] in
                    
                    Alert.hudHide(self?.view ?? UIView())
                }
                
                if error != nil || apiResponse?.success == false {
                    
                    if apiResponse?.statusCode == 401 {
                        
                        Alert.logoutSession()
                        
                        return
                    }
                    
                    self?.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: error?.localizedDescription ?? apiResponse?.message)
                    
                    return
                    
                } else {
                    
                    self?.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: apiResponse?.message)
                    
                    return
                    
                }
                
            }
            
        } else {
            
            
            self.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: NSLocalizedString("networkIssue", comment: ""))
            
            return
            
        }
        
    }
    
    
    @objc func removeRacerFromRace(userId: String?) {
        
        if  Alert.netwokStatus() {
            
            DispatchQueue.main.async { [weak self] in
                
                Alert.hudShow(self?.view ?? UIView())
            }
            
            raceDetailViewModel.removeRacer(raceId: self.raceId, userId: userId) { [weak self] error, apiResponse in
                
                DispatchQueue.main.async { [weak self] in
                    
                    Alert.hudHide(self?.view ?? UIView())
                }
                
                
                if error != nil || apiResponse?.success == false {
                    
                    
                    
                    if apiResponse?.statusCode == 401 {
                        
                        Alert.logoutSession()
                        
                        return
                    }
                    
                    self?.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: error?.localizedDescription ?? apiResponse?.message)
                    
                    return
                    
                } else {
                    
                    self?.presentAlertWithAction(withTitle: NSLocalizedString("appName", comment: ""), message: apiResponse?.message, action: { actio  in
                        
                        self?.getData()
                        
                    })
                    
                    return
                    
                }
                
            }
            
        } else {
            
            self.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: NSLocalizedString("networkIssue", comment: ""))
            
            return
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch tableView {
            
        case raceDifficultyTableView:
            
            return 50
            
        case racersDetailsTableView:
            
            return 80
            
        default:
            
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    
    func handleLeftMenuButtonTapped() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.locManager.stopUpdatingLocation()
            self?.timer?.invalidate()
            self?.timer = nil
            self?.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
}


extension RaceDescriptionViewController: CLLocationManagerDelegate {
    
    
    func setupLocationServices() {
        
        locManager.delegate = self
        locManager.activityType = .fitness
        locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locManager.requestAlwaysAuthorization()
        locManager.allowsBackgroundLocationUpdates = true
        locManager.pausesLocationUpdatesAutomatically = false
        locManager.startMonitoringSignificantLocationChanges()
        locManager.startUpdatingLocation()
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        self.userCurrentLocation = location
        
        manager.stopUpdatingLocation()
        
        self.locManager.stopUpdatingLocation()
        getCityName(location: location!)
        
        if self.isWeatherDataAvailable == false && isWeatherDataRequired == true {
            
            getWeatherData(dateDifference: self.futureRaceDateDifference)
            
        }
        
        if location?.altitude == 0 {
            
            manager.startUpdatingLocation()
            
            self.locManager.startUpdatingLocation()
            
        } else {
            
            manager.stopUpdatingLocation()
            self.locManager.stopUpdatingLocation()
            
            if let altitude = location?.altitude {
                
                let convertMeterToFeet = 3.281
                let currentAltitude =  altitude * convertMeterToFeet
                
                if UserSelectMeasuermentOption().getUserSelectMeasuermentOption() == .imperial {
                    
                    self.raceDetailsArray[2] = "\(currentAltitude.rounded(digits: 2)) feet"
                    
                } else {
                    
                    self.raceDetailsArray[2] = "\(altitude.rounded(digits: 2)) meters"
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.raceDifficultyTableView.reloadRows(at: [IndexPath(item: 2, section: 0)], with: .none)
                    
                }
                
                
            }
            
            return
            
        }
        
        return
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        self.isWeatherDataAvailable = false
        
        manager.stopUpdatingLocation()
        
        self.locManager.stopUpdatingLocation()
        
        self.presentAlert(withTitle: "Error", message: "Location not found: \(error.localizedDescription)")
        
        
    }
    
    
    private func getWeatherData(dateDifference: Int) {
        
        if isWeatherDataRequired == false {
            
            return
        }
        
        guard let currentLocaton = self.userCurrentLocation else {
            
            self.isWeatherDataAvailable = false
            
            self.locManager.startUpdatingLocation()
            
            return
        }
        
        
        if  Alert.netwokStatus() {
            
            liveRaceViewModel.getWeatherData(lat: "\(currentLocaton.coordinate.latitude)", long: "\(currentLocaton.coordinate.longitude)") { [weak self] (error, apiResponse, elevation) in
                
                print("dateDifference-------", dateDifference)
                
                if UserSelectMeasuermentOption().getUserSelectMeasuermentOption() == .imperial {
                    
                    self?.raceDetailsArray[0] = "\(apiResponse?.current?.tempF ?? 0)°F"
                    self?.raceDetailsArray[1] = "\(apiResponse?.current?.humidity ?? 0)%"
                    self?.raceDetailsArray[3] = "\(apiResponse?.current?.windMph ?? 0) mph"
                    
                } else {
                    
                    self?.raceDetailsArray[0] = "\(apiResponse?.current?.tempC ?? 0)°C"
                    self?.raceDetailsArray[1] = "\(apiResponse?.current?.humidity ?? 0)%"
                    self?.raceDetailsArray[3] = "\(apiResponse?.current?.windKph ?? 0) kph"
                    
                }
                
                
                DispatchQueue.main.async { [weak self] in
                    
                    self?.raceDifficultyTableView.reloadData()
                    self?.isWeatherDataAvailable = true
                    
                }
                
                
                return
            }
            
        } else {
            
            self.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: NSLocalizedString("networkIssue", comment: ""))
        }
        
        
        
    }
    
    
    private func getCityName(location: CLLocation) {
        
        CityNameExtractor.cityNameFromLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude ) { [weak self] (cityName) in
            
            DispatchQueue.main.async { [weak self] in
                
                if cityName != nil {
                    
                    self?.cityNameLabel.text = cityName
                    
                }
                
            }
            
        }
        
        
    }
    
    
}

extension RaceDescriptionViewController: EKEventEditViewDelegate {
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        
        controller.dismiss(animated: true)
        
        switch action {
            
        case .canceled:
            break
            
        case .saved:
            
            addRaceEventToCalender()
            
        case .deleted:
            break
            
        case .cancelled:
            break
            
        @unknown default:
            
            break
        }
        
        
    }
    
    
    fileprivate func addRaceEventToCalender() {
        
        DispatchQueue.main.async { [weak self] in
            
            Alert.hudShow(self?.view ?? UIView())
        }
        
        raceDetailViewModel.addRaceToCalender(raceId: self.raceId) { [weak self] error, apiResponse in
            
            if error != nil || apiResponse?.success == false {
                
                DispatchQueue.main.async { [weak self] in
                    
                    Alert.hudHide(self?.view ?? UIView())
                }
                
                if apiResponse?.statusCode == 401 {
                    
                    Alert.logoutSession()
                    
                    return
                }
                
                self?.presentAlert(withTitle: NSLocalizedString("appName", comment: ""), message: error?.localizedDescription ?? apiResponse?.message)
                
                return
                
            } else {
                
                
                self?.presentAlertWithAction(withTitle: NSLocalizedString("appName", comment: ""), message: apiResponse?.message, action: { [weak self] (action) in
                    
                    self?.getData()
                    
                })
                
                return
                
            }
            
        }
        
        
    }
    
}
