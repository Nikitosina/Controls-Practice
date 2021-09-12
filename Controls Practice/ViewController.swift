//
//  ViewController.swift
//  Controls Practice
//
//  Created by Никита Раташнюк on 10.09.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    
    var number = 128 {
        didSet {
            number = (number + 256) % 256
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        for s in switches {
            s.layer.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
        }
    }
    
    func updateNumberFromSwitches() {
        var number = 0
        for s in switches {
            number += s.isOn ? s.tag : 0
        }
        self.number = number
    }
    
    func updateSwitches() {
        for s in switches {
            s.isOn = Int(number) & s.tag != 0
        }
    }
    
    /// updates all outlets to number
    func updateUI() {
        button.setTitle(String(number), for: [])

        slider.value = Float(number)
        textField.text = String(number)
        updateSwitches()
    }

    @IBAction func buttonTapped() {
        number = (Int(number) + 1) % 256
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        updateNumberFromSwitches()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        number = Int(slider.value)
    }
    
    @IBAction func textFieldChanged() {
        number = Int(textField.text ?? "") ?? 0
    }
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if location.x < view.bounds.midX {
            number -= 1
        } else {
            number += 1
        }
    }
}

