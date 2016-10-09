# encoding:utf-8

require 'nokogiri'

module Parser
  class Dianping

    RATING_KESY = {
      '消费' => :cost, 
      '效果' => :effect, 
      '环境' => :enviro, 
      '服务' => :service, 
      '产品' => :product, 
      '人均' => :avg_cost, 
      '口味' => :taste, 
      '技师' => :tech, 
      '费用' => :cost, 
      '设施' => :equip, 
      '师资' => :tech, 
      '医生' => :tech, 
      '房间' => :enviro, 
      '价格' => :cost, 
      '技术' => :tech, 
      '均价' => :cost, 
      '阿姨' => :tech, 
      '划算' => :cost_effective, 
      '项目' => :equip, 
      '守时' => :service
    }

    def parse_list_page(file_content)
      rets = []
      doc = Nokogiri::HTML(file_content)
      doc.css('div.tit > a').each do |link|
        if link['data-hippo-type'] && link['data-hippo-type'] == 'shop'
          id = link['href'].split('/').last
          url = "http://www.dianping.com#{link['href']}"
          name = link.css('h4').text
          rets << {:name => name, :url => url, id: url.split('/').last}
        end
      end

      rets
    end

    def parse_entry_page(file_content)
      begin

        doc = Nokogiri::HTML(file_content)

        category_name = doc.css("a.current-category")[0].text

        case category_name
        when '学习培训'
          parse_training_page(doc)
        else
          parse_service_page(doc)
        end
      rescue Exception => e
        puts e.backtrace
      end
    end

    private
    def parse_training_page(doc)
      ret = {}

      ret[:name] = doc.css('div.shop-name h2').text.strip
      ret[:address] = doc.css('div.address').children[2..-1].map(&:text).map(&:to_s).map(&:strip).join

      extract_items(doc, 'div.brief-info div.rank .item', ret)
      extract_tels(doc, 'div.phone span.item', ret)

      ret[:rank] = doc.css('span.mid-rank-stars').attr('class').to_s.split.last[7..-1].to_f / 10

      pic_tag = doc.css('div.pic img').first
      if pic_tag
        pic = pic_tag['src']
      else
        pic = nil
      end

      ret[:pic] = pic

      ret
    end

    def parse_service_page(doc)
      ret = {}

      ret[:name] = doc.css('h1.shop-name').children[0].text.strip
      ret[:address] = doc.css('div.address').children[2..-1].map(&:text).map(&:to_s).map(&:strip).join

      extract_items(doc, 'div.brief-info .item', ret)
      extract_tels(doc, 'p.tel span.item', ret)

      ret[:rank] = doc.css('span.mid-rank-stars').attr('class').to_s.split.last[7..-1].to_f / 10

      pic_tag = doc.css('div.photos-container div.photos img').first
      if pic_tag
        pic = pic_tag['src']
      else
        pic = nil
      end

      ret[:pic] = pic

      ret
    end

    def extract_tels(doc, exp, ret)
      tels = doc.css(exp)
      ret[:tels] = tels.map do |tag|
        tag.text
      end
    end

    def extract_items(doc, exp, ret)
      items = doc.css(exp)

      items.each do |item|
        idx = item.text.index("条评论")
        if idx
          ret[:comment] = item.text[0...idx].to_i
        else
          key, value = item.text.split('：')
          if RATING_KESY.has_key?(key)
            ret[RATING_KESY[key]] = value == '-' ? nil : value.to_f
          else
            ret[key] = value == '-' ? nil : value.to_f
          end
        end
      end
    end
  end
end