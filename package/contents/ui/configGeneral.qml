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

Item {
    id: configPage

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
    property alias cfg_fullColor: fullColorBox.checked
    
    ColumnLayout {
        CheckBox {
            id: activeInitialStateBox
            text: i18n("Execute toggle action on startup")
            enabled: !initialInactiveStateBox.checked
        }
        CheckBox {
            id: watchInitialStateBox
            text: i18n("Watch state on startup, details on the watcher section *")
            tooltip: "On-script watcher feature need to be enabled for this to work"
            enabled: !initialInactiveStateBox.checked
            onClicked: if (checked) {initialStateBox.checked=true;initialStateBox.enabled=false;} else {initialStateBox.checked=false;initialStateBox.enabled=true;}
        }
        CheckBox {
            id: initialStateBox
            text: i18n("Set the initial state to on (upon startup, does not run script)")
            onClicked: if (!checked) {watchInitialStateBox.checked=false;}
            enabled: !initialInactiveStateBox.checked
        }
        CheckBox {
            id: initialInactiveStateBox
            text: i18n("Set the initial state to inactive (upon startup)")
            onClicked: if (checked) {activeInitialStateBox.enabled=false;initialStateBox.enabled=false;watchInitialStateBox.enabled=false;} else {activeInitialStateBox.enabled=true;initialStateBox.enabled=true;watchInitialStateBox.enabled=true;}
        }
        CheckBox {
            id: fullColorBox
            text: i18n("Extanded colorization state of the circle")
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
    }
}
