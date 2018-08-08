/*
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
    property alias cfg_name: nameText.text
    // property alias cfg_persistentState: persistentStateBox.checked
    property alias cfg_initialState: initialStateBox.checked
    property alias cfg_onScriptState: onScriptStateBox.checked
    property alias cfg_onScript: onScriptText.text
    property alias cfg_offScriptState: offScriptStateBox.checked
    property alias cfg_offScript: offScriptText.text

    ColumnLayout {
	RowLayout {
	    Label { text: "Name of the switch:" }
	    TextField {
		id: nameText
		placeholderText: i18n("Enter switch name")
	    }
	}
	// CheckBox {
	//     id: persistentStateBox
	//     text: i18n("Check if switch state shall be persistent")
	// }
	CheckBox {
	    id: initialStateBox
	    text: i18n("Check to set the initial state (upon startup) to on")
	}
	GroupBox {
	    flat: true
	    ColumnLayout {
		Label {
		    text: i18n("On-Script")
		    font.weight: Font.Bold
		}
		TextField {
		    id: onScriptText
		    Layout.minimumWidth: 300
		    enabled: onScriptStateBox.checked
		    placeholderText: i18n("Enter full path of the onScript")
		}
		CheckBox {
		    id: onScriptStateBox
		    checked: onScriptText.activeFocus || onScriptText.length
		    text: i18n("Check to enable the onScript")

		    onClicked: if (checked) onScriptText.forceActiveFocus();
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
		TextField {
		    id: offScriptText
		    Layout.minimumWidth: 300
		    enabled: offScriptStateBox.checked
		    placeholderText: i18n("Enter full path of the offScript")
		}
		CheckBox {
		    id: offScriptStateBox
		    checked: offScriptText.activeFocus || offScriptText.length
		    text: i18n("Check to enable the offScript")

		    onClicked: if (checked) offScriptText.forceActiveFocus();
		}

	    }
	}
    }
}
