class AddDonationPromptToReasons < ActiveRecord::Migration
  def change
    add_column :reasons, :donation_prompt, :string
  end
end
