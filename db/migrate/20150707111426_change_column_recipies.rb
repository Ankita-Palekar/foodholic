class ChangeColumnRecipies < ActiveRecord::Migration
  def change
  	rename_column(:recipies, :methods, :method)
  	change_column(:recipies, :method, :text)
  end
end
