require './lib/volt/javapack'
require 'pry'

$jquery_url = URI('https://code.jquery.com/jquery-2.1.3.js')
$bad_url = URI('https://code.jquery.com/jquery-2.1.3.js.gz')

describe Volt::Javapack::JSGrab do
  let(:javapack_bad) { Volt::Javapack::JSGrab.new($bad_url) }
  let(:javapack) { Volt::Javapack::JSGrab.new($jquery_url) }

  it 'initializes with a grab of the js lib provided' do
    expect(javapack.js).to be_an_instance_of String
    expect(javapack_bad.js).to eq nil
  end
end

describe Volt::Javapack::JSWrite do
  let(:writer) { Volt::Javapack::JSWrite.new 'fiuhgriu' } # obvs real JS code is desired but any string workd
                                                          # for the purpose of this test
  it "can create a component to inject js assets into" do
    writer.create_component('jquery')
    expect(`ls`.include? "volt-jquery").to eq true
  end
end
