# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'display' do
    it 'raises on strings' do
      expect { helper.display('foobar') }.to raise_error(NoMethodError)
    end

    it 'renders nil as 0c' do
      expect(helper.display(nil)).to eq '0c'
    end

    sizes.each do |size|
      it "displays a #{size} number" do
        expect(helper.display(currency(size))).to eq(currency_string(size))
      end
    end

    sizes.without('zero').each do |size|
      it "displays a #{size} negative number" do
        expect(helper.display(-currency(size))).to eq("-#{currency_string(size)}")
      end
    end
  end
end
