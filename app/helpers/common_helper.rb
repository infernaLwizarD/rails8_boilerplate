module CommonHelper
  def draw_main_title(options = {})
    options[:title] ||= ''
    options[:size] ||= 1

    content_tag(:section, class: 'content-header') do
      content_tag(:div, class: 'container-fluid') do
        content_tag(:div, class: 'row mb-2') do
          content_tag(:div, content_tag(:"h#{options[:size]}", options[:title]), class: 'col-sm-6') +
            content_tag(:div, nil, class: 'col-sm-6')
        end
      end
    end
  end

  def checkbox_val(object, options = {})
    if object.present?
      if options[:yn_format].present?
        'Да'
      else
        icon('fas', 'check')
      end
    elsif options[:yn_format].present?
      'Нет'
    else
      icon('fas', 'times')
    end.html_safe
  end

  def serialized_array(array, options = {})
    options[:prefix] ||= ''
    array&.collect { |i| "#{options[:prefix]}#{i}" }&.join("\n")
  end

  def truncate_str(str, length = 21)
    if str.length > length
      "#{str.slice(0, length).strip}..."
    else
      str
    end
  end
end
