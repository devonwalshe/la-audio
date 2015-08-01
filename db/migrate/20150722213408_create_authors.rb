class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.text :image_url
      t.text :bio_text
      t.text :name
      t.text :job_title
      t.text :job_description

      t.timestamps null: false
    end
  end
end
