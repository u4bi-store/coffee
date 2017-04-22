color = [ { name: "red", age: 14 },
                    { name: "green", age: 14 },
                    { name: "blue", age: 14 },
                    { name: "yellow", age: 14 },
                    { name: "black", age: 14 },
                    { name: "orange", age: 14 } ]

names = color.map (item) -> item.name

console.log(names)

# [ 'red', 'green', 'blue', 'yellow', 'black', 'orange' ]