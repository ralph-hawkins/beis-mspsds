module ActivityHelper
  def activity_types
    base_types = {
      "comment": "Add a comment",
      "email": "Record email",
      "phone_call": "Record phone call",
      "meeting": "Record meeting",
      "testing_request": "Record testing request",
      "testing_result": "Record test result",
      "corrective_action": "Record corrective action",
      "product": "Add a product to the case",
      "business": "Add a business to the case"
    }
    if @investigation.is_private
      base_types["visibility"] = "Unrestrict this case"
    elsif @investigation.visible_to(user: current_user, private: true)
      base_types["visibility"] = "Restrict this case for legal privilege"
    end
    base_types
  end
end
