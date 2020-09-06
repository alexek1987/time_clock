class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
