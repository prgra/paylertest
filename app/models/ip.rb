class Ip < ApplicationRecord
  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  validates :ip, 
            :presence => true, 
            :uniqueness => true,
            :format => { :with => @ip_regex,:multiline => true } 

end


def makecountry (ip)
        logger.debug " get http://freegeoip.net/json/#{ip}"
        uri = URI("http://freegeoip.net/json/#{@ip.ip}")
        req = Net::HTTP.get(uri)
        dta = JSON.parse(req)
        co = Country.find_by name:dta["country_name"]
        if co.nil? 
          Country.create :name=>dta["country_name"]
          logger.debug "add country #{dta["country_name"]}"
          co = Country.find_by name:dta["country_name"]
        end
        @ip.update(:country => co.id)
        return nil
  end