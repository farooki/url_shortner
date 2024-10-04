class CreateUrlShortners < ActiveRecord::Migration[7.2]
  def change
    create_table :url_shortners do |t|
      t.string :given_url, null: false
      t.string :generated_url, null: false
      t.integer :frequency, null: false, default: 0
      t.string :title

      t.timestamps
    end

    add_index :url_shortners, :generated_url
  end
end
