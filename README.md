## Typst титульник

[Typst](https://typst.app/) шаблоны для сдачи работ в НГТУ. Просто скачайте и запихайте содержимое папки `nstu_template` в корень проекта.

`main.typ` в таком случае может выглядеть как-то так:

```typst
#import "nstu_template//template.typ": * // Импорт шаблона

// Пример конфигурации
// (многие параметры здесь не обязательны)
#show: project.with(
  faculty: "АВТФ", // или ФПМИ, кому что нравится
  department: "Кафедра теоретических и прикладных приколов",
  discipline: "Численное поедание пельменей",
  task_type: "Практическое задание №1",
  task_name: "Интегрирование дамплингов по поверхности",
  students: (
    "Гаррье Дюбуа",
    "Ким Кицураги"
  ),
  teachers: ("Фамили Имя Отчество"),
  variant: "12",
  group: "УЭ-00",
  team: "3",
  year: "2023",
)

// Здесь и далее пишем отчёт

```

Как это выглядит, можете посмотреть [здесь](example.pdf).

Используемые шрифты: [Raleway](https://fonts.google.com/specimen/Raleway) и [Fira Code](https://github.com/tonsky/FiraCode).
