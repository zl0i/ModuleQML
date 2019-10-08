pragma Singleton
import QtQuick 2.0

QtObject {

    property int timeout: 30000

    function ajaxPOST(url, data, success, fail) {
        var xhr = new XMLHttpRequest()
        xhr.timeout = timeout
        xhr.open("POST", url, true)        

        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
        xhr.setRequestHeader('Content-Length', data.length)

        xhr.onload = function() {
            console.log("Загружено!")
            success(xhr.responseText)
        }

        xhr.onerror = function() {
            console.log("Ошибка соединения")
            fail(xhr.status, xhr.statusText)
        }

        xhr.send(data)
    }

    function ajaxGET(url, data, success, fail) {
        var xhr = new XMLHttpRequest()
        xhr.timeout = timeout

        var fullUrl = url
        if(data !== "")
            fullUrl += '?' + data;
        xhr.open("POST", fullUrl, true)

        xhr.onload = function() {
            console.log("Загружено!")
        }

        xhr.onerror = function() {
            console.log("Ошибка соединения")
        }

        xhr.send()
    }

}
