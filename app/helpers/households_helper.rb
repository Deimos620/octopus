module HouseholdsHelper

  def household_status_label(status)
    label_kind = translate_label(status)
    content_tag(:span, status.to_s.capitalize, class: "client_status label label-#{label_kind}")
  end

  def translate_label(status)
    return unless status
    case status
    when "pending_join"
      "warning"
    when "pending_split"
      "warning"
    when "finalized"
      "success"
    end
  end
      
end
