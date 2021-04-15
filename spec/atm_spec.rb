require_relative '../lib/atm'
require 'date'

describe Atm do
  let(:account) { instance_double('Account') }
  before do
    allow(account).to receive(:balance).and_return(100)
    allow(account).to receive(:balance=)
end
    
    it 'is expected to be an instance of Atm' do
        expect(subject.class).to eq Atm
    end

    it 'has 1000$ on initialize' do
        expect(subject.funds).to eq 1000
    end
    
    it 'funds are reduced at withdraw' do
        subject.withdraw(50)
        expect(subject.funds).to eq 950
    end

    it 'allow withdraw if the account has enough balance.' do
      expected_output = { status: true, message: 'success', date: Date.today, amount: 45}
      expect(subject.withdraw(45,account)).to eq expected_output
  end

end
