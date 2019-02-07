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

import QtGraphicalEffects 1.0
import QtQuick.Extras.Private 1.0
import QtQuick.Extras.Private.CppUtils 1.0

ToggleButton {
    
    id: toggleMainCode
    
    CommonStyleHelper {
        id: commonStyleHelper
    }
    
    property bool switchOn
    property bool inactive: false;
    property string currentVersion: '4.5.0';
    property string updateResponse;
    property string name: Plasmoid.configuration.name
    property string nameOffText: Plasmoid.configuration.nameOffText
    property string nameInactiveText: Plasmoid.configuration.nameInactiveText
    property string hintText: Plasmoid.configuration.hintText
    property bool onScriptResult: Plasmoid.configuration.onScriptResult
    property bool offScriptResult: Plasmoid.configuration.offScriptResult
    property bool onScriptEnabled: Plasmoid.configuration.onScriptState
    property string onScript: Plasmoid.configuration.onScript
    property bool offScriptEnabled: Plasmoid.configuration.offScriptState
    property string offScript: Plasmoid.configuration.offScript
    
    property bool watchInitialState: Plasmoid.configuration.watchInitialState
    property bool onScriptStateWatcher: Plasmoid.configuration.onScriptStateWatcher
    property string onScriptWatcherCommand: Plasmoid.configuration.onScriptWatcherCommand
    property int watcherRefreshRate: Plasmoid.configuration.watcherRefreshRate
    
    property int circleDegree: 180;
    property int circleDegreeOff: 270;
    property int circleGradientSize: 1;
    property int extendedGradientSizePx: Plasmoid.configuration.extendedGradientSizePx;
    property bool fullColor: Plasmoid.configuration.fullColor
    property bool fullCircle: Plasmoid.configuration.fullCircle
    property bool extendedGradientSize: Plasmoid.configuration.extendedGradientSize
    property bool textFullColor: Plasmoid.configuration.textFullColor
    
    property string colorFlex1: commonStyleHelper.inactiveColor
    property string colorFlex2: commonStyleHelper.inactiveColorShine
    property string colorOff1: commonStyleHelper.offColor
    property string colorOff2: commonStyleHelper.offColorShine
    
    property string usedText1: Plasmoid.configuration.usedText1
    property string usedText2: Plasmoid.configuration.usedText2
    property string usedText3: Plasmoid.configuration.usedText3
    property string usedText4: Plasmoid.configuration.usedText4
    property string usedText5: Plasmoid.configuration.usedText5
    property string usedText6: Plasmoid.configuration.usedText6 //state
    
    property bool checkUpdateStartup: Plasmoid.configuration.checkUpdateStartup
    
    // ==============================================================================================================================================
    
    style: ToggleButtonStyle {
        
        //Style ID -------------------------------------------------------------------------
        
        id: circularButtonStyle
        
        //Main style -----------------------------------------------------------------------
        
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
        
        //Second style ----------------------------------------------------------------------
        
        readonly property ToggleButton control: __control
        checkedDropShadowColor: commonStyleHelper.onColor
        uncheckedDropShadowColor: commonStyleHelper.offColor
        
        //Background style ------------------------------------------------------------------
        
        background: Item {
            
            implicitWidth: __buttonHelper.implicitWidth
            implicitHeight: __buttonHelper.implicitHeight

            Connections {
                target: control
                onPressedChanged: {
                    backgroundCanvas.requestPaint();
                }

                onCheckedChanged: {
                    uncheckedCanvas.requestPaint();
                    checkedCanvas.requestPaint();
                }
            }

            Connections {
                target: circularButtonStyle

                onCheckedGradientChanged: checkedCanvas.requestPaint()
                onCheckedDropShadowColorChanged: checkedCanvas.requestPaint()
                onUncheckedGradientChanged: uncheckedCanvas.requestPaint()
                onUncheckedDropShadowColorChanged: uncheckedCanvas.requestPaint()
                onInactiveGradientChanged: {
                    checkedCanvas.requestPaint();
                    uncheckedCanvas.requestPaint();
                }
            }

            Connections {
                target: circularButtonStyle.checkedGradient
                onUpdated: checkedCanvas.requestPaint()
            }

            Connections {
                target: circularButtonStyle.uncheckedGradient
                onUpdated: uncheckedCanvas.requestPaint()
            }

            Connections {
                target: circularButtonStyle.inactiveGradient
                onUpdated: {
                    uncheckedCanvas.requestPaint();
                    checkedCanvas.requestPaint();
                }
            }

            Canvas {
                id: backgroundCanvas
                anchors.fill: parent

                onPaint: {
                    var ctx = getContext("2d");
                    __buttonHelper.paintBackground(ctx);
                }
            }

            Canvas {
                id: uncheckedCanvas
                anchors.fill: parent
                anchors.margins: -(__buttonHelper.radius * 3)
                visible: control.checked

                readonly property real xCenter: width / 2
                readonly property real yCenter: height / 2

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    /* Draw unchecked indicator */
                    ctx.beginPath();
                    ctx.lineWidth = __buttonHelper.outerArcLineWidth - __buttonHelper.innerArcLineWidth + circleGradientSize;
                    ctx.arc(xCenter, yCenter, __buttonHelper.outerArcRadius + __buttonHelper.innerArcLineWidth / 2,
                        MathUtils.degToRad(circleDegree), MathUtils.degToRad(circleDegreeOff), false);
                    var gradient = ctx.createLinearGradient(xCenter, yCenter + __buttonHelper.radius,
                        xCenter, yCenter - __buttonHelper.radius);
                    var relevantGradient = control.checked ? inactiveGradient : uncheckedGradient;
                    for (var i = 0; i < relevantGradient.stops.length; ++i) {
                        gradient.addColorStop(relevantGradient.stops[i].position, relevantGradient.stops[i].color);
                    }
                    ctx.strokeStyle = gradient;
                    ctx.stroke();
                }
            }

            Canvas {
                id: checkedCanvas
                anchors.fill: parent
                anchors.margins: -(__buttonHelper.radius * 3)
                visible: !control.checked

                readonly property real xCenter: width / 2
                readonly property real yCenter: height / 2

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    /* Draw checked indicator */
                    ctx.beginPath();
                    ctx.lineWidth = __buttonHelper.outerArcLineWidth - __buttonHelper.innerArcLineWidth + circleGradientSize;
                    ctx.arc(xCenter, yCenter, __buttonHelper.outerArcRadius + __buttonHelper.innerArcLineWidth / 2,
                        MathUtils.degToRad(circleDegreeOff), MathUtils.degToRad(0), false);
                    var gradient = ctx.createLinearGradient(xCenter, yCenter + __buttonHelper.radius,
                        xCenter, yCenter - __buttonHelper.radius);
                    var relevantGradient = control.checked ? checkedGradient : inactiveGradient;
                    for (var i = 0; i < relevantGradient.stops.length; ++i) {
                        gradient.addColorStop(relevantGradient.stops[i].position, relevantGradient.stops[i].color);
                    }
                    ctx.strokeStyle = gradient;
                    ctx.stroke();
                }
            }

            DropShadow {
                id: uncheckedDropShadow
                anchors.fill: uncheckedCanvas
                cached: true
                color: uncheckedDropShadowColor
                source: uncheckedCanvas
                visible: !control.checked
            }

            DropShadow {
                id: checkedDropShadow
                anchors.fill: checkedCanvas
                cached: true
                color: checkedDropShadowColor
                source: checkedCanvas
                visible: control.checked
            }
        }
        
        //Panel style -----------------------------------------------------------------------
        
        panel: Item {
            implicitWidth: backgroundLoader.implicitWidth
            implicitHeight: backgroundLoader.implicitHeight

            Loader {
                id: backgroundLoader
                anchors.fill: parent
                sourceComponent: background
            }

            Loader {
                id: labelLoader
                sourceComponent: label
                anchors.fill: parent
                anchors.leftMargin: padding.left
                anchors.topMargin: padding.top
                anchors.rightMargin: padding.right
                anchors.bottomMargin: padding.bottom
            }
        }
        
    }
    
    // ==============================================================================================================================================
    
    text: usedText1 + usedText2 + usedText3 + usedText4 + usedText5
    //text: colorizeText(name)
    tooltip: hintText
    
    Timer {
        id:watcherTimer
        interval: watcherRefreshRate*1000
        onTriggered: watcherOnTime()
    }

	function colorizeText(string) {
        
        //used like that to be able to update text dynamically from settings
        
        Plasmoid.configuration.usedText4 = string;
        
        if (textFullColor) {
            Plasmoid.configuration.usedText1 = "<font color='";
            Plasmoid.configuration.usedText3 = "'>";
            Plasmoid.configuration.usedText5 = "</font>";
            if (inactive) {Plasmoid.configuration.usedText2 = commonStyleHelper.inactiveColor;} 
            else { 
                if (checked)  {Plasmoid.configuration.usedText2 = commonStyleHelper.onColor;}
                else          {Plasmoid.configuration.usedText2 = commonStyleHelper.offColor;}
            }
        } 
        else {
            Plasmoid.configuration.usedText1 = "";
            Plasmoid.configuration.usedText2 = "";
            Plasmoid.configuration.usedText3 = "";
            Plasmoid.configuration.usedText5 = "";
        }
        
        if (inactive) {Plasmoid.configuration.usedText6 = "inactive";} 
        else { 
            if (checked)  {Plasmoid.configuration.usedText6 = "on";}
            else          {Plasmoid.configuration.usedText6 = "off";}
        }
	}
    
	function initValues() {
        
        if (fullCircle) {
            circleDegree = 0;
            circleDegreeOff = 360;
        } 
        else {
            circleDegree = 180;
            circleDegreeOff = 270;
        }

        if (extendedGradientSize) {
            circleGradientSize = extendedGradientSizePx;
        } 
        else {
            circleGradientSize = 0;
        }
        
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
    
    PlasmaCore.DataSource {
        id: executableNotification
        engine: "executable"
        onNewData: disconnectSource(sourceName) // cmd finished
        function exec(cmd) {
            connectSource(cmd)
        }
    }
    
	function parseWatcherResponse(exitCode) {        
        //init style
        initValues();
        
        //watchInitialState
        //onScriptStateWatcher
        if (onScriptStateWatcher) {
            if (exitCode != 0) {
                nameOffText = Plasmoid.configuration.nameOffText;
                checked = false;
                colorizeText(nameOffText);
                setColorStateAreaOff();
            } else {
                checked = true;
                colorizeText(name);
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
                colorizeText(nameOffText);
                setColorStateAreaOff();
            }
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
            colorizeText(nameOffText);
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
        
        //Reset inactive bool
        inactive = false;
        
        //Reset init value
        initValues();
        
        //Main switch on/off
        if (switchOn) {
            //Update caption
            colorizeText(name);
            //Color feature
            setColorStateAreaOn();
            //Start watcher
            if (onScriptStateWatcher) watcherTimer.start();
            //On command execution
            if (onScriptEnabled) executableOn.exec(onScript);
            
        }
        else {
            //Update caption
            colorizeText(nameOffText);
            //Color feature
            setColorStateAreaOff();
            //Stop watcher
            watcherTimer.stop();
            //Off command execution
            if (offScriptEnabled) {executableOff.exec(offScript);} else {nameOffText = Plasmoid.configuration.nameOffText; colorizeText(nameOffText);}
        }
    }

    onClicked: toggleActionMainClick(); //Toggle state automatically (checked) THEN call toggleActionMainClick();
    
    function availableUpdate() {
        var notificationCommand = "notify-send --icon=system-shutdown 'Plasmoid Switch On Off' 'An update is available \n<a href=\"https://www.opendesktop.org/p/1288840/\">Update link</a>' -t 30000";
        executableNotification.exec(notificationCommand);
    }
    
    function updaterNotification() {
        //version='4.5.0';
        //https://raw.githubusercontent.com/Intika-Linux-KDE/Plasmoid-On-Off-Switch-Commands/master/version
        var xhr = new XMLHttpRequest;
        xhr.responseType = 'text';
        xhr.open("GET", "https://raw.githubusercontent.com/Intika-Linux-KDE/Plasmoid-On-Off-Switch-Commands/master/version");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                updateResponse = xhr.responseText;
                console.log('d'+updateResponse+'d');
                console.log('d'+currentVersion+'d');
                if (updateResponse.localeCompare(currentVersion)) {
                    availableUpdate();
                }
            }
        };
        xhr.send();
    }
    
    function action_toggleOn() {
        checked = true;
        toggleAction(switchOn = true, false);
    }
    
    function action_toggleOff() {
        checked = false;
        toggleAction(switchOn = false, false);
    }
    
    function action_setInactive() {
        inactive = true;
        checked = false;
        watcherTimer.stop();
        toggleAction(switchOn = false, false);
        colorizeText(nameInactiveText);
        setColorStateAreaInactive();
    }
    
    function action_stopWatcher() {
        watcherTimer.stop();
    }
    
    function action_startWatcher() {
        watcherTimer.start();
    }
    
    function action_checkUpdate() {
        updaterNotification();
    }
    
    Component.onCompleted: {
        
        //Right click settings
        plasmoid.setAction("toggleOn", i18n("Toggle on"), "bboxprev");
        plasmoid.setAction("toggleOff", i18n("Toggle off"), "bboxnext");
        plasmoid.setAction("setInactive", i18n("Stop and set inactive"), "bboxprev");
		plasmoid.setAction("stopWatcher", i18n("Stop on-script watcher"), "view-grid");
        plasmoid.setAction("startWatcher", i18n("Start on-script watcher"), "view-grid");
        plasmoid.setAction("checkUpdate", i18n("Check for updates on github"), "view-grid");
        
        //Init state 
        initValues();
        
        //Load settings
        if (Plasmoid.configuration.initialInactiveStateBox) {
            inactive = true;
            checked = false;            
            colorizeText(nameInactiveText);
            setColorStateAreaInactive();
        }
        else {
            checked = Plasmoid.configuration.initialState;
            if (checked) {colorizeText(name);setColorStateAreaOn();} else {colorizeText(nameOffText);setColorStateAreaOff();}
            if (Plasmoid.configuration.activeInitialState) {toggleAction(switchOn = !checked, true);}
        }
        
        //Watcher on startup settings
        if (checked && watchInitialState && onScriptStateWatcher) {
            inactive = false;
            watcherTimer.start();
        }
        
        //Updater
        if (checkUpdateStartup) {
            updaterNotification();
        }
    }
    
    /* Use these to enforce displaying the toggleSwitch itself */
    Plasmoid.switchWidth: units.gridUnit * 1
    Plasmoid.switchHeight: units.gridUnit * 1
}
