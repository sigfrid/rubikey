require 'spec_helper'

describe "OPT" do 

  context 'when initialization succeeded' do
    let(:opt) { Rubikey::OTP.new('enrlucvketdlfeknvrdggingjvrggeffenhevendbvgd', '4013a2c719c4e9734bbc63048b00e16b') }
         
    it "has the expected unique passcode" do
      expect(opt.unique_passcode).to eq('feknvrdggingjvrggeffenhevendbvgd')
    end
   
    it "has the expected public yubikey id" do
      expect(opt.yubikey_id).to eq('enrlucvketdl')
    end
  
    it "has the expected secret_id" do
      expect(opt.secret_id).to eq('912a644bbc7b')
    end
  
    it "has the expected insert_counter" do
      expect(opt.insert_counter).to eq(1)
   end
  end
  
  context 'when initialization failes' do
    subject(:unique_passcode) { 'hknhfjbrjnlnldnhcujvddbikngjrtgh' }
    let(:secret_key) { 'ecde18dbe76fbd0c33330f1c354871db' }  
  
    it 'raises InvalidPasscode if passcode is not modified hexadecimal' do
      expect{ Rubikey::OTP.new(secret_key, secret_key) }.to raise_error(Rubikey::InvalidPasscode)
    end
    
    it 'raises InvalidPasscode if passcode is not at least 32 chararcters long' do
      expect{ Rubikey::OTP.new(unique_passcode[0,31], secret_key) }.to raise_error(Rubikey::InvalidPasscode)
    end
    
    it 'raises InvalidKey if key is not hexadecimal' do
      expect{ Rubikey::OTP.new(unique_passcode, unique_passcode) }.to raise_error(Rubikey::InvalidKey)
    end
    
    it 'raises InvalidPasscode if key is not 32 chararcters long' do
      expect{ Rubikey::OTP.new(unique_passcode, secret_key[0,31]) }.to raise_error(Rubikey::InvalidKey)
    end
     
    it 'raises BadRedundancyCheck if CRC is invalid' do
      expect{ Rubikey::OTP.new(unique_passcode[1,31]+'d', secret_key) }.to raise_error(Rubikey::BadRedundancyCheck)
    end
  end
end
