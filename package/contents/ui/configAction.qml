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

    property alias cfg_onScriptResult: onScriptResultBox.checked
    property alias cfg_offScriptResult: offScriptResultBox.checked
    property alias cfg_onScriptState: onScriptStateBox.checked
    property alias cfg_onScript: onScriptText.text
    property alias cfg_offScriptState: offScriptStateBox.checked
    property alias cfg_offScript: offScriptText.text
    
    ColumnLayout {
        GroupBox {
            flat: true
            ColumnLayout {
                Label {
                    text: i18n("On-Script")
                    font.weight: Font.Bold
                }
                CheckBox {
                    id: onScriptStateBox
                    checked: onScriptText.activeFocus || onScriptText.length
                    text: i18n("Check to enable the on script")
                    onClicked: if (checked) onScriptText.forceActiveFocus();
                }
                TextField {
                    id: onScriptText
                    Layout.minimumWidth: 300
                    enabled: onScriptStateBox.checked
                    placeholderText: i18n("Enter full path of the on script")
                }
            }
        }
        GroupBox {
            flat: true
            ColumnLayout {
                Label {
                    text: i18n("Off-Script")
                    font.weight: Font.Bold
                }
                CheckBox {
                    id: offScriptStateBox
                    checked: offScriptText.activeFocus || offScriptText.length
                    text: i18n("Check to enable the off script")
                    onClicked: if (checked) offScriptText.forceActiveFocus();
                }
                TextField {
                    id: offScriptText
                    Layout.minimumWidth: 300
                    enabled: offScriptStateBox.checked
                    placeholderText: i18n("Enter full path of the off script")
                }
            }
        }
        GroupBox {
            flat: true
            ColumnLayout {
                Label {
                    text: i18n("On-Script Result")
                    font.weight: Font.Bold
                }
                CheckBox {
                    id: onScriptResultBox
                    text: i18n("Change state to off if on-script fail (execution result)")
                }
            }
        }
        GroupBox {
            flat: true
            ColumnLayout {
                Label {
                    text: i18n("Off-Script Result")
                    font.weight: Font.Bold
                }
                CheckBox {
                    id: offScriptResultBox
                    text: i18n("Change state text to '!' if off-script fail (execution result)")
                }
            }
        }
    }
}
