# on-off-switch
A Configurable On/Off Switch Plasmoid

This is a widely configurable On/Off switch plasmoid for KDE fully written in QML.

This plasmoid makes use of QT's ToggleButton widget in order to implement the functionality.

The plasmoid can by widely configured via the Settings menu:
 - Name: The name of the switch displayed on the ToggleButton
 - Initial state: State of the ToggleButton after initialization. This will execute the corresponding script.
 - On-Script: Command to be executed when toggling to on
 - On-Script enabled: Switch to enable of disable the execution of the On-Script
 - Off-Script: Command to be executed when toggling to off
 - Off-Script enabled: Switch to enable of disable the execution of the Off-Script
