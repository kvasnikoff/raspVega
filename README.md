# raspVega
Schedule for students of base department №536 at MIREA University

## Process of developing 
### Part 1. Analysis of requirements
(can be founded in **requirementsAnalysis.docx**)
![image](/contentsOfRequirements.png)

### Writing the code. Demo

<img src="/raspVega.gif?raw=true" width="450px">

При самом первом запуске спрашиваем, из какой группы и запоминаем. Потом, даже если выгружаем из памяти, он открывает уже сразу расписание выбранной группы (используется UserDefaults). Есть кнопка просмотра полного расписания. Работает поиск. Из него можно посмотреть расписание любой группы. Есть возможность изменить текущую группу. После этого безо всяких перезагрузок сразу пишется новая выбранная группа и расписание выводится актуальное (реализовано обновление предыдущего ViewController через протокол).

**UPD:** в поиск теперь не чувствителен к регистру (реализовано через uppercased(), учитываются четные/нечетные недели в расписании
