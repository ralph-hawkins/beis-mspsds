module NotificationProperties
  extend ActiveSupport::Concern

  include NotificationTypes
  include NotificationCategories
  include NotificationFrameFormulations
  include NotificationTriggerRules
  include NotificationUnits
  include NotificationExposures
  include NotificationPhysicalForms
  include NotificationSpecialApplicators
end
