# On-Off-Switch-Plasmoid
## A Configurable On/Off Switch Plasmoid

This is a widely configurable On/Off switch commands plasmoid for KDE fully written in QML. It makes use of QT's ToggleButton widget in order to implement the functionality.

## Feature 
- Click to execute a command/script
- Command/script on toggle off and toggle on 
- Toggle on startup
- Watch the state on startup
- Custom initial state
- Custom initial state to inactive 
- Extended colorization of QT's ToggleButton
- Custom displayed text on enable (on)
- Custom displayed text on disable (off)
- Custom displayed text on inactive state
- Custom tooltip text
- Custom script on and off
- Check the execution state of the script on and off
- Watcher (custom watching command with interval)

## Installation

Install this plasmoid using `kpackagetool5 -t Plasma/Applet -i .` in the top-directory

Or just load the plasmoid file from the package directory into your kde plasma desktop

You may need to install "qtquick-extras" if it's not already installed
"sudo apt install qml-module-qtquick-extras"

## Configuration
The plasmoid can by widely configured via the Settings menu

## Captures

<p align="center">
  
<img src ="https://github.com/Intika-Linux-KDE/Plasmoid-On-Off-Switch-Commands/raw/master/screenshot/Screenshot_20190206_072706.png" />

</br>

<img src ="https://github.com/Intika-Linux-KDE/Plasmoid-On-Off-Switch-Commands/raw/master/screenshot/Screenshot_20190206_072407.png" />

<img src ="https://github.com/Intika-Linux-KDE/Plasmoid-On-Off-Switch-Commands/raw/master/screenshot/Screenshot_20190206_072415.png" />

<img src ="https://github.com/Intika-Linux-KDE/Plasmoid-On-Off-Switch-Commands/raw/master/screenshot/Screenshot_20190206_072428.png" />

</br>

<img src ="https://github.com/Intika-Linux-KDE/Plasmoid-On-Off-Switch-Commands/raw/master/screenshot/Screenshot_20190206_072539.png" />

</br>

<img src ="https://github.com/Intika-Linux-KDE/Plasmoid-On-Off-Switch-Commands/raw/master/screenshot/Screenshot_20190206_073638.png" />

</br>
  
<img src ="https://github.com/Intika-Linux-KDE/Plasmoid-On-Off-Switch-Commands/raw/master/screenshot/Screenshot_20190206_073645.png" />

</br>

<img src ="https://github.com/Intika-Linux-KDE/Plasmoid-On-Off-Switch-Commands/raw/master/screenshot/Screenshot_20190206_073650.png" />

</p>

## Todo 
Apply text change immediately after settings saved
