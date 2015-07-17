require 'rails_helper'

RSpec.describe "pages/about.html.haml", type: :view do
  it 'has "About" header' do
    render
    expect(rendered).to have_css 'h2', text: 'About'
  end
end
