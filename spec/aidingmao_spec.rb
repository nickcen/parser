# encoding:utf-8

require 'spec_helper'

describe Parser::Aidingmao do
  let(:list_1) do 
    open(File.expand_path('../pages/aidingmaos/list_1.html', __FILE__)).read
  end

  let(:parser) do 
    Parser::Aidingmao.new
  end

  it 'parse list_1 page' do
    entries = parser.parse_list_page(list_1)
    
    expect(entries.length).to eq(80)

    entry = entries.first
    expect(entry[:link]).to eq('http://www.aidingmao.com/detail/03148379637698200094.html')
    expect(entry[:img]).to eq("http://static1.aidingmao.com/java/image/jpeg/0_1483796376379_1056.jpg?imageView2/1/w/300/h/300")
    expect(entry[:chengshe]).to eq("S1")
    expect(entry[:brand]).to eq("BURBERRY")
    expect(entry[:kind]).to eq("丝巾/围巾/披肩")
    expect(entry[:price]).to eq(500)
    expect(entry[:original_price]).to eq(2900)
  end
end
