# encoding:utf-8

require 'nokogiri'
require 'date'

module Parser
  class XinShang
    # parser for http://91xinshang.com/
    def parse_list_page(file_content)
      rets = []
      doc = Nokogiri::HTML(file_content)
      doc.css('ul.list li').each do |li|
        vals = {}
        vals[:link] = li.css('a').first['href']
        vals[:s_id] = vals[:link].split('/').last.split('.').first
        vals[:img] = li.css('img').first['src']
        vals[:chengshe], vals[:brand] = extract_chengse_and_brand(li.css('h3').text)
        vals[:des] = li.css('p').text.strip
        vals[:price] = li.css('div.price span').first.next.text.strip
        vals[:original_price] = li.css('del').text.strip[1..-1]
        
        rets << vals
      end
      rets
    end

    private
    def extract_chengse_and_brand(val)
      m = /【(.*)】(.*)/.match(val)

      return [m[1], m[2]]
    end

    def extract_date(date)
      if date
        Date.strptime(date, '%Y.%m')
      end
    end
  end
end