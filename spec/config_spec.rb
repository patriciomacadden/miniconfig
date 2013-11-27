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

  it 'defines singleton methods in each level' do
    config = Miniconfig.load fixture_path('config_2.yml')

    config.must_respond_to :one
    config.must_respond_to :two
    config.wont_respond_to :one_one
    config.wont_respond_to :one_two
    config.wont_respond_to :two_one
    config.wont_respond_to :two_two
    config.one.must_respond_to :one_one
    config.one.must_respond_to :one_two
    config.two.must_respond_to :two_one
    config.two.must_respond_to :two_two
  end

  describe '#each' do
    it 'executes the block with all of its settings' do
      config = Miniconfig::Config.new({ a: 1, b: 2, c: { e: 4, d: 5 } })
      control = [:a, :b, :c, 1, 2, config.c]

      config.each do |key, value|
        control.delete value
        control.delete key
      end

      control.must_be_empty
    end

    it 'does not navigate through children Config instances' do
      data = { a: { aa: 1 }, b: { bb: 2 }, c: { cc: 3 } }
      values, keys = [], []

      Miniconfig::Config.new(data).each do |key, value|
        keys << key
        values << value
      end

      values.wont_include 1
      values.wont_include 2
      values.wont_include 3

      keys.wont_include :aa
      keys.wont_include :bb
      keys.wont_include :cc
    end
  end
end
