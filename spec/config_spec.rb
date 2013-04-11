require 'minitest_helper'

describe Miniconfig::Config do
  it 'loads a single yaml file with 1 level' do
    config = Miniconfig.load fixture_path('config_1.yml')

    config.one.must_equal 1
    config.two.must_equal 2
  end

  it 'loads a single yaml file with 2 levels' do
    config = Miniconfig.load fixture_path('config_2.yml')

    config.one.one_one.must_equal 1.1
    config.one.one_two.must_equal 1.2
    config.two.two_one.must_equal 2.1
    config.two.two_two.must_equal 2.2
  end

  it 'loads a single yaml file with 3 levels' do
    config = Miniconfig.load fixture_path('config_3.yml')

    config.one.one_one.must_equal 1.1
    config.one.one_two.must_equal 1.2
    config.one.two.two_one.must_equal 2.1
    config.one.two.two_two.must_equal 2.2
  end

  it 'loads multiple yaml files with 1 level' do
    config = Miniconfig.load fixture_path('config_1.yml'), fixture_path('config_1_1.yml')

    config.one.must_equal 'One'
    config.two.must_equal 2
  end

  it 'loads multiple yaml files with 2 levels' do
    config = Miniconfig.load fixture_path('config_2.yml'), fixture_path('config_2_1.yml')

    config.one.one_one.must_equal 'One.One'
    config.one.one_two.must_equal 1.2
    config.two.two_one.must_equal 'Two.One'
    config.two.two_two.must_equal 2.2
  end

  it 'loads multiple yaml files with 3 levels' do
    config = Miniconfig.load fixture_path('config_3.yml'), fixture_path('config_3_1.yml')

    config.one.one_one.must_equal 'One.One'
    config.one.one_two.must_equal 1.2
    config.one.two.two_one.must_equal 2.1
    config.one.two.two_two.must_equal 'Two.Two'
  end
end
