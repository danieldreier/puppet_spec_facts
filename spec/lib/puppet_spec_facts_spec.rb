require 'spec_helper'

stringified_hash = {
  "kernel" => "Linux",
  "osfamily" => "Debian",
  "operatingsystem" => "Debian",
  "facterversion" => "1.7.5"
}
structured_hash = {
  "kernel" => "Linux",
  "osfamily" => "Debian",
  "operatingsystem" => "Debian",
  "facterversion" => "2.2.0",
  "system_uptime" => {
    "seconds" => 15416,
    "hours" => 4,
    "days" => 0,
    "uptime" => "4:16 hours"
  }
}
# structured facts only existed after facter 2.x
impossible_hash = {
  "facterversion" => "1.0.0",
  "system_uptime" => {
    "seconds" => 15416,
  }
}

pe_hash = {
  "kernel" => "Linux",
  "osfamily" => "Debian",
  "operatingsystem" => "Debian",
  'puppetversion' => '3.6.2 (Puppet Enterprise 3.3.2)'
}
foss_hash = {
  "kernel" => "Linux",
  "osfamily" => "Debian",
  "operatingsystem" => "Debian",
  'puppetversion' => '3.6.2'
}

describe PuppetSpecFacts do
  describe 'fact_style' do
    it 'detects stringified facts' do
      expect(PuppetSpecFacts.fact_style(stringified_hash)).to eq('stringified')
    end
    it 'detects structured facts' do
      expect(PuppetSpecFacts.fact_style(structured_hash)).to eq('structured')
    end
    it 'raises an error given an invalid input' do
      expect { PuppetSpecFacts.fact_style(impossible_hash) }.to raise_error
    end
  end

  describe 'is_pe' do
    it 'returns true if hash is from Puppet Enterprise' do
      expect(PuppetSpecFacts.is_pe(pe_hash)).to be true
    end
    it 'returns false if hash is from open source Puppet' do
      expect(PuppetSpecFacts.is_pe(foss_hash)).to be false
    end
  end

  describe 'puppet_name' do
    it 'contains "PE" given a PE hash' do
      expect(PuppetSpecFacts.puppet_name({'puppetversion' => '3.6.2 (Puppet Enterprise 3.3.2)'})).to include('PE-')
    end
    it 'is the puppet version given a foss hash' do
      expect(PuppetSpecFacts.puppet_name({'puppetversion' => '3.6.2'})).to eq('3.6.2')
    end
  end

  describe 'puppet_platforms' do
    it 'returns at least five values' do
      expect(PuppetSpecFacts.puppet_platforms.count).to be >= 5
    end
    it 'returns a hash' do
      expect(PuppetSpecFacts.puppet_platforms).to be_a(Hash)
    end
  end

  describe 'puppet_platform_names' do
    it 'returns an array' do
      expect(PuppetSpecFacts.puppet_platform_names).to be_an(Array)
    end
    it 'returns at least five values' do
      expect(PuppetSpecFacts.puppet_platform_names.count).to be >= 5
    end
  end

  describe 'facts_for_platform_by_fact' do
    it 'returns at least 5 values for "architecture" => "x86_64"' do
      expect(PuppetSpecFacts.facts_for_platform_by_fact(select_facts: { "architecture" => "x86_64" }).count).to be >= 5
    end
    it 'returns at least 5 values for "kernel" => "Linux"' do
      expect(PuppetSpecFacts.facts_for_platform_by_fact(select_facts: { "kernel" => "Linux" }).count).to be >= 5
    end
    it 'returns no values for "architecture" => "foo"' do
      expect(PuppetSpecFacts.facts_for_platform_by_fact(select_facts: { "architecture" => "foo" }).count).to eq(0)
    end
  end
end
