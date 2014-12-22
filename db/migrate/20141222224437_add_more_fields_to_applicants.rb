class AddMoreFieldsToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :address, :string
    add_column :applicants, :city, :string
    add_column :applicants, :state, :string
    add_column :applicants, :zip_code, :string
    add_column :applicants, :contact_details, :string
  end
end
