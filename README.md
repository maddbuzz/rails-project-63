[![Actions Status](https://github.com/maddbuzz/rails-project-63/actions/workflows/CI.yml/badge.svg)](https://github.com/maddbuzz/rails-project-63/actions/workflows/CI.yml)
[![Actions Status](https://github.com/maddbuzz/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/maddbuzz/rails-project-63/actions/workflows/hexlet-check.yml)
[![Actions Status](https://github.com/maddbuzz/rails-project-63/actions/workflows/main.yml/badge.svg)](https://github.com/maddbuzz/rails-project-63/actions/workflows/main.yml)

# Генератор форм

Библиотека, с помощью которой удобно создавать формы в шаблонах сайтов. Позволяет сократить код описания формы во много раз за счет автоматической обработки ошибок и различных контролов.

## Как использовать

```ruby
# Создаем класс User с полями name, job и gender:
User = Struct.new(:name, :job, :gender, keyword_init: true)

# Создаем конкретно пользователя и заполняем поля:
user = User.new name: 'rob', job: 'hexlet', gender: 'm'

# Дальше этот пользователь используется для генерации HTML формы:
HexletCode.form_for user do |f|
  f.input :name
  f.input :job, as: :text
  f.submit
end
=>
# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input name="name" type="text" value="rob">
#   <label for="job">Job</label>
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
#   <input type="submit" value="Save">
# </form>
```

Для полей можно указать дополнительные атрибуты в виде хеша последним параметром:

```ruby
HexletCode.form_for user, url: '#' do |f|
  f.input :name, class: 'user-input'
  f.input :job
end
=>
# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input name="name" type="text" value="rob" class="user-input">
#   <label for="job">Job</label>
#   <input name="job" type="text" value="hexlet">
# </form>
```

У полей могут быть дефолтные значения, которые можно переопределить:

```ruby
HexletCode.form_for user do |f|
  f.input :job, as: :text, rows: 30, cols: 30
  f.submit
end
=>
# <form action="#" method="post">
#   <label for="job">Job</label>
#   <textarea name="job" cols="30" rows="30">hexlet</textarea>
#   <input type="submit" value="Save">
# </form>
```

По умолчанию метод submit() использует как имя кнопки значение 'Save', но его можно переопределить передав первым аргументом нужный текст. Генератор может принимать url, тогда он будет использован в качестве адреса при отправке формы:

```ruby
HexletCode.form_for user, url: '/users' do |f|
  f.input :job, as: :text, rows: 50, cols: 50
  f.submit 'Wow'
end
=>
# <form action="/users" method="post">
#   <label for="job">Job</label>
#   <textarea name="job" cols="50" rows="50">hexlet</textarea>
#   <input type="submit" value="Wow">
# </form>
```

Возможно и изменять/добавлять атрибуты формы:

```ruby
HexletCode.form_for @user, url: '/profile', method: :get, class: 'hexlet-form', &:submit
=>
# <form action="/profile" method="get" class="hexlet-form">
#   <input type="submit" value="Save">
# </form>
```

## Install dependencies

```sh
make install
```

## Run linter

```sh
make lint
```

## Run tests

```sh
make test
```
