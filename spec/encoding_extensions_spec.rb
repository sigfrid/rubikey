# encoding: US-ASCII 

require 'spec_helper'

describe "EncodingExtensions" do 
  using Rubikey::EncodingExtensions
   
  context 'converts' do
    it 'hexadecimal to binary' do
      expect('69b6481c8baba2b60e8f22179b58cd56'.hexadecimal_to_binary).to eq("i\266H\034\213\253\242\266\016\217\"\027\233X\315V")
    end
    
    it 'modified hexadecimal to binary' do
      expect('dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh'.modified_hexadecimal_to_binary).to eq("-4N\x83i\xB6H\x1C\x8B\xAB\xA2\xB6\x0E\x8F\"\x17\x9BX\xCDV")
    end
      
    it 'binary to hexadecimal' do
      expect("i\266H\034\213\253\242\266\016\217\"\027\233X\315V".binary_to_hexadecimal).to eq('69b6481c8baba2b60e8f22179b58cd56')
    end
      
    it 'binary to modified hexadecimal' do
      expect("-4N\x83i\xB6H\x1C\x8B\xAB\xA2\xB6\x0E\x8F\"\x17\x9BX\xCDV".binary_to_modified_hexadecimal).to eq('dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh')
    end
  end

  context 'detects' do
    it 'when a string is hexadecimal' do
      expect('ecde18dbe76fbd0c33330f1c354871db'.is_hexadecimal?).to be_true
    end

    it 'when a string is  not hexadecimal' do
      expect('foobar'.is_hexadecimal?).to be_false
    end

    it 'when a string is modified hexadecimal' do
      expect('dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh'.is_modified_hexadecimal?).to be_true
    end

     it 'when a string is not modified hexadecimal' do
      expect('test'.is_modified_hexadecimal?).to be_false
    end
    
    context 'before converting to binary' do
      it 'when modified hexadecimal length is not even' do
         expect{'dteffujehknhfjbrjnlnldnhcujvddbikngjrtg'.modified_hexadecimal_to_binary}.to raise_error(ArgumentError)
      end

      it 'when a string is modified hexadecimal' do
         expect{'test'.modified_hexadecimal_to_binary}.to raise_error(ArgumentError)
      end
    end
  end
end
