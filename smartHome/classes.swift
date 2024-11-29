//
//  classes.swift
//  smartHome
//
//  Created by Agnihotri, Aaryan (Coll) on 26/11/2024.
//

import Foundation

class Home {
    var devices: [Device]
    let owner: String
    
    init(owner: String) {
        self.owner = owner
        self.devices = []
    }
    
    func statusCheck() {
        print("Device \t Room \t Status \t Battery")
        var i = 1
        for device in self.devices {
            print("[\(i)]", terminator: " ")
            print(device.displayStatus())
            i += 1
        }
    }
    
    func turnDeviceOnOrOff() {
        print("Choose a device to switch on or off (choose the number)")
        self.statusCheck()
        var userChoice: Int = -1
        
        while userChoice < 1 || userChoice > self.devices.count {
            userChoice = Int(readLine()!)!
        }
        
        let device = self.devices[userChoice-1]
        
        if device.battery == 0 {
            print("Cannot turn device \(device.name) on; battery is dead")
        }
        else {
            device.isOn = !device.isOn
            print("Device \(device.name) is now \(device.isOn ? "on" : "off")")
        }
    }
}


class Device {
    var battery: Int
    let name: String
    var isOn: Bool
    let room: String
    
    init(name: String, room: String) {
        self.battery = 100
        self.name = name
        self.isOn = false
        self.room = room
    }
    
    func toggleOnOrOff() {
        self.isOn = !self.isOn
    }
    
    func displayStatus() -> String {
        if self.isOn {
            self.battery = max(0, self.battery - 5)
            if self.battery == 0 { self.isOn = false }
        }
        return "\(self.name) \t \(self.room) \t \(self.isOn ? "On" : "Off") \t \(self.battery)%"
    }
}

class LightingDevice: Device {
    var brightness: Int
    
    init(name: String, room: String, brightness: Int) {
        self.brightness = brightness
        super.init(name: name, room: room)
    }
    
    override func displayStatus() -> String {
        return "Lightning D" + super.displayStatus() + "Brightness: \(self.brightness)"
    }
}

class AudioDevice: Device {
    
}

class HeatingDevice: Device {
    
}

