require "puppet_spec_facts/version"
require 'json'
require 'puppet'
require 'semver'
require 'fileutils'

# this module is intended to be used in rspec-puppet tests when you need to
# test on a variety of platforms and need to load facter facts for each one

# you can generate appropriate json files with: facter --json > filename.json
# then dump the file in the facts directory with the .json extension. If you're
# cool you'll use facter --json | jq . > filename.json to prettyprint it

module PuppetSpecFacts
  def self.puppet_platforms
    platforms = {}
    file_list = Dir.glob("#{@proj_root}/**/*.json")
    file_list.each do |filename|
      fact_hash = get_jsonfile(filename)
      platform_name = make_sane_name(fact_hash)

      if platforms[platform_name] != nil
        next
      end
      fact_hash['fact_style'] = fact_style(fact_hash)
      platforms[platform_name] = fact_hash
    end
    platforms
  end

  def self.puppet_platform_names
    platform_names = []
    puppet_platforms.each do |name, value|
      platform_names << name
    end
    platform_names
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

  def self.facts_for_platform_by_name(platform)
    puppet_platforms[platform]
  end

  def self.resave_all_facts
    puppet_platforms.each do |name, hash|
      save_reorganized_facts_to_json(fact_hash: hash)
    end
  end

  def self.save_reorganized_facts_to_json(fact_hash: nil, dir: 'facts')
    namepath = name_osname(fact_hash)
    save_path = "#{@proj_root}/#{dir}/#{namepath}"
    filename = make_sane_name(fact_hash) + '.json'
    json_output = JSON.pretty_generate(fact_hash)
    FileUtils.mkdir_p save_path

    File.open("#{save_path}/#{filename}","w") do |f|
      f.write(json_output)
    end
  end

  def self.name_osname(fact_hash)
    osname ||= fact_hash['lsbdistid']
    osname ||= fact_hash['operatingsystem']
    osname ||= fact_hash['kernel']
    osname ||= fact_hash['osfamily']
  end

  def self.name_version(fact_hash)
    version = fact_hash['lsbdistrelease']
    version ||= fact_hash['macosx_productversion']
    version ||= fact_hash['operatingsystemrelease']
  end

  def self.name_codename(fact_hash)
    return fact_hash['lsbdistcodename'] unless fact_hash['osfamily'] == 'RedHat'
    nil
  end

  #private
  def self.make_sane_name(fact_hash)
    osname = name_osname(fact_hash)
    codename = name_codename(fact_hash)
    version = name_version(fact_hash)
    architecture = fact_hash['architecture']
    puppet_version = puppet_name(fact_hash)
    fact_style = fact_style(fact_hash)

    return [osname, codename, version, architecture, puppet_version, fact_style].compact.join('_')
  end
  def self.make_name_path(fact_hash)
      end

  def self.is_pe(fact_hash)
    return true if fact_hash['puppetversion'].downcase.include?('puppet enterprise')
    false
  end

  def self.puppet_name(fact_hash)
    if is_pe(fact_hash)
      version = fact_hash['puppetversion'].delete('()').split[3]
      return "PE-#{version}"
    else
      return fact_hash['puppetversion']
    end
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
