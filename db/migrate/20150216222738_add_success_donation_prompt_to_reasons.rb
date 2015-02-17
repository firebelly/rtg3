class AddSuccessDonationPromptToReasons < ActiveRecord::Migration
  def change
    add_column :reasons, :success_donation_prompt, :string
  end
end
