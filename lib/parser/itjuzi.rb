# encoding:utf-8

require 'nokogiri'

module Parser
  class ITJuzi

    def parse_list_page(file_content)
      rets = []
      doc = Nokogiri::HTML(file_content)
      doc.css('ul.list-main-icnset')[1].css('li').each do |li|
        vals = {}
        vals[:img] = li.css('img').first['src']
        vals[:title] = li.css('p.title').text
        vals[:des] = li.css('p.des').text
        vals[:tags] = li.css('span.tags > a').text
        vals[:loca] = li.css('span.loca > a').text
        vals[:found_date] = extract_date(li.css('i.date').text.strip)
        vals[:latest_round] = li.css('i.round span').text
        rets << vals
      end
      rets
    end

    private
    def extract_date(date)
      if date
        Date.strptime(date, '%Y.%m')
      end
    end
  end
end