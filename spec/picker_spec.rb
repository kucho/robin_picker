# frozen_string_literal: true

require_relative '../lib/robin_picker'
require 'json'

RSpec.describe RobinPicker do
  subject { described_class.new(pools, 4).perform }

  def read_json(filename)
    JSON.parse(File.read("spec/fixtures/#{filename}"), symbolize_names: true)
  end

  shared_examples_for :articles do
    let(:pools) do
      raw_pools = file_content.values
      raw_pools.map do |pool|
        pool.map { |article| article[:token].to_i }
      end
    end

    it { is_expected.to eq result }
  end

  describe '#pick' do
    context 'first scenario' do
      let(:file_content) { read_json('scenario-1.json') }
      let(:result) { [345_048] }

      include_examples :articles
    end

    context 'second scenario' do
      let(:file_content) { read_json('scenario-2.json') }
      let(:result) { [790_952, 103_678, 788_138, 802_358] }

      include_examples :articles
    end

    context 'third scenario' do
      let(:file_content) { read_json('scenario-3.json') }
      let(:result) { [103_678, 790_952, 802_358, 788_138] }

      include_examples :articles
    end

    context 'fourth scenario' do
      let(:file_content) { read_json('scenario-4.json') }
      let(:result) { [790_952, 103_678, 802_358, 562_873] }

      include_examples :articles
    end
  end
end
