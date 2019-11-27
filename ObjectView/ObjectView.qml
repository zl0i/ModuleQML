import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
    property list<Item> items
    readonly property int count: items.length
    property bool show: true

    property int currentIndex: -1
    readonly property Item currentItem: (currentIndex > -1 && currentIndex < items.length) ?
                                            items[currentIndex] : null

    data: {
        if(show) {
            return (currentIndex > -1 && currentIndex < items.length) ? items[currentIndex] : null
        }
        return null
    }

    width: {
        if(show) {
            return (currentIndex > -1 && currentIndex < items.length) ? items[currentIndex].width : 0
        }
        return 0
    }
    height: {
        if(show) {
            return (currentIndex > -1 && currentIndex < items.length) ? items[currentIndex].height : 0
        }
        return 0
    }

    onCurrentIndexChanged: {
        if(show || !items[0])
            return

        for(var i = 0; i < items.length; i++) {
            console.log(i)
            if(i === currentIndex)
                items[i].visible = true
            else
                items[i].visible = false
        }
    }
    Component.onCompleted: {
        if(show)
            return

        for(var i = 0; i < items.length; i++) {
            if(i === currentIndex)
                items[i].visible = true
            else
                items[i].visible = false
        }
    }
}
