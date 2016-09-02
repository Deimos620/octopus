class CreateBlogHolidays < ActiveRecord::Migration
  def change
    create_table :blog_holidays do |t|
      t.integer :editor_user_id, default: 1
      t.string :name
      t.text :about
      t.string :url
      t.string :month
      t.string :date
      t.string :category, default: "day"
      t.boolean :by_day_of_week, default: false

      t.string :day_of_week
      t.string :by_day_of_week_description

      t.integer :rank, default: 1000
      t.integer :week_number
      t.string :tag

      t.timestamps null: false

    end
  end
end
