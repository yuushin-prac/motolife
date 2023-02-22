class RenameTypeColumnToArticle < ActiveRecord::Migration[7.0]
  def change
    rename_column :articles, :type, :category
  end
end
