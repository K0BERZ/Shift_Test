# Shift_Test
Тестовое задание IOS

Тест работоспособности проводился на iOS 14 и 16.4. Но должно работать и с IOS 13.0

Приложение состоит из двух экранов: экран регистрации и основной.
  
На экране регистрации есть поле ввода имени, поле ввода фамилии, лейбл “Дата рождения” и UIDatePicker для интерактивного выбора даты рождения, поле для ввода пароля, поле подтверждения пароля и кнопка регистрации. 

Регистрация не может быть завершена, пока все поля не будут валидны. Имя и фамилия не должны содержать цифры, пробелы и специальные символы. Пароль должен состоять из символов латинского алфавита, содержать как минимум одну заглавную букву, одну строчную букву, одну цифру, один специальный символ и иметь длину не менее 8 символов. Кнопка регистрации не доступна до заполнения всех полей и прекращения редактирования. Если какое-то требование не выполнено, пользователь получает сообщение с указанием, что не так. 

При завершении регистрации происходит переход на основной экран. Сразу при переходе на основной экран пользователь получает сообщение об успешной регистрации. В верхней части основного экрана располагается кнопка “Приветствие” (при нажатии на которую пользователь получает сообщение с приветствием по имени, указанном при регистрации). Ниже располагается UITableView, который выводит список всех конкурсов, полученных с https://kontests.net/api. В ячейке два лейбла: название и временной интервал конкурса. При нажатии на ячейку модально открывается URL страница конкурса. 
