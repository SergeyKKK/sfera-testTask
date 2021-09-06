//
//  TimerController.swift
//  sferaTZ
//
//  Created by Serega Kushnarev on 28.09.2021.
//

import UIKit

// MARK: - TimerController

final class TimerController: UIViewController {
    
    // MARK: - Private properties
    
    private let addTimerLabel = UILabel()
    private let greyColourView = UIView()
    private let nameOfTimerTextField = UITextField()
    private let timeFortimerTextField = UITextField()
    private let addTimerButton = UIButton()
    private let timersLabel = UILabel()
    private let greyColourTwoView = UIView()
    private let timerTableView = UITableView()
    private var timersArray: [Timers] = []
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
    }
    
    // MARK: - Override methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        
        view.backgroundColor = .white
        navigationItem.title = NSLocalizedString("Мульти таймер", comment: "")

        setUpAddTimerLabel()
        setUpGreyColorView()
        setUpTimeFortimerTextField()
        setUpNameOfTimerTextField()
        setUpAddTimerButton()
        setUpTimersrLabel()
        setUpGreyColorTwoView()
        setUpTimerTableView()
    
        createAddTimerLabel()
        createGreyColourView()
        createTimeFortimerTextField()
        createNameOfTimerTextField()
        createAddTimerButton()
        createTimersLabel()
        createGreyColourTwoView()
        createTimerTableView()
    }
    
    private func setUpAddTimerLabel() {
        addTimerLabel.textColor = .gray
        addTimerLabel.text = NSLocalizedString("Добавление таймеров", comment: "")
        addTimerLabel.font = addTimerLabel.font.withSize(10)
       
        view.addSubview(addTimerLabel)
    }
    
    private func setUpGreyColorView() {
        greyColourView.backgroundColor = .gray
        greyColourView.alpha = 0.1
       
        view.addSubview(greyColourView)
    }
    
    private func setUpNameOfTimerTextField() {
        nameOfTimerTextField.placeholder = NSLocalizedString(" Название таймера", comment: "")
        nameOfTimerTextField.font = nameOfTimerTextField.font?.withSize(10)
        nameOfTimerTextField.layer.cornerRadius = 5
        nameOfTimerTextField.layer.borderWidth = 0.1
        nameOfTimerTextField.delegate = self
        nameOfTimerTextField.layer.borderColor = UIColor.gray.cgColor
        
        view.addSubview(nameOfTimerTextField)
    }
   
    private func setUpTimeFortimerTextField() {
        timeFortimerTextField.placeholder = NSLocalizedString(" Время в секундах", comment: "")
        timeFortimerTextField.font = timeFortimerTextField.font?.withSize(10)
        timeFortimerTextField.layer.cornerRadius = 5
        timeFortimerTextField.layer.borderWidth = 0.1
        timeFortimerTextField.delegate = self
        timeFortimerTextField.layer.borderColor = UIColor.gray.cgColor
        timeFortimerTextField.keyboardType = .asciiCapableNumberPad
        
        view.addSubview(timeFortimerTextField)
    }
    
    private func setUpAddTimerButton() {
        addTimerButton.setTitle(NSLocalizedString("Добавить", comment: ""), for: .normal)
        addTimerButton.setTitleColor(.systemBlue, for: .normal)
        addTimerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        addTimerButton.backgroundColor = .gray.withAlphaComponent(0.1)
        addTimerButton.layer.cornerRadius = 10
        addTimerButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        view.addSubview(addTimerButton)
    }
    
    private func setUpTimersrLabel() {
        timersLabel.textColor = .gray
        timersLabel.text = NSLocalizedString("Таймеры", comment: "")
        timersLabel.font = timersLabel.font.withSize(10)
        view.addSubview(timersLabel)
    }
    
    private func setUpGreyColorTwoView() {
        greyColourTwoView.backgroundColor = .gray
        greyColourTwoView.alpha = 0.1
        view.addSubview(greyColourTwoView)
    }
    
    private func setUpTimerTableView() {
        
        timerTableView.delegate = self
        timerTableView.dataSource = self
        timerTableView.separatorStyle = .none
        timerTableView.backgroundColor = .gray.withAlphaComponent(0.1)
        timerTableView.register(CellForTableView.self, forCellReuseIdentifier: CellForTableView.cellIdentifier)
        
        view.addSubview(timerTableView)
    }
    private func setUpTimer() {
        
        if nameOfTimerTextField.text == "" && timeFortimerTextField.text == "" {
            showAlert(message: "Заполните данные")
        } else {
            
            let timer = Timers(name: nameOfTimerTextField.text ?? "",
                               seconds: Int(timeFortimerTextField.text ?? "") ?? 0)
            self.timersArray.append(timer)
            self.timersArray.sort(by: {$0.seconds > $1.seconds})
            self.timerTableView.reloadData()
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Actions

    @objc
    private func tapButton() {
        view.endEditing(true)
        setUpTimer()
    }
}

// MARK: - UITextFieldDelegate

extension TimerController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameOfTimerTextField {
            textField.resignFirstResponder()
            timeFortimerTextField.becomeFirstResponder()
        } else if textField == timeFortimerTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == timeFortimerTextField {
            let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let components = string.components(separatedBy: inverseSet)
            let filtered = components.joined(separator: "")
            return string == filtered
        }
        return true
    }
}

