human = [
  {
    name: "blue"
    age: 14
  },
  {
    name: "red"
    age: 10
  }
]

# console.log(human) # 위와 같은 객체 배열이 존재

# human에서 [blue] 란 키로 액세스하고 싶다면 오브젝트로 변환

Array::toDict = (key) ->
  dict = {}
  dict[obj[key]] = obj for obj in this when obj[key]?
  dict

# reduce를 사용

# Array::toDict = (key) ->
#   @reduce ((dict, obj) ->
#       dict[obj[key]] = obj if obj[key]?; return dict), {}


# console.log(human.toDict('name')); # 오브젝트로 변환
console.log(human.toDict('name')['blue']);