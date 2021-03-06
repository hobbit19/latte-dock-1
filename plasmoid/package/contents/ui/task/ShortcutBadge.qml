/*
*  Copyright 2019  Michail Vourlakos <mvourlakos@gmail.com>
*
*  This file is part of Latte-Dock
*
*  Latte-Dock is free software; you can redistribute it and/or
*  modify it under the terms of the GNU General Public License as
*  published by the Free Software Foundation; either version 2 of
*  the License, or (at your option) any later version.
*
*  Latte-Dock is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.7
import QtGraphicalEffects 1.0

import org.kde.latte 0.2 as Latte

Loader{
    id: shorcutBadge
    anchors.fill: iconImageBuffer
    active: root.showTaskShortcutBadges && !taskItem.isSeparator && fixedIndex>=0 && fixedIndex<20
    asynchronous: true
    visible: badgeString !== ""

    property int fixedIndex:-1
    property string badgeString: (shorcutBadge.fixedIndex>=1 && shorcutBadge.fixedIndex<20 && root.badgesForActivate.length===19) ?
                                     root.badgesForActivate[shorcutBadge.fixedIndex-1] : ""

    Connections {
        target: root
        onShowTaskShortcutBadgesChanged: shorcutBadge.fixedIndex = parabolicManager.pseudoTaskIndex(index+1);
    }

    Component.onCompleted: fixedIndex = parabolicManager.pseudoTaskIndex(index+1);

    sourceComponent: Item{
        Loader{
            anchors.fill: taskNumber
            active: root.enableShadows

            sourceComponent: DropShadow{
                color: root.appShadowColor
                fast: true
                samples: 2 * radius
                source: taskNumber
                radius: root.appShadowSize/2
                verticalOffset: 2
            }
        }

        Latte.BadgeText {
            id: taskNumber
            anchors.centerIn: parent
            minimumWidth: 0.4 * (wrapper.mScale * root.iconSize)
            height: Math.max(24, 0.4 * (wrapper.mScale * root.iconSize))

            border.color: root.minimizedDotColor
            textValue: shorcutBadge.badgeString

            showNumber: false
            showText: true

            proportion: 0
            radiusPerCentage: 50
        }
    }
}
