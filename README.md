# PuppetSpecFacts
[![Build Status](https://travis-ci.org/danieldreier/puppet_spec_facts.svg?branch=master)](https://travis-ci.org/danieldreier/puppet_spec_facts) [![Code Climate](https://codeclimate.com/github/danieldreier/puppet_spec_facts/badges/gpa.svg)](https://codeclimate.com/github/danieldreier/puppet_spec_facts) [![Coverage Status](https://img.shields.io/coveralls/danieldreier/puppet_spec_facts.svg)](https://coveralls.io/r/danieldreier/puppet_spec_facts?branch=master) [![Dependency Status](https://gemnasium.com/danieldreier/puppet_spec_facts.svg)](https://gemnasium.com/danieldreier/puppet_spec_facts) [![Gem Version](https://badge.fury.io/rb/puppet_spec_facts.svg)](http://badge.fury.io/rb/puppet_spec_facts)

This gem provides facts for rspec-puppet, much like
[apenny/puppet_facts](https://github.com/apenney/puppet_facts) but targeted
toward open source puppet whereas puppet_facts seems to be aimed at Puppet
Enterprise.

This project is very (very) new. If you're successful in using it (or not) I'd really appreciate feedback.

Puppet module developers (should) use rspec-puppet to validate conditional logic. One of the most common forms
of conditional logic is to change behavior based on operating system or linux distribution. Unfortunately, most
rspec-puppet tests only include a handful of relevant facts from one or two popular Linux distributions.
This gem is intended to provide a flexible way to iterate across platforms with full facter facts.

In order to be useful, this needs a wide range of facts from different platforms. You can help by making pull
requests, or by submitting facts to [facts.whilefork.com](http://facts.whilefork.com) via HTTP POST:
```bash
facter --json | curl -H "Content-Type: application/json" -d @- http://facts.whilefork.com
```

## Installation

Add this line to your puppet module's Gemfile:

```gemfile
    gem 'puppet_spec_facts'
```
Add these lines to your `spec/spec_helper.rb` file:

```ruby
    require 'puppet_spec_facts'
    include PuppetSpecFacts
```

## Usage

The code below doesn't quite work yet, so wait for an update on this before trying to use it.

To iterate through all available fact sets, do something like the following in your spec file:

```ruby
require 'spec_helper'
include PuppetSpecFacts # shown here, but should be included from spec_helper.rb

describe 'example' do
  context 'all operating systems' do
    PuppetSpecFacts.puppet_platforms.each do |name, facthash|
    # at this point, name is a human-readable string like:
    # FreeBSD_10.0-RELEASE_amd64_3.6.2_structured
    # Debian_wheezy_7.7_i386_PE-3.3.2_stringified
    # CentOS_5.11_x86_64_3.7.1_structured
    # etc
      describe "example class without any parameters on #{name}" do
        let(:params) {{ }}
        let(:facts) { facthash } # the facter output you sent in above is now available in rspec

        it { should compile.with_all_deps }
      end
    end
  end
end
```

In the real world, you probably don't want to iterate through all of the platforms, so `puppet_spec_facts` allows you to query a subset based on facter facts:

```ruby
require 'spec_helper'

describe 'example' do
  context 'all operating systems' do
    PuppetSpecFacts.facts_for_platform_by_fact(select_facts: {'lsbdistid' => 'CentOS',
                                                              'architecture' => 'x86_64',
                                                              'is_pe' => 'true',
                                                              'fact_style' => 'stringified'}) do |name, facthash|
    # This loads all fact sets for Puppet Enterprise on x86_64 CentOS with stringified-style facts
      describe "example class without any parameters on #{name}" do
        let(:params) {{ }}
        let(:facts) { facthash } # the facter output you sent in above is now available in rspec

        it { should compile.with_all_deps }
      end
    end
  end
end
```
