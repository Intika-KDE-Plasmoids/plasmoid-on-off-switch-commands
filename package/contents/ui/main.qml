/*
 * Copyright (C) 2019 by intika <intika@librefox.org>
 * Copyright (C) 2017-2018 by Norbert Eicker <norbert.eicker@gmx.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation;
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>
 */
import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Extras 1.4
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import QtQuick.Controls.Styles 1.4

ToggleButton {
    
    property bool switchOn
    property string name: Plasmoid.configuration.name
    property string nameOffText: Plasmoid.configuration.nameOffText
    property string nameInactiveText: Plasmoid.configuration.nameInactiveText
    property string hintText: Plasmoid.configuration.hintText
    property bool onScriptResult: Plasmoid.configuration.onScriptResult
    property bool offScriptResult: Plasmoid.configuration.offScriptResult
    property bool onScriptEnabled: Plasmoid.configuration.onScriptState
    property bool fullColor: Plasmoid.configuration.fullColor
    property string onScript: Plasmoid.configuration.onScript
    property bool offScriptEnabled: Plasmoid.configuration.offScriptState
    property string offScript: Plasmoid.configuration.offScript
    
    property bool watchInitialState: Plasmoid.configuration.watchInitialState
    property bool onScriptStateWatcher: Plasmoid.configuration.onScriptStateWatcher
    property string onScriptWatcherCommand: Plasmoid.configuration.onScriptWatcherCommand
    property int watcherRefreshRate: Plasmoid.configuration.watcherRefreshRate
    
    CommonStyleHelper {
        id: commonStyleHelper
    }
    
    property string colorFlex1: commonStyleHelper.inactiveColor
    property string colorFlex2: commonStyleHelper.inactiveColorShine
    property string colorOff1: commonStyleHelper.offColor
    property string colorOff2: commonStyleHelper.offColorShine
    
    style: ToggleButtonStyle {
        inactiveGradient: Gradient {
            GradientStop {
                position: 0
                color: colorFlex1
            }
            GradientStop {
                position: 1
                color: colorFlex2
            }
        }
        checkedGradient: Gradient {
            GradientStop {
                position: 0
                color: commonStyleHelper.onColor
            }
            GradientStop {
                position: 1
                color: commonStyleHelper.onColorShine
            }
        }
        uncheckedGradient: Gradient {
            GradientStop {
                position: 0
                color: colorOff1
            }
            GradientStop {
                position: 1
                color: colorOff2
            }
        }
        checkedDropShadowColor: commonStyleHelper.onColor
        uncheckedDropShadowColor: commonStyleHelper.offColor
    }
    
    text: name
    tooltip: hintText
    
    Timer {
        id:watcherTimer
        interval: watcherRefreshRate*1000
        onTriggered: watcherOnTime()
    }
    
	function watcherOnTime() {
        executableWatcher.exec(onScriptWatcherCommand);
	}

    PlasmaCore.DataSource {
        id: executableWatcher
        engine: "executable"
        connectedSources: []
        
		onNewData: {
                parseWatcherResponse(data["exit code"])
				exited(sourceName, data.stdout)
				disconnectSource(sourceName) // cmd finished
		}

        function exec(cmd) {
            connectSource(cmd)
        }
        
        signal exited(string sourceName, string stdout)
    }
    
    PlasmaCore.DataSource {
        id: executableOn
        engine: "executable"
        connectedSources: []
        
		onNewData: {
                parseOnResponse(data["exit code"])
				exited(sourceName, data.stdout)
				disconnectSource(sourceName) // cmd finished
		}

        function exec(cmd) {
            connectSource(cmd)
        }
        
        signal exited(string sourceName, string stdout)
    }
    
    PlasmaCore.DataSource {
        id: executableOff
        engine: "executable"
        connectedSources: []
        
		onNewData: {
                parseOffResponse(data["exit code"])
				exited(sourceName, data.stdout)
				disconnectSource(sourceName) // cmd finished
		}

        function exec(cmd) {
            connectSource(cmd)
        }
        
        signal exited(string sourceName, string stdout)
    }
    
	function parseWatcherResponse(exitCode) {        
        //watchInitialState
        //onScriptStateWatcher
        if (onScriptStateWatcher) {
            if (exitCode != 0) {
                nameOffText = Plasmoid.configuration.nameOffText;
                checked = false;
                text = nameOffText;
                setColorStateAreaOff();
            } else {
                checked = true;
                text = name;
                setColorStateAreaOn();
            }
            watcherTimer.start();
        }
        
	}
    
	function parseOnResponse(exitCode) {
        //This code is executed when the command finish its execution 
		//var status = 1000; // 1000 mean not yet parsed (default value)
        //status = exitCode == 0 ? 0 : 1;
        if (onScriptResult) {
            if (exitCode != 0) {
                nameOffText = Plasmoid.configuration.nameOffText;
                checked = false;
                text = nameOffText;
                setColorStateAreaOff();
            } 
            //else {
            //}
            //nameOffText = status;
            //name = status;
            //text = name;
        }
	}
    
	function parseOffResponse(exitCode) {
        //This code is executed when the command finish its execution 
		//var status = 1000; // 1000 mean not yet parsed (default value)
        //status = exitCode == 0 ? 0 : 1;
        if (offScriptResult) {
            if (exitCode != 0) {
                nameOffText = "!";
            } else {
                nameOffText = Plasmoid.configuration.nameOffText;
            }
            text = nameOffText;
        }
	}
    
    function setColorStateAreaOn() {
        if (fullColor) {
            colorFlex1 = commonStyleHelper.onColor;
            colorFlex2 = commonStyleHelper.onColorShine;
        } 
        else {
            colorFlex1 = commonStyleHelper.inactiveColor;
            colorFlex2 = commonStyleHelper.inactiveColorShine;
        }
    }
    
    function setColorStateAreaOff() {
        colorOff1 = commonStyleHelper.offColor;
        colorOff2 = commonStyleHelper.offColorShine;
        
        if (fullColor) {
            colorFlex1 = commonStyleHelper.offColor;
            colorFlex2 = commonStyleHelper.offColorShine;
        } 
        else {
            colorFlex1 = commonStyleHelper.inactiveColor;
            colorFlex2 = commonStyleHelper.inactiveColorShine;
        }
    }
    
    function setColorStateAreaInactive() {
        colorFlex1 = commonStyleHelper.inactiveColor;
        colorFlex2 = commonStyleHelper.inactiveColorShine;
        colorOff1 = commonStyleHelper.inactiveColor;
        colorOff2 = commonStyleHelper.inactiveColorShine;
    }
    
    function toggleActionMainClick() {
        //State checked already changed before calling this function
        if (checked) {
            toggleAction(switchOn = true, false);
        }
        else {
            toggleAction(switchOn = false, false);
        }
    }

    function toggleAction(switchOn, toggleChecked) {
        //On click event this is already toggled
        if (toggleChecked) {checked = !checked;}
        
        //Main switch on/off
        if (switchOn) {
            //Update caption
            text = name;
            //Color feature
            setColorStateAreaOn();
            //Start watcher
            if (onScriptStateWatcher) watcherTimer.start();
            //On command execution
            if (onScriptEnabled) executableOn.exec(onScript);
            
        }
        else {
            //Update caption
            text = nameOffText;
            //Color feature
            setColorStateAreaOff();
            //Stop watcher
            watcherTimer.stop();
            //Off command execution
            if (offScriptEnabled) {executableOff.exec(offScript);} else {nameOffText = Plasmoid.configuration.nameOffText; text=nameOffText;}
        }
    }

    onClicked: toggleActionMainClick(); //Toggle state automatically (checked) THEN call toggleActionMainClick();
    
    function action_toggleOn() {
        checked = true;
        toggleAction(switchOn = true, false);
    }
    
    function action_toggleOff() {
        checked = false;
        toggleAction(switchOn = false, false);
    }
    
    function action_stopWatcher() {
        watcherTimer.stop();
    }
    
    function action_startWatcher() {
        watcherTimer.start();
    }
    
    Component.onCompleted: {
        //Right click settings
        plasmoid.setAction("toggleOn", i18n("Toggle on"), "bboxprev");
        plasmoid.setAction("toggleOff", i18n("Toggle off"), "bboxnext");
		plasmoid.setAction("stopWatcher", i18n("Stop on-script watcher"), "view-grid");
        plasmoid.setAction("startWatcher", i18n("Start on-script watcher"), "view-grid");

        
        if (Plasmoid.configuration.initialInactiveStateBox) {
            checked = false;
            text = nameInactiveText;
            setColorStateAreaInactive();
        }
        else {
            checked = Plasmoid.configuration.initialState;
            if (checked) {text=name;setColorStateAreaOn();} else {text=nameOffText;setColorStateAreaOff();}
            if (Plasmoid.configuration.activeInitialState) {toggleAction(switchOn = !checked, true);}
        }
        
        if (checked && watchInitialState && onScriptStateWatcher) {
            watcherTimer.start();
        }
    }
    
    /* Use these to enforce displaying the toggleSwitch itself */
    Plasmoid.switchWidth: units.gridUnit * 1
    Plasmoid.switchHeight: units.gridUnit * 1
}
