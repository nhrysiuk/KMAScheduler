//
//  LessonViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 13.01.2024.
//

import UIKit

class LessonViewController: UIViewController {

    // MARK: - Properties
    private var lesson: Lesson
    
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
    
    private var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зберегти", for: .normal)
        button.setTitleColor(UIColor.cobalt, for: .normal)
        button.titleLabel?.font = UIFont(name: "ProbaPro-Medium", size: 20)
        
        return button
    }()
    
    private var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Скасувати", for: .normal)
        button.setTitleColor(UIColor.cobalt, for: .normal)
        button.titleLabel?.font = UIFont(name: "ProbaPro-Medium", size: 20)
        
        return button
    }()
    
    // MARK: - View controller lifecycle
    init(lesson: Lesson) {
        self.lesson = lesson
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setLayout()
    }
    
    // MARK: - Set up
    private func setupUI() {
        view.backgroundColor = .backgroundBlue
        nameLabel.text = lesson.lessonTime
        notesTextView.text = lesson.notes
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        view.addSubview(nameLabel)
        view.addSubview(notesLabel)
        view.addSubview(notesTextView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesTextView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            notesTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
    }
    
    // MARK: - Buttons actions handling
    @objc private func saveButtonTapped() {
        let notes = notesTextView.text
        lesson.notes = notes
        CoreDataProcessor.shared.saveContext()
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
