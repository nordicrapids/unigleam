module ApplicationHelper
  def flash_class(level)
    case level
    when "notice" then "alert alert-info"
    when "success" then "alert alert-success"
    when "error" then "alert alert-danger"
    when "alert" then "alert alert-danger"
    end
  end

  # add tr field
  def link_to_add_tr_field(name, f, association, table_id)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, :child_index => id) do |builder|
      render("shared/"+association.to_s.singularize + "_fields", :f => builder)
    end
    link_to(name.html_safe, '#', id: "add_tr_fields", data: {id: id, fields: fields.gsub("\n", ""), table_id: table_id}, class: "btn btn-info btn-sm add_tr_fields", style: "margin-top: 10px")
  end

  # remove tr field
  def link_to_remove_tr_field(name, style_class, f)
    f.hidden_field(:_destroy) + link_to_function(name, :class => "link_to_remove_field #{style_class}")
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert alert-success fade in theme-font text-center") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

end
