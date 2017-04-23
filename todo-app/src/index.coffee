
# dom을 불러온다
addInput = document.getElementById("new-task") # 할일 등록 input태그
addButton = document.getElementsByTagName("button")[0] # 할일 등록 button태그

incompleteTasks = document.getElementById("incomplete-tasks") ## 할일 목록 ul태그

completedTasks = document.getElementById("completed-tasks") ## 이미 한일 ul태그


# 일거리 element를 생성하는 함수

createNewTaskElement = (inputString) ->
  
  # 생성
  listItem = document.createElement "li"         # 아래를 감쌀 li 태그 생성
  checkBox = document.createElement "input"      # 체크박스 input 태그 생성
  
  label = document.createElement "label"         # 할일 메세지 label 태그 생성
  inputText = document.createElement "input"     # 메세지 수정 input 태그 생성

  editButton = document.createElement "button"   # 수정 button 태그 생성
  deleteButton = document.createElement "button" # 삭제 button 태그 생성
  
  # 생성한 엘리먼트에 알맞는 값 정의
  checkBox.type = "checkbox"        # input의 유형을 checkobox로 설정
  inputText.type = "text"           # input의 유형을 text로 설정
  
  editButton.innerHTML = "수정"      # 수정 버튼의 내부 텍스트를 설정
  editButton.className = "edit"     # 수정 버튼의 클래스 지정

  deleteButton.innerHTML = "삭제"    # 삭제 버튼의 내부 텍스트를 설정
  deleteButton.className = "delete" # 삭제 버튼의 클래스 지정

  label.innerText = inputString # label안의 내용을 함수의 인자값으로 정의
  
  # 생성한 li태그에 모두 붙힌다.
  listItem.appendChild checkBox
  listItem.appendChild label
  listItem.appendChild inputText
  listItem.appendChild editButton
  listItem.appendChild deleteButton

  return listItem # 정의된 li태그를 반환


# 각 element에 주입할 이벤트 정의

funAddTask = -> # 할일 등록
  listItem = createNewTaskElement(addInput.value) # 작업이 담긴 li태그 element 생성
  
  incompleteTasks.appendChild(listItem) # 할일 목록 ul태그에 listitem 부착

  funBindTaskEvents(listItem, funTaskCompleted) # 작업이 담긴 listitem안의 자식 element들에게 이벤트 주입

  addInput.value = "" # 할일 등록 input 태그의 내용을 빈칸으로 변경

funEditTask = -> # 할일 수정
  listItem = this.parentNode # 현재 객체의 부모 element를 참조

  editInput = listItem.querySelector("input[type=\"text\"]") # input태그의 유형이 text인걸 찾아 정의  
  label = listItem.querySelector("label") # label 태그를 찾아 정의

  if listItem.classList.contains("editMode") # 만약 부모 element의 클래스가 editMode라면  
    label.innerText = editInput.value # label 태그에다 input태그에 담긴 내용을 주입  
  else # 만약 editMode가 아니라면
    editInput.value = label.innerText # input 태그에다 label 태그에 담긴 내용을 주입 

  listItem.classList.toggle("editMode") # 부모 element의 클래스에 editMode가 없다면 주입 있다면 제거 / 전환 classList.toggle

funDeleteTask = -> # 할일 삭제
  listItem = this.parentNode # 현재 객체의 부모 element를 참조 (li태그)

  ul = listItem.parentNode # 부모 element의 부모 참조 (ul태그)

  ul.removeChild(listItem) # 부모의 부모(ul태그)에서 부모(li태그) element를 삭제

funTaskCompleted = -> # 할일 완료 / 체크박스 누를시
  listItem = this.parentNode # 현재 객체의 부모 element를 참조 (li태그)

  completedTasks.appendChild(listItem) # 이미 한일 ul태그에 listitem 부착

  funBindTaskEvents(listItem, funTaskIncomplete) # 작업이 담긴 listitem안의 자식 element들에게 이벤트 주입

funTaskIncomplete = -> # 이미 한일 할일로 되돌리기
  listItem = this.parentNode # 현재 객체의 부모 element를 참조 (li태그)
  
  incompleteTasks.appendChild(listItem) # 할일 목록 ul태그에 listitem 부착

  funBindTaskEvents(listItem, funTaskCompleted) # 작업이 담긴 listitem안의 자식 element들에게 이벤트 주입


# 각 dom에 이벤트 부착
funBindTaskEvents = (taskListItem, checkBoxEventHandler) ->
  
  # li태그의 자식 element 불러와 정의
  checkBox = taskListItem.querySelector "input[type=\"checkbox\"]"
  editButton = taskListItem.querySelector ".edit"
  deleteButton = taskListItem.querySelector ".delete"
  
  # 불러온 element에 이미 정의한 이벤트를 주입한다.
  editButton.onclick = funEditTask # 수정 이벤트
  deleteButton.onclick = funDeleteTask # 삭제 이벤트
  checkBox.onchange = checkBoxEventHandler # 인자로 받은 이벤트 주입


# 할일 등록 button태그에 클릭 이벤트를 주입한다 / 콜백은 funAddTask
addButton.addEventListener("click", funAddTask)


# 할일목록의 자식 element들에게 이벤트를 주입
incompleteTasksChildren = incompleteTasks.children # 자식들을 모두 어레이에 담는다

for listItem in incompleteTasksChildren # 정의된 어레이의 원소
  funBindTaskEvents(listItem, funTaskCompleted) # 이벤트 주입 / 할일 완료

# 이미한일의 자식element들에게 이벤트를 주입
completedTasksChildren = completedTasks.children # 자식들을 모두 어레이에 담는다

for listItem in completedTasksChildren # 정의된 어레이의 원소
  funBindTaskEvents(listItem, funTaskIncomplete) # 이벤트 주입 / 이미 한일 할일로 되돌리기