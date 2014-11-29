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
end
