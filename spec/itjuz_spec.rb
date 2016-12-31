# encoding:utf-8

require 'spec_helper'

describe Parser::ITJuzi do
  let(:list_1) do 
    open(File.expand_path('../pages/itjuzis/list_1.htm', __FILE__)).read
  end

  let(:parser) do 
    Parser::ITJuzi.new
  end

  it 'parse list page' do
    entries = parser.parse_list_page(list_1)
    
    expect(entries.length).to eq(10)

    entry = entries.first
    expect(entry[:img]).to eq("https://cdn.itjuzi.com/images/711a3a95b3e563d8238d523a1066da5d.jpg?imageView2/0/w/58/q/100")
    expect(entry[:title]).to eq("AMZCaptain亚马逊船长")
    expect(entry[:des]).to eq("AMZCaptain亚马逊船长是一家专注于亚马逊跨境电商运营工具的平台，帮助卖家提升效率和利润。厦门金蟾云信息科技有限公司旗下产品。")
    expect(entry[:tags]).to eq("电子商务")
    expect(entry[:loca]).to eq("福建")
    expect(entry[:found_date].year).to eq(2016)
    expect(entry[:found_date].month).to eq(9)
    expect(entry[:latest_round]).to eq("种子轮")
  end
end
