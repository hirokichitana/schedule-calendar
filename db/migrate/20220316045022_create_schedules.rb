class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string      :title,             null: false
      t.text        :content,           null: false
      t.datetime    :start_time,        null: false
      t.datetime    :end_time,          null: false
      t.string      :prefecture,        null: false
      t.string      :city,              null: false
      t.string      :town,              null: false
      t.string      :building_name
      t.timestamps
    end
  end
end
