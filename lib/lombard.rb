require 'httparty'
#require 'pry'
require 'uri'
require 'yaml'

class Lombard
  @@api_url = "http://api.openweathermap.org/data/2.5/weather"
  @@favorite_file = File.expand_path "~/.lombard.yml"

  def initialize
    @no_connection = false
  end

  def self.version
    "1.0.0"
  end

  ###
   # Fetches forecast from remote API
   ##
  def fetch(location)
    begin
      response = HTTParty.get "#{@@api_url}?q=#{URI.escape(location)}"
      body = JSON.parse response.body

      # Check if city exists
      (body['cod'] == 200) ? body : nil
    rescue
      puts "Whoops! I failed to reach server. You should check your connection!"
      @no_connection = true
      nil
    end
  end

  ###
   # Formats pulled data
   ##
  def format(o)
    if o == nil
      # No data
      return nil
    end

    outcome = "# #{o['name']}"

    country = o['sys']['country']
    if country != nil
      outcome += " (#{country})"
    end

    outcome += "\n  #{o['weather'].first['main']}"

    description = o['weather'].first['description']
    if description != nil
      outcome += " - #{description}"
    end

    temp = o['main']['temp']
    celsius = temp.to_f - 273.15
    fahrenheit = celsius * 1.8 + 32
    outcome += "\n  #{celsius.to_i}°C / #{fahrenheit.to_i}°F"

    return outcome
  end

  ###
   # Fetches forecast for each favorite
   ##
  def favorites()
    if File.exists? @@favorite_file
      locations = YAML.load_file @@favorite_file

      if locations
        locations.each_with_index do |e, i|
          if i != 0
            puts '----------------------------'
          end
          run(e)
        end
      else
        puts "No favorite in your config file. Visit https://github.com/acadet/lombard for more details."
      end
    else
      # No config file
      puts "No favorite file found. Run \"lombard --init\" to generate it."
    end
  end

  ###
   # Generates empty config file
   ##
  def self.init_config
    if File.exists? @@favorite_file
      # Do not override existing file
      puts "Config file is already existing (#{@@favorite_file})."
    else
      f = File.new @@favorite_file, "w"
      f.puts '###############################################'
      f.puts '###           Lombard config file           ###'
      f.puts '###                                         ###'
      f.puts '### Visit https://github.com/acadet/lombard ###'
      f.puts '###     to know more about this file        ###'
      f.puts '###############################################'
      puts "Successfully created #{@@favorite_file}!"
    end
  end

  ###
   # Here comes the magic trick
   ##
  def run(location)
    result = format(fetch(location))

    if result != nil
      puts result
    elsif !@no_connection
      # No data and user is connected to the fabulous Internet, full of unicorns and rainbows
      puts "#{location} does not exist on Earth. You may be an alien!"
    end
  end
end