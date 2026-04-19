module ButtonsHelper
  def lte_button_to(options)
    classes = %w[btn btn-sm]
    classes << (options[:bg_class].presence || 'btn-default')

    options[:text] ||= ''
    options[:path] ||= '#'

    html_opts = { class: classes.join(' ') }
    html_opts[:method] = options[:method] if options[:method].present?

    link_to(options[:text], options[:path], html_opts)
  end

  def draw_edit_button(options)
    classes = %i[btn btn-sm btn-primary]
    classes << 'disabled' if options[:disabled].present?

    link_to(icon('fas', 'edit', 'Редактировать'), options[:path], class: classes.join(' '))
  end

  def draw_back_button(options)
    classes = %i[btn btn-sm btn-secondary]
    classes << 'disabled' if options[:disabled].present?
    classes << options[:class].split(/\s+/) if options[:class].present?

    link_to(icon('fas', 'arrow-left', 'Назад'), options[:path], class: classes.join(' '))
  end

  def draw_delete_button(options)
    classes = %i[btn btn-sm btn-danger]
    classes << 'disabled' if options[:disabled].present?

    options[:confirm_text] ||= 'Вы уверены?'
    link_to(
      icon('fas', 'trash-alt', 'Удалить'),
      options[:path],
      data: { turbo_confirm: options[:confirm_text], turbo_method: :delete },
      class: classes.join(' ')
    )
  end

  def draw_save_button(options = {})
    # для кнопки за пределами формы необходимы параметры type="button", onclick="submit()", form="form_name"
    classes = %w[btn btn-sm border-0 btn-success]
    classes << 'disabled' if options[:disabled].present?

    html_options = {
      type: options[:type] || 'submit',
      class: classes.join(' '),
      name: options[:name] || 'button'
    }
    html_options[:form] = options[:form] if options[:form].present?
    html_options[:id] = options[:id] if options[:id].present?
    html_options[:onclick] = options[:onclick] if options[:onclick].present?

    content_tag(:button, icon('fas', 'save', 'Сохранить'), html_options)
  end

  def draw_new_button(options)
    classes = %w[btn btn-sm]
    classes << 'disabled' if options[:disabled].present?

    classes << (options[:bg_class].presence || 'btn-outline-primary')

    class_prop = classes.join(' ')
    options[:label] ||= 'Добавить'
    options[:icon] ||= 'plus'

    btn_content = icon('fas', options[:icon], options[:label])

    if options[:button].present?
      link_to(options[:path]) do
        content_tag(:button, btn_content, type: 'button', class: class_prop)
      end
    else
      link_to(btn_content, options[:path], class: class_prop)
    end
  end

  def draw_restore_button(options)
    classes = %i[btn btn-sm btn-warning]
    classes << 'disabled' if options[:disabled].present?
    classes << options[:class].split(/\s+/) if options[:class].present?

    link_to(icon('fas', 'trash-restore', 'Восстановить'), options[:path], class: classes.join(' '),
                                                                             data: { turbo_method: :post })
  end
end
