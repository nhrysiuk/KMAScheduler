//
//  ViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 10.01.2024.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Properties
    private var lessons = [Lesson]()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundBlue
        
        return tableView
    }()
    
    private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .darkBlue
        
        return datePicker
    }()
    // MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setLayout()
    
        FileReader.fetchLessonsFromFile()
        lessons = CoreDataProcessor.shared.fetchLessons(for: Date())
        tableView.reloadData()
    }
    
    // MARK: - Set up
    private func setupUI() {
        view.backgroundColor = UIColor.backgroundBlue
        
        tableView.register(SubjectTableViewCell.self, forCellReuseIdentifier: "SubjectCell")
        
        datePicker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
        
        setWeek(for: Date())
    }
    
    private func setLayout() {
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
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setWeek(for date: Date) {
        guard let weekNumber = Calendar.current.dateComponents([.weekOfYear], from: date).weekOfYear else { return }
        
        let currWeek = weekNumber - 3
        self.navigationItem.title = "Тиждень \(currWeek)"
    }
    
    // MARK: - Date changed handling
    @objc func dateValueChanged() {
        let date = self.datePicker.date
        print(self.datePicker.date)
        setWeek(for: date)
        lessons = CoreDataProcessor.shared.fetchLessons(for: date)
        tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Table view data source
extension ScheduleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath) as! SubjectTableViewCell
        
        cell.configure(with: lessons[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = LessonViewController(lesson: lessons[indexPath.row])
        navigationController?.present(vc, animated: true)
    }
}
