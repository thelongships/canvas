x class CreateKthavatars < ActiveRecord::Migration
tag :predeploy

  def self.up
    create_table :kthavatars do |t|
      t.string :name
      t.string :type
      t.string :path
      t.boolean :taken
      t.timestamps
    end
  end

  def self.down
    drop_table :kthavatars
  end
end
