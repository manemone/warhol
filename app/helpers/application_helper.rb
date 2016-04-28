module ApplicationHelper
  def lazy_image_resource(model, version, options={})
    options.tap do |h|
      h[:"data-original"] = model.send(version)&.url
      h[:class] = "lazy #{h[:class]}"
    end

    padding = "padding-bottom: #{model.aspect_ratio.present? ? 100.0 / model.aspect_ratio : 100}%;"

    content_tag :div, class: "lazy_image_wrapper clearfix", style: padding do
      concat image_tag('grey.gif', options)
    end
  end
end
