require 'serverspec'
require 'pathname'
require 'rspec/its'
require 'yaml'
require 'csv'
require 'active_support/core_ext/hash/indifferent_access'
 
properties = HashWithIndifferentAccess.new(YAML.load_file('properties.yml'))

explains = []
results = []
row_num = []
command = []
hostname = ""
spacer_char = '   '
isFirst = TRUE

def get_example_desc(example_group, descriptions)
  
  descriptions << example_group[:description]
  return descriptions if example_group[:parent_example_group] == nil

  get_example_desc(example_group[:parent_example_group], descriptions)
end

def insert_bom(filename)
   File.open(filename, "w:UTF-8") do |f|
      bom = '   '
      bom.setbyte(0, 0xEF)
      bom.setbyte(1, 0xBB)
      bom.setbyte(2, 0xBF)
      f.print bom
   end
end

RSpec.configure do |c|
  c.host  = ENV['TARGET_HOST']

  set_property properties[c.host]
  c.expose_current_running_example_as :example

  result_summary = "../Shift_Log/Serverspec_Result_Summary.log"

  if isFirst
    insert_bom(result_summary)
    isFirst = FALSE
  end

  ## windows
  if property[:operating_system]=="Windows" then

    require 'winrm'
    set :backend, :winrm

    user = ENV['CONN_USER']
    pass = ENV['CONN_PASSWORD']

    endpoint = "https://#{ENV['TARGET_HOST']}:5986/wsman"
    winrm = ::WinRM::WinRMWebService.new(endpoint, :ssl, :user => user, :pass => pass, :basic_auth_only => true, :no_ssl_peer_verification => true)
    winrm.set_timeout 300 # 5 minutes max timeout for any operation
    Specinfra.configuration.winrm = winrm

  ## linux
  elsif property[:operating_system]=="Linux" then

    require 'net/ssh'
    set :backend, :ssh

    set :sudo_password, ENV['SUDO_PASSWORD'] || ENV['CONN_PASSWORD']

    host = ENV['TARGET_HOST']    
    
    options = Net::SSH::Config.for(host)
    options[:user] = ENV['CONN_USER']
    options[:password]= ENV['CONN_PASSWORD']
    options[:keys]= ENV['HOME'] + "/.ssh/id_rsa_shift"
 
    set :host,        options[:host_name] || host
    set :ssh_options, options

    c.ssh   = Net::SSH.start(c.host, user, options)

  end

  prev_desc_hierarchy = nil

  c.before(:suite) do
    entity_host =c.host
    puts "\e[33m"
    puts "### start #{entity_host} serverspec... ###"
    print "\e[m"

    row_num << 1
  end

  c.after(:each) do
      spacer = '  '
      desc_hierarchy = get_example_desc(self.example.metadata[:example_group], []).reverse
      desc_hierarchy.each_with_index do |ex, i|
        spacer += spacer_char
        if prev_desc_hierarchy != nil && prev_desc_hierarchy.length > i && prev_desc_hierarchy[i] == desc_hierarchy[i]
        else
          explains << spacer + "- " + ex
          results << ''
          row_num << i + 1
          command << ''
        end
      end

      explains << spacer + spacer_char + "- " +  (self.example.metadata[:description] || '')
      results << (self.example.exception ? 'NG' : 'OK')
      row_num << desc_hierarchy.length + 1
      command << self.example.metadata[:command]

      prev_desc_hierarchy = desc_hierarchy
  end

  c.after(:suite) do
   result_csv = "../Shift_Log//Serverspec_Result_" + c.host + ".csv"

   insert_bom(result_csv)

   CSV.open(result_csv, 'a') do |writer|
      writer << [c.host,""]
      writer << [" - OK=" + results.count("OK").to_s,""]
      writer << [" - NG=" + results.count("NG").to_s,""]
      writer << ["==============================",""]
      explains.each_with_index do |v, i|
        writer << [v, results[i], command[i]]
      end
    end

    File.open(result_summary, "a") do |file|
      summary = c.host + ":\t OK=" + results.count("OK").to_s + "\t NG=" + results.count("NG").to_s
      file.puts summary
    end

    File.open(result_summary, "r") do |file|
      print file.read
    end
 end
end

