class AuditActivity::Image::Update < AuditActivity::Image::Base
  def self.from(image, investigation, previous_data)
    return if self.no_change?(image, previous_data)

    if self.title_changed?(image, previous_data)
      title = "Updated: #{image.metadata[:title] || 'Untitled image'} (was: #{previous_data[:title] || 'Untitled image'})"
    elsif self.description_changed?(image, previous_data)
      title = "Updated: Description for #{image.metadata[:title]}"
    end
    super(image, investigation, title)
  end

  def subtitle_slug
    "Image details updated"
  end

  def self.no_change?(image, previous_data)
    image.metadata[:title] == previous_data[:title] && image.metadata[:description] == previous_data[:description]
  end

  def self.title_changed?(image, previous_data)
    image.metadata[:title] != previous_data[:title]
  end

  def self.description_changed?(image, previous_data)
    image.metadata[:description] != previous_data[:description]
  end
end