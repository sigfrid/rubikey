# encoding: US-ASCII 

require 'spec_helper'

describe "Encode" do 
   using Rubikey::Encode

    it 'converts binary to hexadecimal' do
      expect("i\266H\034\213\253\242\266\016\217\"\027\233X\315V".to_hexadecimal).to eq('69b6481c8baba2b60e8f22179b58cd56')
    end

    it 'converts hexadecimal to binary' do
      expect('69b6481c8baba2b60e8f22179b58cd56'.to_binary).to eq("i\266H\034\213\253\242\266\016\217\"\027\233X\315V")
    end

    it 'detects if a string is hexadecimal' do
      expect('ecde18dbe76fbd0c33330f1c354871db'.is_hexadecimal?).to be_true
    end

    it 'detects if a string is  not hexadecimal' do
      expect('foobar'.is_hexadecimal?).to be_false
    end

    it 'detects if a string is modified hexadecimal' do
      expect('dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh'.is_modified_hexadecimal?).to be_true
    end

     it 'detects if a string is not modified hexadecimal' do
      expect('test'.is_modified_hexadecimal?).to be_false
    end
end
