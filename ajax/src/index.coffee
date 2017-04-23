container = document.getElementById("container")
data = null

xhr = new XMLHttpRequest()
xhr.open("GET","./data/item.json", true)

xhr.onreadystatechange = (e) ->
    if this.readyState is 4 && this.status is 200
        data = JSON.parse(xhr.responseText)
        container.innerHTML = data.item 

xhr.send(null)