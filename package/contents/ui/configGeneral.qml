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
import QtQuick.Controls 1.4
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: configPageGeneral

    // Use assignement to cfg_* to make use of Cancel / Apply buttons
    // property alias cfg_persistentState: persistentStateBox.checked
    property alias cfg_name: nameText.text
    property alias cfg_nameOffText: nameOffText.text
    property alias cfg_nameInactiveText: nameInactiveText.text
    property alias cfg_hintText: hintText.text
    property alias cfg_watchInitialState: watchInitialStateBox.checked
    property alias cfg_activeInitialState: activeInitialStateBox.checked
    property alias cfg_initialState: initialStateBox.checked
    property alias cfg_initialInactiveStateBox: initialInactiveStateBox.checked
    
    //Used text variable part 1, 2, 3, 4 to be able to live update from settings
    property alias cfg_usedText1: usedText1.text
    property alias cfg_usedText2: usedText2.text
    property alias cfg_usedText3: usedText3.text
    property alias cfg_usedText4: usedText4.text
    property alias cfg_usedText5: usedText5.text
    property alias cfg_usedText6: usedText6.text //state
    
    property string nameOn: nameText.text
    property string nameOff: nameOffText.text
    property string nameInactive: nameInactiveText.text
    
    onNameOnChanged: fkingConfigChanged()
    onNameOffChanged: fkingConfigChanged()
    onNameInactiveChanged: fkingConfigChanged()
   
    function fkingConfigChanged() {
        //console.log('Changed ');
        if (usedText6.text == 'on')         {usedText4.text=nameText.text;}
        if (usedText6.text == 'off')        {usedText4.text=nameOffText.text;}
        if (usedText6.text == 'inactive')   {usedText4.text=nameInactiveText.text;}
    }
    
    //Component.onCompleted: {
        //console.log('some onCompleted');
    //}
    
    //Component.onDestruction: {
        //console.log('some onDestruction');
    //}
    
    ColumnLayout {
        Label {
            text: i18n("\nStartup Settings")
            font.weight: Font.Bold
        }
        CheckBox {
            id: activeInitialStateBox
            text: i18n("Init: execute toggle action on startup")
            enabled: !initialInactiveStateBox.checked
        }
        CheckBox {
            id: watchInitialStateBox
            text: i18n("Init: watch state on startup, details on the watcher section *")
            tooltip: "On-script watcher feature need to be enabled for this to work"
            enabled: !initialInactiveStateBox.checked
            onClicked: if (checked) {initialStateBox.checked=true;initialStateBox.enabled=false;} else {initialStateBox.checked=false;initialStateBox.enabled=true;}
        }
        CheckBox {
            id: initialStateBox
            text: i18n("Init: set the initial state to on (upon startup, does not run script)")
            onClicked: if (!checked) {watchInitialStateBox.checked=false;}
            enabled: !initialInactiveStateBox.checked
        }
        CheckBox {
            id: initialInactiveStateBox
            text: i18n("Init: set the initial state to inactive (upon startup)")
            onClicked: if (checked) {activeInitialStateBox.enabled=false;initialStateBox.enabled=false;watchInitialStateBox.enabled=false;} else {activeInitialStateBox.enabled=true;initialStateBox.enabled=true;watchInitialStateBox.enabled=true;}
        }
        Label {
            text: i18n("\nLabel Settings")
            font.weight: Font.Bold
        }
        RowLayout {
            TextField {
                id: nameText
            }
            Label { text: " Displayed text on enabled (on) state" }
        }
        RowLayout {
            TextField {
                id: nameOffText
            }
            Label { text: " Displayed text on disabled (off) state" }
        }
        RowLayout {
            TextField {
                id: nameInactiveText
            }
            Label { text: " Displayed text on inactive state" }
        }
        RowLayout {
            TextField {
                id: hintText
                placeholderText: i18n("Switch text")
            }
            Label { text: " Popup hint/tooltip text" }
        }
        RowLayout {
            //Debug
            visible: false;
            Label {
                text: i18n("\nNote")
                font.weight: Font.Bold
            }
            Label {
                text: i18n("Modified label settings will be used on next toggle")
            }
        }
        RowLayout {
            //Debug
            visible: false;
            PlasmaComponents.Button {
                text: "Force apply label changes and preview on the current plasmoid"
                onClicked: {
                    fkingConfigChanged();
                }
            }
        }
        RowLayout {
            //Debug
            visible: false;
            TextField {
                id: usedText1
            }
            TextField {
                id: usedText2
            }
            TextField {
                id: usedText3
            }
            TextField {
                id: usedText4
            }
            TextField {
                id: usedText5
            }
            TextField {
                id: usedText6
            }
        }
    }
    
    
    
    
}
