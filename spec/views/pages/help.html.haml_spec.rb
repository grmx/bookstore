require 'rails_helper'

RSpec.describe "pages/help.html.haml", type: :view do
  it 'has "Help" header' do
    render
    expect(rendered).to have_css 'h2', text: 'Help'
  end
end
