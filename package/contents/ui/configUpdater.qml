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
    id: configPageUpdater
    
    property alias cfg_checkUpdateStartup: checkUpdateStartupBox.checked
    
    ColumnLayout {    
        GroupBox {
            flat: true
            ColumnLayout {
                Label {
                    text: i18n("\nUpdater")
                    font.weight: Font.Bold
                }
                Label {
                    text: i18n("Plasmoid: On-Off Switch Commands\n")
                }
                Label {
                    text: i18n("Version: 4.7.0")
                }
                Label {
                    text: i18n("Author: Intika")
                }
                TextField {
                    Layout.minimumWidth: 450
                    text: 'https://github.com/Intika-Linux-KDE/Plasmoid-On-Off-Switch-Commands'
                }
                CheckBox {
                    id: checkUpdateStartupBox
                    text: i18n("Notify for update on startup (checked once on github, 5 min after startup)")
                }
            }
        }
    }
}
