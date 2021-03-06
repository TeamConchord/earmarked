module ApplicationHelper

  def validate_params
    params[:donation][:amount].to_i > 0
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", errors: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def bootstrap_icon_for flash_type
    { success: "ok", errors: "remove-circle", alert: "warning-sign", notice: "exclamation-sign" }[flash_type.to_sym] || "question-sign"
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat content_tag(:i, nil, class: "glyphicon glyphicon-#{bootstrap_icon_for(msg_type)}")
        concat message
        end)
      end
    nil
  end
end
