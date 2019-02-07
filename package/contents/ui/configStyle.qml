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
    id: configPageStyle

    property alias cfg_fullColor: fullColorBox.checked
    property alias cfg_fullCircle: fullCircleBox.checked
    property alias cfg_extendedGradientSize: extendedGradientSizeBox.checked
    property alias cfg_textFullColor: textFullColorBox.checked
    property alias cfg_extendedGradientSizePx: extendedGradientSizePx.value
    
    ColumnLayout {
        Label {
            text: i18n("\nStyle Settings")
            font.weight: Font.Bold
        }
        CheckBox {
            id: textFullColorBox
            text: i18n("Set the text color according to the state,\nThe displayed text will be red or green")
        }
        CheckBox {
            id: fullColorBox
            text: i18n("Extanded colorization state of the circle,\nThe same area is used to display the state")
            enabled: !fullCircleBox.checked
        }
        CheckBox {
            id: fullCircleBox
            text: i18n("Use the whole circle to display the state,\nSet the state gradient to 360 degrees")
            onClicked: if (checked) {fullColorBox.checked=true;fullColorBox.enabled=false;} else {fullColorBox.checked=false;fullColorBox.enabled=true;}
        }
        CheckBox {
            id: extendedGradientSizeBox
            text: i18n("Extend the width of the gradient,\nMake the cirle state indicator thicker by n pixels")
        }
        SpinBox {
            id: extendedGradientSizePx
            suffix: i18n(" Px")
            enabled: extendedGradientSizeBox.checked
            minimumValue: 0
            maximumValue: 300
        }
        Label {
            text: i18n("\nNote")
            font.weight: Font.Bold
        }
        Label {
            text: i18n("Modified style settings will be used on next toggle")
        }
    }
}
