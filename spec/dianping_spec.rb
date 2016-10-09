# encoding:utf-8

require 'spec_helper'

describe Parser::Dianping do
  let(:list_1) do 
    open(File.expand_path('../pages/dianpings/list_1.htm', __FILE__)).read
  end

  let(:page_1) do 
    open(File.expand_path('../pages/dianpings/page_1.htm', __FILE__)).read
  end

  let(:page_2) do 
    open(File.expand_path('../pages/dianpings/page_2.htm', __FILE__)).read
  end

  let(:page_3) do 
    open(File.expand_path('../pages/dianpings/page_3.htm', __FILE__)).read
  end

  let(:parser) do 
    Parser::Dianping.new
  end

  it 'parse list page' do
    entries = parser.parse_list_page(list_1)
    
    expect(entries.length).to eq(15)

    entry = entries.first
    expect(entry[:id]).to eq("22597828")
    expect(entry[:url]).to eq("http://www.dianping.com/shop/22597828")
    expect(entry[:name]).to eq("V Lines私人教练健身工作室(望京...")

    entry = entries.last
    expect(entry[:id]).to eq("23102460")
    expect(entry[:url]).to eq("http://www.dianping.com/shop/23102460")
    expect(entry[:name]).to eq("表妹香港靓点餐厅(望京店)")
  end

  it 'parse entry page of service' do
    entry = parser.parse_entry_page(page_1)

    expect(entry[:name]).to eq("望京家政公司")
    expect(entry[:address]).to eq("望京西园三区东门312号楼7层(望京宝星园望京soho麒麟社国风北京远洋万和公馆)")
    expect(entry[:tels].length).to eq(2)
    expect(entry[:tels].first).to eq("010-53671322")
    expect(entry[:pic]).to eq("http://qcloud.dpfile.com/pc/XIG1zdgfupiJwEkZxYIUWn_3ygDfv6KtcBh_krSTO0Nc4hmZsrNavuof60sve5BGCjM_FsO3sW809PHY7spB8g.jpg")

    expect(entry[:avg_cost]).to be_nil
    expect(entry[:service]).to eq(7.2)
    expect(entry[:tech]).to eq(7.2)
    expect(entry[:cost_effective]).to eq(7.2)
    expect(entry[:rank]).to eq(3.5)
  end

  it 'parse entry page of training' do
    entry = parser.parse_entry_page(page_2)

    expect(entry[:name]).to eq("有间画舍")
    expect(entry[:address]).to eq("阜通西大街望京合生·麒麟舍1号楼1607(望京SOHO，望京或阜通地铁站步行10分钟)")
    expect(entry[:tels].length).to eq(2)
    expect(entry[:tels].first).to eq("18610384765")
    expect(entry[:pic]).to eq("http://i1.s2.dpfile.com/pc/d575c304542331eb5cffc63ae79ab899(320c240)/thumb.jpg")

    expect(entry[:comment]).to eq(24)
    expect(entry[:effect]).to eq(9.1)
    expect(entry[:tech]).to eq(9.1)
    expect(entry[:enviro]).to eq(9.1)
    expect(entry[:rank]).to eq(5.0)
  end

  it 'parse entry page of service' do
    entry = parser.parse_entry_page(page_3)

    expect(entry[:name]).to eq("染客刺青")
    expect(entry[:address]).to eq("望京街4号，合生麒麟社1号楼209室(近望京soho)")
    expect(entry[:tels].length).to eq(1)
    expect(entry[:tels].first).to eq("13683072252")
    expect(entry[:pic]).to eq("http://i1.s2.dpfile.com/pc/zBcr1SDQfp0Leom8h5Qr7sxUW13E_IRJKwTlM3Zt2tFXlIj7ExIe7PW2nUsw1wCkCjM_FsO3sW809PHY7spB8g.jpg")

    expect(entry[:comment]).to eq(6)
    expect(entry[:cost]).to eq(609)
    expect(entry[:effect]).to eq(8.1)
    expect(entry[:enviro]).to eq(8.1)
    expect(entry[:service]).to eq(8.1)
    expect(entry[:rank]).to eq(4.0)
  end
end
