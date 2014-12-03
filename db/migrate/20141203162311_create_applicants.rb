class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :form
      t.text :params

      t.timestamps
    end
  end
end
