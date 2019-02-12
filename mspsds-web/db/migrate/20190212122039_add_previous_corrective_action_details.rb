class AddPreviousCorrectiveActionDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :investigations, :previous_corrective_actions_description, :string
  end
end
