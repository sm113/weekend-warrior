class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.string :logo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
