class Web::HomeController < Web::ApplicationController
  def index
    @current_time = Time.zone.now.strftime('%H:%M:%S')
    @main_title = 'Hotwire Showcase'
    @breadcrumbs = []
    @notifications = []
    @messages = []
  end

  # === Turbo Frames ===

  # Обновление отдельного фрейма — демонстрация независимого обновления части страницы
  def update_frame
    @timestamp = Time.zone.now.strftime('%H:%M:%S')
    @random_quote = random_quote
  end

  # Ленивая загрузка фрейма — turbo_frame_tag src: ... loading: :lazy
  def lazy_frame
    sleep 1 # Имитация медленного запроса
    @weather = { temp: rand(-10..35), condition: %w[Солнечно Облачно Дождь Снег Туман].sample, city: 'Москва' }
  end

  # === Turbo Streams ===

  # Добавление элемента в список (append)
  def stream_append
    @message = { id: SecureRandom.hex(4), text: params[:text].presence || Faker::Lorem.sentence, time: Time.zone.now.strftime('%H:%M:%S') }

    respond_to do |format|
      format.turbo_stream
    end
  end

  # Добавление в начало списка (prepend)
  def stream_prepend
    @notification = { id: SecureRandom.hex(4), text: random_notification, type: %w[success info warning danger].sample, time: Time.zone.now.strftime('%H:%M:%S') }

    respond_to do |format|
      format.turbo_stream
    end
  end

  # Удаление элемента из DOM (remove)
  def stream_remove
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(params[:target_id])
      end
    end
  end

  # Замена содержимого элемента (replace)
  def stream_replace
    current = params[:current].to_i
    delta = params[:value].to_i
    @counter_value = delta.zero? ? 0 : current + delta

    respond_to do |format|
      format.turbo_stream
    end
  end

  # Множественные операции в одном ответе — главная сила Turbo Streams
  def stream_multi
    @time = Time.zone.now.strftime('%H:%M:%S')
    @color = generate_random_color
    @stat_requests = rand(100..9999)
    @stat_users = rand(1..500)
    @stat_uptime = "#{rand(1..99)}д #{rand(0..23)}ч"

    respond_to do |format|
      format.turbo_stream
    end
  end

  # === Turbo Stream формы ===

  # Обработка inline-формы через Turbo Stream
  def stream_form_submit
    @todo = { id: SecureRandom.hex(4), title: params[:title], done: false, time: Time.zone.now.strftime('%H:%M:%S') }

    respond_to do |format|
      format.turbo_stream
    end
  end

  # Переключение состояния todo
  def toggle_todo
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          params[:todo_id],
          partial: 'web/home/demo/todo_item',
          locals: { todo: { id: params[:todo_id], title: params[:title], done: params[:done] == 'true', time: params[:time] } }
        )
      end
    end
  end

  private

  def generate_random_color
    "##{SecureRandom.hex(3)}"
  end

  def random_quote
    [
      'Simplicity is the ultimate sophistication. — Leonardo da Vinci',
      'The best way to predict the future is to invent it. — Alan Kay',
      'Talk is cheap. Show me the code. — Linus Torvalds',
      'First, solve the problem. Then, write the code. — John Johnson',
      'Any fool can write code that a computer can understand. Good programmers write code that humans can understand. — Martin Fowler',
      'Programs must be written for people to read. — Harold Abelson',
      'The only way to go fast, is to go well. — Robert C. Martin'
    ].sample
  end

  def random_notification
    [
      'Новый пользователь зарегистрировался',
      'Сервер перезагружен',
      'Обновление безопасности установлено',
      'Бэкап базы данных завершён',
      'Обнаружена подозрительная активность',
      'Отчёт за неделю сформирован',
      'Лимит запросов почти исчерпан'
    ].sample
  end
end
