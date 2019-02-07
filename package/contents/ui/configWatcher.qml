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
    id: configPageWatcher
    
    property alias cfg_onScriptStateWatcher: onScriptStateWatcherBox.checked
    property alias cfg_onScriptWatcherCommand: onScriptWatcherCommand.text
    property alias cfg_watcherRefreshRate: watcherRefreshRate.value
    
    ColumnLayout {    
        GroupBox {
            flat: true
            ColumnLayout {
                Label {
                    text: i18n("\nOn-Script State Watcher")
                    font.weight: Font.Bold
                }
                Label {
                    text: i18n("Command to check the 'on script' state\nThis will switch off the plasmoid state if the command fail\n")
                }
                CheckBox {
                    id: onScriptStateWatcherBox
                    checked: onScriptWatcherCommand.activeFocus || onScriptWatcherCommand.length
                    text: i18n("Check to enable the 'on script' watcher")
                    onClicked: if (checked) onScriptWatcherCommand.forceActiveFocus();
                }
                TextField {
                    id: onScriptWatcherCommand
                    Layout.minimumWidth: 300
                    enabled: onScriptStateWatcherBox.checked
                    placeholderText: i18n("Enter full path of the watcher script")
                }
                
                Label {
					text: i18n("\nRefresh rate:")
                    enabled: onScriptStateWatcherBox.checked
				}
				
				SpinBox {
					id: watcherRefreshRate
					suffix: i18n(" Seconds")
                    enabled: onScriptStateWatcherBox.checked
					minimumValue: 1
					maximumValue: 3600
				}
                Label {
                    text: i18n("\nNote")
                    font.weight: Font.Bold
                }
                Label {
                    text: i18n("Modified watcher settings will be used on next toggle")
                }
            }
        }
    }
}
