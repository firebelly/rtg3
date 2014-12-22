class AddExtraFieldsToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :subject, :string
    add_column :applicants, :message, :text
  end
end
