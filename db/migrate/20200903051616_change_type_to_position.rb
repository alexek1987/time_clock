class ChangeTypeToPosition < ActiveRecord::Migration[6.0]
  def change
    rename_column :jobs, :type, :position
  end
end
