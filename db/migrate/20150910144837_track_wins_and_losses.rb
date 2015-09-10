class TrackWinsAndLosses < ActiveRecord::Migration


  def change
  #where changes are defined for migration
    create_table(:scoreboard) do |t|
      t.column :name,  :string, limit: 20
      t.column :score, :integer
    end
  end

end
