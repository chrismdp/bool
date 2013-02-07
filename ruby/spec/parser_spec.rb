$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'bool'
require 'minitest/autorun'

describe 'Bool' do
  describe "AND expression" do
    before do
      @ast = Bool.parse("a && b")
    end

    it "is false when one operand is false" do
      @ast.accept(Bool::EvalVisitor.new, ["a"]).must_equal(false)
    end

    it "is true when both operands are true" do
      @ast.accept(Bool::EvalVisitor.new, ["a", "b"]).must_equal(true)
    end
  end

  describe "OR expression" do
    before do
      @ast = Bool.parse("a || b")
    end

    it "is true when one operand is false" do
      @ast.accept(Bool::EvalVisitor.new, ["a"]).must_equal(true)
    end

    it "is false when both operands are false" do
      @ast.accept(Bool::EvalVisitor.new, []).must_equal(false)
    end
  end

  describe "NOT expression" do
    before do
      @ast = Bool.parse("!a")
    end

    it "is true when operand is false" do
      @ast.accept(Bool::EvalVisitor.new, []).must_equal(true)
    end

    it "is false when operand is true" do
      @ast.accept(Bool::EvalVisitor.new, ["a"]).must_equal(false)
    end
  end

  describe "Exception" do
    it 'is raised on parse error' do
      begin
        Bool.parse("a ||")
        fail
      rescue Bool::ParseError => expected
        expected.message.must_match /expecting TOKEN_VAR or TOKEN_NOT or TOKEN_LPAREN/
      end
    end

    it 'is raised on lexing error' do
      begin
        Bool.parse("a ^ e")
        fail
      rescue Bool::ParseError => expected
        expected.message.must_match /syntax error, unexpected TOKEN_VAR, expecting \$end|Error: could not match input/
      end
    end
    
    it 'is contains correct line and column numbers' do
      begin
        Bool.parse("b || c\n   &&")
        fail
      rescue Bool::ParseError => expected
        expected.message.must_match /line:2, column:4/
      end
    end
  end
end
