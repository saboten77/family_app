class CreateTaskLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :task_logs do |t|
      t.references :task, null: false, foreign_key: true
      t.references :family_member, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
