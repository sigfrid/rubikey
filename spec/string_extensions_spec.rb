require 'spec_helper'

describe "StringExtensions" do 
  using Rubikey::StringExtensions
   
  it 'returns first n chars' do
    expect('abcd12345678901234567890123456789012'.last(32)).to eq('12345678901234567890123456789012')
  end
  
  it 'returns last n chars' do
    expect('12345678901234567890123456789012'.first(12)).to eq('123456789012')
  end
end