// MARK: - UITableViewDelegate

extension TimerController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            timersArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - UITableViewDataSource

extension TimerController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellForTableView.cellIdentifier,
                for: indexPath) as? CellForTableView else { return UITableViewCell() }
        let timers = timersArray[indexPath.row]
        cell.configuration(timers: timers)
        cell.updateTable = {
            self.timersArray = self.timersArray.filter { $0.seconds > 0 }
            self.timerTableView.reloadData()
        }
        return cell
    }
}

// MARK: - Layout

private extension TimerController {
    
    func createAddTimerLabel() {
        addTimerLabel.translatesAutoresizingMaskIntoConstraints = false
        addTimerLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                    constant: 10).isActive = true
        addTimerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        addTimerLabel.bottomAnchor.constraint(equalTo: nameOfTimerTextField.safeAreaLayoutGuide.topAnchor,
                                              constant: -15).isActive = true
        addTimerLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        addTimerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createGreyColourView() {
        greyColourView.translatesAutoresizingMaskIntoConstraints = false
        greyColourView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        greyColourView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        greyColourView.bottomAnchor.constraint(equalTo: nameOfTimerTextField.safeAreaLayoutGuide.topAnchor,
                                               constant: -15).isActive = true
        greyColourView.widthAnchor.constraint(equalToConstant: 450).isActive = true
        greyColourView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func createNameOfTimerTextField() {
        nameOfTimerTextField.translatesAutoresizingMaskIntoConstraints = false
        nameOfTimerTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                    constant: 10).isActive = true
        nameOfTimerTextField.topAnchor.constraint(equalTo: addTimerLabel.safeAreaLayoutGuide.bottomAnchor,
                                          constant: 15).isActive = true
        nameOfTimerTextField.bottomAnchor.constraint(equalTo: timeFortimerTextField.safeAreaLayoutGuide.topAnchor,
                                             constant: -10).isActive = true
        nameOfTimerTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nameOfTimerTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func createTimeFortimerTextField() {
        timeFortimerTextField.translatesAutoresizingMaskIntoConstraints = false
        timeFortimerTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                   constant: 10).isActive = true
        timeFortimerTextField.topAnchor.constraint(equalTo: nameOfTimerTextField.safeAreaLayoutGuide.bottomAnchor,
                                        constant: 10).isActive = true
        timeFortimerTextField.bottomAnchor.constraint(equalTo: addTimerButton.safeAreaLayoutGuide.topAnchor,
                                           constant: -15).isActive = true
        timeFortimerTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        timeFortimerTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func createAddTimerButton() {
        addTimerButton.translatesAutoresizingMaskIntoConstraints = false
        addTimerButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                    constant: 10).isActive = true
        addTimerButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                              constant: -10).isActive = true
        addTimerButton.topAnchor.constraint(equalTo: timeFortimerTextField.safeAreaLayoutGuide.bottomAnchor,
                                         constant: 15).isActive = true
        addTimerButton.bottomAnchor.constraint(equalTo: timersLabel.safeAreaLayoutGuide.topAnchor,
                                            constant: -10).isActive = true
        addTimerButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addTimerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createTimersLabel() {
        timersLabel.translatesAutoresizingMaskIntoConstraints = false
        timersLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                    constant: 10).isActive = true
        timersLabel.topAnchor.constraint(equalTo: addTimerButton.safeAreaLayoutGuide.bottomAnchor,
                                         constant: 10).isActive = true
        timersLabel.bottomAnchor.constraint(equalTo: timerTableView.safeAreaLayoutGuide.topAnchor,
                                              constant: -15).isActive = true
        timersLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        timersLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createGreyColourTwoView() {
        greyColourTwoView.translatesAutoresizingMaskIntoConstraints = false
        greyColourTwoView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        greyColourTwoView.topAnchor.constraint(equalTo: addTimerButton.safeAreaLayoutGuide.bottomAnchor,
                                               constant: 20).isActive = true
        greyColourTwoView.bottomAnchor.constraint(equalTo: timerTableView.safeAreaLayoutGuide.topAnchor,
                                               constant: -15).isActive = true
        greyColourTwoView.widthAnchor.constraint(equalToConstant: 450).isActive = true
        greyColourTwoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createTimerTableView() {
        timerTableView.translatesAutoresizingMaskIntoConstraints = false
        timerTableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        timerTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                    constant: 0).isActive = true
        timerTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                              constant: 0).isActive = true
        timerTableView.topAnchor.constraint(equalTo: timersLabel.safeAreaLayoutGuide.bottomAnchor,
                                               constant: 0).isActive = true
        timerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                            constant: 0).isActive = true
    }
}

