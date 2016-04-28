module ApplicationHelper
  def lazy_image_resource(model, uploader=:image, version=nil, options={})
    url = version.present? ? model.send(uploader)&.send(version)&.url : model.send(uploader)&.url

    options.tap do |h|
      h[:"data-original"] = url
      h[:class] = "lazy #{h[:class]}"
    end

    padding = "padding-bottom: #{model.aspect_ratio.present? ? 100.0 / model.aspect_ratio : 100}%;"

    content_tag :div, class: "lazy_image_wrapper clearfix", style: padding do
      concat image_tag('grey.gif', options)
    end
  end
end
