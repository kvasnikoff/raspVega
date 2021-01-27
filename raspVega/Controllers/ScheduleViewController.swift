//
//  ScheduleViewController.swift
//  raspVega
//
//  Created by Peter Kvasnikov on 23.11.2020.
//

import UIKit
import FSCalendar


class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        return tableView
    }()
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    fileprivate weak var calendar: FSCalendar!
    private let cellId = "cellId"
    
    var decodedData: ScheduleData?
    
    var isSelectedGroup = false
    var selectedGroupIndex = 0
    var transmittedArray = [String]()
    
    var globalData = [[String]]()
    var currentData = [String]()
    let defaults = UserDefaults.standard
    
    let myFirstButton = UIBarButtonItem()
    
    
    var firstMon = Date()
    var firstTue = Date()
    var firstWed = Date()
    var firstThu = Date()
    var firstFri = Date()
    var firstSat = Date()
    var firstSun = Date()
    
    var calendarHeightConstraint: NSLayoutConstraint!
   
   
   
   

    
    var week = 0
    var day = ""
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(transmittedArray: [String]) {
        self.init()
        self.transmittedArray = transmittedArray
        self.isSelectedGroup = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupData()
        setupCalendar()
        setupTableView()
        firstCatch()
        setupButton()
        
        
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calendar.scope = .week
        self.calendar.select(Date())
        self.tableView.reloadData()

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.calendar.select(Date())
            self.firstCatch()
            self.tableView.reloadData()
        }
    }
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    func stringToDate(stringWithDate: String) -> Date{
      let stringFormatter = DateFormatter()
      stringFormatter.dateFormat = "dd.MM.yyyy"
        
        
      var date_vega = stringFormatter.date(from: stringWithDate)!
        date_vega = Calendar.current.date(bySettingHour: 12, minute: 00, second: 0, of: date_vega)! //тк в противном случае print использует UTC и печатает на день раньше

        return (date_vega)
        
    }
    
    func weekNum(date: Date) -> Int{
    var calendar = Calendar(identifier: .gregorian)
    calendar.firstWeekday = 2 //задаем понедельник первым днем недели
    let week = calendar.component(.weekOfYear, from: date)
    return week
    }
    
    func weekDay(date: Date) -> Int{
        
        var calendar = Calendar(identifier: .gregorian)
        
        calendar.firstWeekday = 2 //задаем понедельник первым днем недели
        
        let weekday = calendar.date(bySettingHour: 12, minute: 00, second: 0, of: date)!
        
        let day = calendar.component(.weekday, from: weekday)
    
        return day - 1
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
   //     print("did select date \(self.dateFormatter.string(from: date))")
   //     let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
   //     print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func setupData(){
        
        if let localData = self.readLocalFile(forName: "data") {
            self.parse(jsonData: localData)

        }
        
        firstMon = stringToDate(stringWithDate: decodedData!.settings.firstWeekDate)
        firstTue = Calendar.current.date(byAdding: .day, value: 1, to: firstMon)!
        firstWed = Calendar.current.date(byAdding: .day, value: 2, to: firstMon)!
        firstThu = Calendar.current.date(byAdding: .day, value: 3, to: firstMon)!
        firstFri = Calendar.current.date(byAdding: .day, value: 4, to: firstMon)!
        firstSat = Calendar.current.date(byAdding: .day, value: 5, to: firstMon)!
        firstSun = Calendar.current.date(byAdding: .day, value: 6, to: firstMon)!
        
    }
    
    func setupCalendar(){
        
        let calendar = FSCalendar()
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendar)
        self.calendar = calendar
        self.calendar.locale = Locale(identifier: "ru")
        calendar.firstWeekday = 2

        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            calendar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

        
            
        ])
        calendarHeightConstraint = self.calendar.heightAnchor.constraint(equalToConstant: 300)
        calendarHeightConstraint.isActive = true
    
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        

        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 80
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: calendar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: calendar.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: calendar.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                                        
        ])
        

    }
    
    func setupButton() {
        
        let myFirstButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.left.and.arrow.down.right"), style: .plain, target: self, action: #selector(buttonClicked))
        
//        myFirstButton.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right"), for: .normal)
//        myFirstButton.setTitleColor(UIColor.blue, for: .normal)
//        myFirstButton.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)

        
//        myFirstButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//        myFirstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -37),
//        myFirstButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
//        myFirstButton.widthAnchor.constraint(equalToConstant: 20),
//        myFirstButton.heightAnchor.constraint(equalToConstant: 20),
//
//        ])
        

        
        self.navigationItem.rightBarButtonItem = myFirstButton
    }
    
    @objc func buttonClicked(sender : UIButton) {
        let controller = FullScheduleViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if globalData.count == 0{
            return 1
            
        } else{
            return globalData.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if globalData.count == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ScheduleTableViewCell
            cell.textLabel!.text = "Пар не найдено"
            cell.nameLabel.text = ""
            cell.numberOfPairLabel.text = ""
            cell.classroomLabel.text = ""
            cell.typeOfPairLabel.text = ""
            cell.beginningTimeLabel.text = ""
            cell.endingTimeLabel.text = ""
            
            cell.accessoryType = UITableViewCell.AccessoryType.none
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ScheduleTableViewCell
            cell.nameLabel.text = globalData[indexPath.row][0]
            cell.numberOfPairLabel.text = globalData[indexPath.row][1]
            cell.classroomLabel.text = globalData[indexPath.row][2]
            cell.typeOfPairLabel.text = globalData[indexPath.row][3]
            cell.textLabel!.text = ""
            
            if globalData[indexPath.row][1] == "1" {
                cell.beginningTimeLabel.text = "09:00"
                cell.endingTimeLabel.text = "10:30"
            }
            
            if globalData[indexPath.row][1] == "2" {
                cell.beginningTimeLabel.text = "10:40"
                cell.endingTimeLabel.text = "12:10"
            }
            
            if globalData[indexPath.row][1] == "3" {
                cell.beginningTimeLabel.text = "14:40"
                cell.endingTimeLabel.text = "14:10"
            }
            
            if globalData[indexPath.row][1] == "4" {
                cell.beginningTimeLabel.text = "14:50"
                cell.endingTimeLabel.text = "16:20"
            }
            
            if globalData[indexPath.row][1] == "5" {
                cell.beginningTimeLabel.text = "16:30"
                cell.endingTimeLabel.text = "18:00"
            }
            
            if globalData[indexPath.row][1] == "6" {
                cell.beginningTimeLabel.text = "18:10"
                cell.endingTimeLabel.text = "19:40"
            }
            
            cell.accessoryType = UITableViewCell.AccessoryType.none
            
            return cell
            
        }
        
        

    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    
    func parse(jsonData: Data) {
        do {
            decodedData = try JSONDecoder().decode(ScheduleData.self,
                                                       from: jsonData)
            

        } catch {
            print("decode error")
        }
    }
    
    func initDataBase() {
        
        if isSelectedGroup == false{
            let selectedGroup = defaults.object(forKey: "selectedGroup") as? [String]
            let selectedGroupIndexString = Int(((selectedGroup?[0])!))
            selectedGroupIndex = selectedGroupIndexString!
            
        } else {
            selectedGroupIndex = Int(transmittedArray[1])!
        }
        
        
        
        
    }
    
    func firstCatch() {
        initDataBase()
        

        currentData = []
        globalData = []
        let date = Date()

        
      
        if weekDay(date: date) == 1{
            week = weekNum(date: date) - weekNum(date: firstMon) + 1
          //  print(week)
            day = "ПН"
        } else if weekDay(date: date) == 2 {
            week = weekNum(date: date) - weekNum(date: firstTue) + 1
         //   print(week)
            day = "ВТ"
        } else if weekDay(date: date) == 3 {
            week = weekNum(date: date) - weekNum(date: firstWed) + 1
        //    print(week)
            day = "СР"
        } else if weekDay(date: date) == 4 {
            week = weekNum(date: date) - weekNum(date: firstThu) + 1
        //    print(week)
            day = "ЧТ"
        } else if weekDay(date: date) == 5 {
            week = weekNum(date: date) - weekNum(date: firstFri) + 1
        //    print(week)
            day = "ПТ"
        } else if weekDay(date: date) == 6 {
            week = weekNum(date: date) - weekNum(date: firstSat) + 1
        //    print(week)
            day = "СБ"
        } else if weekDay(date: date) == 7 {
            week = weekNum(date: date) - weekNum(date: firstSun) + 1
        //    print(week)
            day = "ВС"
        }
        
     //   print(decodedData!.groups[0].days[0].day)

        for i in decodedData!.groups[selectedGroupIndex].days{
            if (i.day.rawValue) == day{
                
                
                for par in i.pars {
                    if par.even != nil {
                    
                    
                    if week % 2 == par.even  {
                    
                    
                    currentData.append(par.name)
                    currentData.append(String(par.number))
                    currentData.append(par.place ?? "")
                    currentData.append(par.type?.rawValue ?? "")
                    globalData.append(currentData)
                  currentData = []

                    
                    }
                    
                    
                    } else {
                        
                        currentData.append(par.name)
                        currentData.append(String(par.number))
                        currentData.append(par.place ?? "")
                        currentData.append(par.type?.rawValue ?? "")
                        globalData.append(currentData)
                      currentData = []
                        
                    }
                }
                
                
                
                
            }
        }
        
        if day == "ВС" {
            currentData = []
            globalData = []
            
        }
        print(day)
        
        tableView.reloadData()

    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {

        initDataBase()
        currentData = []
        globalData = []

        
      
        if weekDay(date: date) == 1{
            week = weekNum(date: date) - weekNum(date: firstMon) + 1
          //  print(week)
            day = "ПН"
        } else if weekDay(date: date) == 2 {
            week = weekNum(date: date) - weekNum(date: firstTue) + 1
         //   print(week)
            day = "ВТ"
        } else if weekDay(date: date) == 3 {
            week = weekNum(date: date) - weekNum(date: firstWed) + 1
        //    print(week)
            day = "СР"
        } else if weekDay(date: date) == 4 {
            week = weekNum(date: date) - weekNum(date: firstThu) + 1
        //    print(week)
            day = "ЧТ"
        } else if weekDay(date: date) == 5 {
            week = weekNum(date: date) - weekNum(date: firstFri) + 1
        //    print(week)
            day = "ПТ"
        } else if weekDay(date: date) == 6 {
            week = weekNum(date: date) - weekNum(date: firstSat) + 1
        //    print(week)
            day = "СБ"
        } else if weekDay(date: date) == 0 {
            week = weekNum(date: date) - weekNum(date: firstSun) + 1
        //    print(week)
            day = "ВС"
        }
        
     //   print(decodedData!.groups[0].days[0].day)

        for i in decodedData!.groups[selectedGroupIndex].days{
            if (i.day.rawValue) == day{
                
                
                for par in i.pars {
                    if par.even != nil {
                    
                    
                    if week % 2 == par.even  {
                    
                    
                    currentData.append(par.name)
                    currentData.append(String(par.number))
                    currentData.append(par.place ?? "")
                    currentData.append(par.type?.rawValue ?? "")
                    globalData.append(currentData)
                  currentData = []

                    
                    }
                    
                    
                    } else {
                        
                        currentData.append(par.name)
                        currentData.append(String(par.number))
                        currentData.append(par.place ?? "")
                        currentData.append(par.type?.rawValue ?? "")
                        globalData.append(currentData)
                      currentData = []
                        
                    }
                }
                
                
                
                
            }
        }
        
        if day == "ВС" {
            currentData = []
            globalData = []
            
        }
        print(day)
        

        
        tableView.reloadData()


        
        return monthPosition == .current
    }


}
    




