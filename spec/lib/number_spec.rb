require_relative '../spec_helper'
require_relative '../../lib/number.rb'

describe Foobar do
  it 'should add two numbers together' do
    number_calc = Foobar.new
    two = number_calc.add_numbers(1, 1)

    expect(two).to eq(2)
  end
end
