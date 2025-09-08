# Синтаксис
| Ключові слова   | Українською                     | Опис                                                                                                                                                                                                            |
|-----------------|---------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Story (Feature) | Історія                         | Кожна нова специфікація починається з цього ключового слова, після якого через двокрапку в умовній формі пишеться ім'я історії.                                                                                 |
| As a            | Як (у ролі)                     | Роль тієї особи у бізнес-моделі, якій дана функціональність цікава.                                                                                                                                             |
| In order to     | Щоб досягти                     | У стислій формі які цілі переслідує особа.                                                                                                                                                                      |
| I want to       | Я хочу щоб                      | У короткій формі описується кінцевий результат.                                                                                                                                                                 |
| Scenario        | Сценарій                        | Кожен сценарій однієї історії починається з цього слова, після якого через двокрапку пишеться мета сценарію. Якщо сценаріїв однієї історії кілька, то після ключового слова має писатися його порядковий номер. |
| Given           | Дано                            | Початкова умова. Якщо початкових умов є кілька, то кожна нова умова додається з нового рядка за допомогою ключового слова And.                                                                                  |
| When            | Коли (прим.: щось відбувається) | Подія, яка ініціює цей сценарій. Якщо подію не можна розкрити однією пропозицією, всі наступні деталі розкриваються через ключові слова And та But.                                                             |
| Then            | Тоді                            | Результат, який користувач повинен спостерігати зрештою. Якщо результат не можна розкрити однією пропозицією, всі наступні деталі розкриваються через ключові слова And і But.                                  |
| And             | Та                              | Допоміжне ключове слово, аналог кон'юнкції.                                                                                                                                                                     |
| But             | Але                             | Допоміжне ключове слово, аналог заперечення.                                                                                                                                                                    |

# Приклад

**<span style="color: green;">Story**: Returns go to stock<br>
<br>
**<span style="color: green;">As** a store owner<br>
**<span style="color: green;">In order to** keep track of stock<br>
**<span style="color: green;">I want to** add items back to stock when they're returned.<br>
<br>
**<span style="color: green;">Scenario** 1: Refunded items should be returned to stock<br>
**<span style="color: green;">Given** that a customer previously bought a black sweater from me<br>
**<span style="color: green;">And** I have three black sweaters in stock.<br>
**<span style="color: green;">When** they return the black sweater for a refund<br>
**<span style="color: green;">Then** I should have four black sweaters in stock.<br>
<br>
**<span style="color: green;">Scenario** 2: Replaced items should be returned to stock<br>
**<span style="color: green;">Given** that a customer previously bought a blue garment from me<br>
**<span style="color: green;">And** I have two blue garments in stock<br>
**<span style="color: green;">And** three black garments in stock.<br>
**<span style="color: green;">When** they return the blue garment for a replacement in black<br>
**<span style="color: green;">Then** I should have three blue garments in stock<br>
**<span style="color: green;">And** two black garments in stock.<br>
