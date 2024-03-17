//
//  ViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 10.01.2024.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate {
    
    var specialties = ["08:30 - Swift", "10:00 - Теорія права"]
    
    var filteredSpecialties: [String] = []
    
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
            tableView.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        filteredSpecialties = specialties
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setWeek()
    }
    
    func setWeek() {
        guard let weekNumber = Calendar.current.dateComponents([.weekOfYear], from: Date()).weekOfYear else {
            return
        }
        
        let currWeek = weekNumber - 3
        self.navigationItem.title = "Тиждень \(currWeek)"
    }
}

// MARK: - Table view data source

extension ScheduleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSpecialties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Subject", for: indexPath) as! SubjectTableViewCell
        
        cell.label.text = specialties[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        present(LessonViewController(), animated: true)
    }
    
    @objc func dateValueChanged() {
        print(self.datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}

extension ScheduleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredSpecialties = self.specialties
            self.tableView.reloadData()
            return
        }
        
        self.filteredSpecialties = self.specialties.filter {$0.contains(searchText)}
        self.tableView.reloadData()
    }
}
