require 'spec_helper'

describe "KeyConfig" do 

  context 'when initialization succeeded' do
    let(:key_config) { Rubikey::KeyConfig.new('enrlucvketdlfeknvrdggingjvrggeffenhevendbvgd', '4013a2c719c4e9734bbc63048b00e16b') }
            
    it "has the expected public yubikey id" do
      expect(key_config.public_id).to eq('enrlucvketdl')
    end
  
    it "has the expected secret yubikey id" do
      expect(key_config.secret_id).to eq('912a644bbc7b')
    end
  
    it "has the expected insert counter" do
      expect(key_config.insert_counter).to eq(1)
   end
  end
  
  context 'when initialization failes' do
    subject(:unique_passcode) { 'hknhfjbrjnlnldnhcujvddbikngjrtgh' }
    let(:secret_key) { 'ecde18dbe76fbd0c33330f1c354871db' }  
    
    context 'raises InvalidKey when' do
      it 'key is not hexadecimal' do
        expect{ Rubikey::KeyConfig.new(unique_passcode, unique_passcode) }.to raise_error(Rubikey::InvalidKey)
      end
      
      it 'key is not 32 chararcters long' do
        expect{ Rubikey::KeyConfig.new(unique_passcode, secret_key[0,31]) }.to raise_error(Rubikey::InvalidKey)
      end
    end

    context 'raises BadRedundancyCheck when' do
      it 'CRC is invalid' do
        expect{ Rubikey::KeyConfig.new(unique_passcode[1,31]+'d', secret_key) }.to raise_error(Rubikey::BadRedundancyCheck)
      end
    end
  end
end
