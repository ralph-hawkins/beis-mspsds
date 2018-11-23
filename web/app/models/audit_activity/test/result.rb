class AuditActivity::Test::Result < AuditActivity::Test::Base
  def self.from(test)
    title = "#{test.result.capitalize} test: #{test.product.name}"
    super(test, title)
  end

  def self.date_label
    "Test date"
  end

  def subtitle_slug
    "Test result recorded"
  end
end