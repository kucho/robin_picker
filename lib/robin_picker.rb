# frozen_string_literal: true

# RobinPicker generates a homogeneous list based on a Round-Robin approach
class RobinPicker
  attr_reader :pools, :size

  def initialize(pools, size)
    @pools = pools.reject(&:empty?)
    @size = size
  end

  def perform
    max_size = pools.map(&:count).max
    first = pools.shift
    first.fill(nil, first.count...max_size) unless first.count == max_size
    first.zip(*pools).flatten.compact.slice(0, size)
  end
end
