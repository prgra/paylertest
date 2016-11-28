class CreateIps < ActiveRecord::Migration[5.0]
  def change
    create_table :ips do |t|
      t.string :ip
      t.integer :country

      t.timestamps
    end
  end
end
