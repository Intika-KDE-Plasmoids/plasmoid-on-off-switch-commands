# on-off-switch
## A Configurable On/Off Switch Plasmoid

This is a widely configurable On/Off switch plasmoid for KDE fully
written in QML. It makes use of QT's ToggleButton widget in order to
implement the functionality.

## Installation

Install this plasmoid using `kpackagetool5 -t Plasma/Applet -i .` in the
top-directory

## Configuration
The plasmoid can by widely configured via the Settings menu:
 - name: The name of the switch displayed on the ToggleButton
 - initialState: State entered upon startup. Will call corresponding script
 - onScript: Called upon toggling off -> on if onScriptState is true
 - onScriptState: Switch to enable or disable the execution of onScript
 - offScript: Called upon toggling on -> off if offScriptState is true
 - offScriptState: Switch to enable or disable the execution of offScript

## Further ideas

Enable the switch to have a persistent state. Currently it's unclear
how the currentState might be stored persistently. The naive approach
to abuse the configuration mechanism does unfortunately **not** work

For this, another configuration parameter is required:
 - persistentState -- boolean; make switch persistent during restart

Basically two types of switches, the latter is implemented:

  * persistentState == true: Switch state will be persistent over
    restarts of the plasmoid. For this, onScript or offScript will be
    called during instantiation depending on currentState.

  * persistentState == false: Switch state will be volatile. Switch
    will go into initialState upon startup. For this, onScript or
    offScript will be called while it's instantiated.
