Story: Returns go to stock

As a store owner
In order to keep track of stock
I want to add items back to stock when they're returned.

Scenario 1: Refunded items should be returned to stock
Given that a customer previously bought a black sweater from me
And I have three black sweaters in stock.
When they return the black sweater for a refund
Then I should have four black sweaters in stock.

Scenario 2: Replaced items should be returned to stock
Given that a customer previously bought a blue garment from me
And I have two blue garments in stock
And three black garments in stock.
When they return the blue garment for a replacement in black
Then I should have three blue garments in stock
And two black garments in stock.

| Ключові слова   | Українською                     | Опис                                                                                                                                                                                                                            |
|-----------------|---------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Story (Feature) | Історія                         | Кожна нова специфікація починається з цього ключового слова, після якого через двокрапку в умовній формі пишеться ім'я історії.                                                                                                 |
| As a            | Як (у ролі)                     | Роль тієї особи у бізнес-моделі, якій дана функціональність цікава.                                                                                                                                                             |
| In order to     | Щоб досягти                     | У стислій формі які цілі переслідує обличчя.                                                                                                                                                                                    |
| I want to       | Я хочу щоб                      | У короткій формі описується кінцевий результат.                                                                                                                                                                                 |
| Scenario        | Сценарій                        | Кожен сценарій однієї історії починається з цього слова, після якого через двокрапку у умовній формі пишеться мета сценарію. Якщо сценаріїв однієї історії кілька, то після ключового слова має писатися його порядковий номер. |
| Given           | Дано                            | Початкова умова. Якщо початкових умов є кілька, то кожна нова умова додається з нового рядка за допомогою ключового слова And.                                                                                                  |
| When            | Коли (прим.: щось відбувається) | Подія, яка ініціює цей сценарій. Якщо подію не можна розкрити однією пропозицією, всі наступні деталі розкриваються через ключові слова And і But.                                                                              |
| Then            | Тоді                            | Результат, який користувач повинен спостерігати зрештою. Якщо результат не можна розкрити однією пропозицією, всі наступні деталі розкриваються через ключові слова And і But.                                                  |
| And             | Та                              | Допоміжне ключове слово, аналог кон'юнкції.                                                                                                                                                                                     |
| But             | Але                             | Допоміжне ключове слово, аналог заперечення.                                                                                                                                                                                    |