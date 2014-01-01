require 'spec_helper'

describe "StringExtensions" do 
  using Rubikey::StringExtensions
   
  it 'strips prefix keeping last 32 chars' do
    expect('abcd12345678901234567890123456789012'.strip_prefix).to eq('12345678901234567890123456789012')
  end
  
  it 'extracts the first 12 chars as key identifier' do
    expect('12345678901234567890123456789012'.key_identifier).to eq('123456789012')
  end
end
