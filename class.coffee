class Human
    constructor:  ->
        @properties=
            name: ''
            age: 0
            join: false
    setName: (name) ->
        @properties.name = name
        this
    setAge: (age) ->
        @properties.age = age
        this
    setJoin: (join) ->
        @properties.join = join
        this

blueHuman = new Human()

blueHuman.properties # => { name: '', age: 0, join: false }
console.log(blueHuman.properties)

redHuman = new Human().setName('u4bi').setAge(14).setJoin(true)
redHuman.properties # => { name: 'u4bi', age: 14, join: true }
console.log(redHuman.properties)