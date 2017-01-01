# encoding:utf-8

require 'spec_helper'

describe Parser::XinShang do
  let(:list_1) do 
    open(File.expand_path('../pages/xinshangs/list_1.html', __FILE__)).read
  end

  let(:parser) do 
    Parser::XinShang.new
  end

  it 'parse list page' do
    entries = parser.parse_list_page(list_1)
    
    expect(entries.length).to eq(50)

    entry = entries.first
    expect(entry[:link]).to eq('http://91xinshang.com/xianzhi/1194044.html')
    expect(entry[:img]).to eq("http://img.91sph.com/goods/20161220/5099554b-6e01-4e35-888c-4e8f648adfaa_s1.jpg")
    expect(entry[:s_id]).to eq("1194044")
    expect(entry[:chengshe]).to eq("全新")
    expect(entry[:brand]).to eq("SWAROVSKI")
    expect(entry[:des]).to eq("SWAROVSKI施华洛世奇铃铛圣诞钟挂饰")
    expect(entry[:price]).to eq("550")
    expect(entry[:original_price]).to eq("850")
  end
end
