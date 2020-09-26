class CreateUserInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :user_infos do |t|
      t.text       :text,              null: false
      t.integer    :people_num_id,     null: false
      t.integer    :area_id,           null: false
      t.references :user,              foreign_key: true

      t.timestamps
    end
  end
end
