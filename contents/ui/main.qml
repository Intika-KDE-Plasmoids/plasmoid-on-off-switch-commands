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
import QtQuick.Extras 1.4
import org.kde.plasma.plasmoid 2.0
import ApplicationLauncher 1.0

ToggleButton {
    property string name: Plasmoid.configuration.name
    // property bool persistentState: Plasmoid.configuration.persistentState
    property bool onScriptEnabled: Plasmoid.configuration.onScriptState
    property string onScript: Plasmoid.configuration.onScript
    property bool offScriptEnabled: Plasmoid.configuration.offScriptState
    property string offScript: Plasmoid.configuration.offScript

    text: name
    tooltip: "Toggle " + name

    Application{
	id: launcher
	appName: "/bin/true"
    }

    function toggleAction() {
	if (checked) {
	    if (onScriptEnabled) {
		launcher.appName = onScript;
		launcher.launchScript();
	    }
	} else {
	    if (offScriptEnabled) {
		launcher.appName = offScript;
		launcher.launchScript();
	    }
	}
    }

    onClicked: toggleAction();

    Component.onCompleted: {
	checked = Plasmoid.configuration.initialState;
	toggleAction();
    }

    /* Use these to enforce displaying the toggleSwitch itself */
    Plasmoid.switchWidth: units.gridUnit * 1
    Plasmoid.switchHeight: units.gridUnit * 1
}
