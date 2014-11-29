require "puppet_spec_facts/version"
require 'json'
require 'puppet'
require 'semver'

# this module is intended to be used in rspec-puppet tests when you need to
# test on a variety of platforms and need to load facter facts for each one

# you can generate appropriate json files with: facter --json > filename.json
# then dump the file in the facts directory with the .json extension. If you're
# cool you'll use facter --json | jq . > filename.json to prettyprint it

module PuppetSpecFacts
  # Your code goes here...
  def self.puppet_platforms
    platforms = {}
    file_list = Dir.glob("#{@proj_root}/**/*.json")
    file_list.each do |filename|
      fact_hash = get_jsonfile(filename)
      platform_name = stringify_name(osfamily: fact_hash['osfamily'],
                                              factstyle: fact_style(fact_hash),
                                              operatingsystemrelease: fact_hash['operatingsystemrelease'],
                                              architecture: fact_hash['architecture'])
      abort("a platform named '#{platform_name}' has already been defined") if platforms[platform_name] != nil
      fact_hash[fact_style] = fact_style(fact_hash)
      platforms[platform_name] = fact_hash
    end
    platforms
  end

  def self.facts_for_platform_by_fact(factstyle: nil, select_facts: {})
    puppet_platforms.select { |platform, facts|
      match = true
      select_facts.each { |query_fact, query_value|
        match = false if facts[query_fact] != query_value
      }
      match
    }
  end

  #private
  def self.stringify_name(osfamily: nil, factstyle: nil, operatingsystemrelease: nil, architecture: nil)
    [osfamily.to_s, operatingsystemrelease.to_s, architecture.to_s, factstyle.to_s].compact.join('-')
  end

  @proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  if Dir[File.join(@proj_root,"facts")].empty?
    abort("facts dir missing")
  end

  def self.fact_style(fact_hash)
    if SemVer.new(fact_hash['facterversion']) > SemVer.new('2.0.0')
      return 'structured'  if fact_hash['system_uptime'].is_a?(Hash)
      return 'stringified' if fact_hash['system_uptime'] == nil
    elsif SemVer.new(fact_hash['facterversion']) < SemVer.new('2.0.0')
      return 'stringified' if fact_hash['system_uptime'] == nil
    end
    raise('cannot determine whether fact hash is structured or stringified')
  end

  def self.get_jsonfile(filename)
    JSON.parse(File.read(filename))
  end
end
