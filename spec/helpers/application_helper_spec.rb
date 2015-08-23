require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#sidebar_categories' do
    it 'returns all categories' do
      categories = create_list(:category, 5)
      expect(sidebar_categories).to eq categories
    end
  end

  describe '#full_title' do
    it 'returns a full title with arg' do
      expect(full_title('Page name')).to eq 'Bookstore · Page name'
    end

    it 'returns a shop name' do
      expect(full_title('')).to eq 'Bookstore'
    end
  end
end
