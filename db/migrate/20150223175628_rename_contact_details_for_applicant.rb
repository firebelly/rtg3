class RenameContactDetailsForApplicant < ActiveRecord::Migration
  def change
  	rename_column :applicants, :contact_details, :contact_preference
  end
end
