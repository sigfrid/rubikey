require 'spec_helper'

describe "OPT" do 
  using Rubikey::StringExtensions

  context 'when initialization succeeded' do
    let(:opt) { Rubikey::OTP.new('enrlucvketdlfeknvrdggingjvrggeffenhevendbvgd') }
            
    it "has the expected unique passcode" do
      expect(opt.unique_passcode).to eq('enrlucvketdlfeknvrdggingjvrggeffenhevendbvgd')
    end
  end
  
  context 'when initialization failes' do
    subject(:unique_passcode) { 'hknhfjbrjnlnldnhcujvddbikngjrtgh' }
    
    context 'raises InvalidPasscode when' do
      it 'passcode is not modified hexadecimal' do
        expect{ Rubikey::OTP.new(unique_passcode + 'a') }.to raise_error(Rubikey::InvalidPasscode)
      end
      
      it 'passcode is not at least 32 chararcters long' do
        expect{ Rubikey::OTP.new(unique_passcode.last(31)) }.to raise_error(Rubikey::InvalidPasscode)
      end
    end
  end
end
