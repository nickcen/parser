# encoding:utf-8

require 'nokogiri'
require 'date'

module Parser
  class Aidingmao
    # parser for http://http://www.aidingmao.com/
    def parse_list_page(file_content)
      rets = []
      doc = Nokogiri::HTML(file_content)
      doc.css("div[data-trace='glist'] > div").each do |div|
        vals = {}

        vals[:link] = "http://www.aidingmao.com#{div.css('a').first['href']}"
        vals[:img] = div.css('img').first['data-original']
        vals[:chengshe], vals[:brand], vals[:kind] = extract_chengse_and_brand_and_kinds(div.css('h2').text)
        
        if div.css('h3').first
          vals[:price] = div.css('h3').first.children[0].text[1..-1].delete(',').to_i
          if div.css('del').first
            vals[:original_price] = div.css('del').first.text.strip[1..-1].delete(',').to_i
          else
            vals[:original_price] = nil
          end
        else
          vals[:price] = nil
          vals[:original_price] = nil
        end
        
        rets << vals
      end
      rets
    end

    private
    def extract_chengse_and_brand_and_kinds(val)
      vs = val.split(' ')
      chengshe = vs[0]
      kinds = vs[-1]
      brand = vs[1..-2].join(' ').split('/').first

      return [chengshe, brand, kinds]
    end
  end
end