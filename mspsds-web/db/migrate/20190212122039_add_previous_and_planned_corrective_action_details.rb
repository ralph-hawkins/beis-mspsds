class AddPreviousAndPlannedCorrectiveActionDetails < ActiveRecord::Migration[5.2]
  def change
    safety_assured do
      change_table :investigations, bulk: true do |t|
        t.text :previous_corrective_action_description
        t.text :planned_corrective_action_description
      end
    end
  end
end
