# dastels@icloud.com
# @dastels

require 'pry'

class DBCBinaryTree
  attr_reader :root
  def initialize(root = nil)
    @root = root
  end

  def size
    return 0 if @root.nil?
    @root.size
  end

  def insert(n)
    if @root.nil?
      @root = BinaryTreeNode.new(n)
    else
      @root.insert(n)
    end
  end

  def depth
    return 0 if @root.nil?
    @root.depth
  end

  def to_s
    return "[]" unless @root
    @root.to_s
  end

  def empty?
    @root.nil? ? true : false
  end

  def find(n)
    return false if @root.nil?
    @root.find(n)
  end

  def map(&block)
    @root.map(&block)
    to_s
  end

  def preorder(&block)
    @root.preorder(&block)
  end

  def postorder(&block)
    @root.postorder(&block)
  end

  def inorder(&block)
    @root.inorder(&block)
  end

end

class BinaryTreeNode
  attr_reader :value

  def initialize(n, left=nil, right=nil)
    @value = n
    @left = left
    @right = right
  end

  def size
    left_size = @left.nil? ? 0 : @left.size
    right_size = @right.nil? ? 0 : @right.size
    1 + left_size + right_size
  end

  def insert(n)
    if n > @value
      @right ? @right.insert(n) : @right = BinaryTreeNode.new(n)
    elsif n < @value
      @left ? @left.insert(n) : @left = BinaryTreeNode.new(n)
    end
  end

  def depth
    left_depth = @left ? @left.depth : 0
    right_depth = @right ? @right.depth : 0
    left_depth >= right_depth ? 1 + left_depth : 1 + right_depth
  end

  def to_s
    left = @left ? @left.to_s : "-"
    right = @right ? @right.to_s : "-"
    "[#{left} #{@value} #{right}]"
  end

  def find(n)
    return true if @value == n
    left_find = @left ? @left.find(n) : false
    right_find = @right ? @right.find(n) : false
    left_find || right_find
  end

  def map(&block)
    @value = yield(@value)
    @left.map(&block) if @left
    @right.map(&block) if @right
  end

  def preorder(&block)
    yield(@value)
    @left.preorder(&block) if @left
    @right.preorder(&block) if @right
  end

  def postorder(&block)
    @left.postorder(&block) if @left
    @right.postorder(&block) if @right
    block.call(@value)
  end

  def inorder(&block)
    @left.inorder(&block) if @left
    yield(@value)
    @right.inorder(&block) if @right
  end
end