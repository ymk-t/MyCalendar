class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.time :start
      t.time :end
      t.boolean :allday

      t.timestamps
    end
  end
end
