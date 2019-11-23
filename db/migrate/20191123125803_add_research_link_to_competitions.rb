class AddResearchLinkToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :research_link, :string
  end
end
