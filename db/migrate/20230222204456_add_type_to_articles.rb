class AddTypeToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :type, :integer, default: 0
  end
end
