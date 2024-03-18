//
//  LessonViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 13.01.2024.
//

import UIKit

class LessonViewController: UIViewController {

    private var lesson: LessonModel?
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkBlue
        label.font = UIFont(name: "ProbaPro-Bold", size: 27)
        label.textAlignment = .center
        
        return label
    }()
    
    private var notesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkBlue
        label.font = UIFont(name: "ProbaPro-Medium", size: 23)
        label.text = "Нотатки"
        
        return label
    }()
    
    private var notesTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.grayBLue
        textView.font = UIFont(name: "ProbaPro-Medium", size: 23)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.backgroundColor = UIColor.lightBlue
        textView.frame.size.height = 300
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setLayout()
    }
    
    func setupUI() {
        view.backgroundColor = .backgroundBlue
        nameLabel.text = lesson?.name ?? "Предмет"
        notesTextView.text = lesson?.notes
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        print(navigationController)
        navigationController?.navigationItem.rightBarButtonItem = button
    }
    
    func setLayout() {
        view.addSubview(nameLabel)
        view.addSubview(notesLabel)
        view.addSubview(notesTextView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: notesLabel.topAnchor, constant: -40),
            notesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            notesTextView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 10),
            notesTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            notesTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            notesTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with lesson: LessonModel) {
        self.lesson = lesson
    }
    
    @objc func doneButtonTapped() {
        
    }
}
