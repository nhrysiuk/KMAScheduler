//
//  ViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 10.01.2024.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate {
    
    var lessons = [Lesson]()
    
    var filteredSpecialties = [Lesson]()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    
        fetchLessonsIfNeeded()
        fetchLessons(for: Date())
        tableView.reloadData()
    }
    
    func setupUI() {
        tableView.contentInset = UIEdgeInsets.zero
        tableView.scrollIndicatorInsets = UIEdgeInsets.zero
        tableView.backgroundColor = .backgroundBlue
        
        tableView.register(SubjectTableViewCell.self, forCellReuseIdentifier: "Subject")
        
        datePicker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
        
        view.backgroundColor = UIColor.backgroundBlue
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem?.tintColor = .darkBlue
        
        view.addSubview(datePicker)
        view.addSubview(tableView)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        filteredSpecialties = lessons
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setWeek(for: Date())
    }
    
    func fetchLessonsIfNeeded() {
        let data = CoreDataProcessor.shared.fetch(Lesson.self)
        guard data.isEmpty else { return }
        FileReader.fetchLessonsFromFile()
    }
    
    func fetchLessons(for date: Date) {
        let fetchedLessons = CoreDataProcessor.shared.fetch(Lesson.self)
        
        guard !fetchedLessons.isEmpty else { return }

        let subjects = CoreDataProcessor.shared.fetch(Subject.self)
        let filteredSubjects = subjects.filter { $0.isRegistered }
        let ids = filteredSubjects.map { $0.id }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let calendar = Calendar.current
        let date1 = calendar.dateComponents([.day, .month, .year], from: date)
        
        let filteredLessons = fetchedLessons.filter { lesson in
            guard let dateString = dateFormatter.date(from: lesson.lessonDate!) else { return false }
            let date2 = calendar.dateComponents([.day, .month, .year], from: dateString)
            
            let subject = filteredSubjects.first { $0.id == lesson.id }
            let group = subject?.group

            if ids.contains(lesson.id) && date2 == date1 && lesson.group == group {
                print(lesson.id)
                return true
            } else {
                return false
            }
        }
        
        lessons = filteredLessons
        tableView.reloadData()
        
        print(lessons)
    }
    
    #warning("")
    func setWeek(for date: Date) {
        guard let weekNumber = Calendar.current.dateComponents([.weekOfYear], from: date).weekOfYear else { return }
        
        let currWeek = weekNumber - 3
        self.navigationItem.title = "Тиждень \(currWeek)"
    }
}

// MARK: - Table view data source

extension ScheduleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
#warning("дура зроби людське депенденсі інджекшн")
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Subject", for: indexPath) as! SubjectTableViewCell
        
        if let name = lessons[indexPath.row].name, let time = lessons[indexPath.row].lessonTime {
            print(name)
            cell.nameLabel.text = String(name)
            cell.timeLabel.text = String(time)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.present(LessonViewController(), animated: true)
    }
    
    @objc func dateValueChanged() {
        let date = self.datePicker.date
        print(self.datePicker.date)
        setWeek(for: date)
        fetchLessons(for: date)
        
        dismiss(animated: true, completion: nil)
    }
}
