import QtQuick 2.12
import QtQuick.Controls 2.5

MouseArea {
    id: _delegate

    drag.target: isEdit ? _content : undefined
    onPressAndHold: editStart()

    default property list<Item> content
    property var view
    property var isEdit: false

    signal editStart()
    signal dropEntered(var drag)
    signal dropExited()
    signal dropped(var drop)
    signal dropPositionChanged(var drag)

    Item {
        id: _content
        width: _delegate.width; height: _delegate.height

        anchors {
            horizontalCenter: parent.horizontalCenter;
            verticalCenter: parent.verticalCenter
        }

        Drag.active: _delegate.drag.active
        Drag.source: _delegate
        Drag.hotSpot.x: width/2
        Drag.hotSpot.y: height/2

        data: _delegate.content

        states: [
            State {
                when: _content.Drag.active
                ParentChange {
                    target: _content
                    parent: _delegate.view
                }
                AnchorChanges {
                    target: _content;
                    anchors.horizontalCenter: undefined;
                    anchors.verticalCenter: undefined
                }

            }
        ]
    }

    NumberAnimation {
        target: _content
        property: "rotation"
        property int angle: 3
        from: -angle
        to: angle
        duration: 100
        running: isEdit && !_content.Drag.active
        easing.type: Easing.InOutQuad
        onStopped: {
            _content.rotation = 0
        }
        onFinished: {
            if(to === angle) {
                to = - angle
                from = angle
            }
            else {
                to = angle
                from = -angle
            }
            start()
        }
    }

    DropArea {
        anchors.fill: parent
        onDropped: _delegate.dropped(drop)
        onEntered: _delegate.dropEntered(drag)
        onExited: _delegate.dropExited()
        onPositionChanged: _delegate.dropPositionChanged(drag)
    }
}
