delay = 1000

setTimeout((->
    console.log "call"
    setTimeout arguments.callee, delay
    ), delay)

run = () ->
    console.log("run")
    setTimeout(run, 1000)

setTimeout(run, 1000)