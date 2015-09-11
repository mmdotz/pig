class TrackWinsAndLosses < ActiveRecord::Migration


  def change
  #where changes are defined for migration
    create_table(:scoreboards) do |t|
      t.column :name,  :string, limit: 20
      t.column :wins,  :integer
    end
  end

end
