# $Id: calc.y,v 1.4 2005/11/20 13:29:32 aamine Exp $
#
# Very simple calculater.

class Calcp
  expect 15
  prechigh
    nonassoc UMINUS
    left '*' '/' '%'
    left '+' '-'
    nonassoc IS
    nonassoc ISNOT
    right '='
    nonassoc PRINT
    left ';'
    nonassoc IF
  preclow

rule
  target: exp
        | /* none */ { result = NumberNode.new(0) }

  exp: exp '+' exp { result = AddNode.new(val[0],val[2]) }
     | exp '-' exp { result = MinusNode.new(val[0],val[2]) }
     | exp '*' exp { result = MultipleNode.new(val[0],val[2]) }
     | exp '/' exp { result = DevNode.new(val[0],val[2]) }
     | exp '%' exp { result = ModNode.new(val[0],val[2]) }
     | exp IS exp { result = IsNode.new(val[0],val[2]) }
     | exp ISNOT exp { result = IsNotNode.new(val[0],val[2])}
     | PRINT exp { result = PrintNode.new(val[1])}
     | IF exp THEN exp { result = IfNode.new(val[1],val[3])}
     | IF exp THEN exp ELSE exp { result = IfElseNode.new(val[1],val[3],val[5])}
     | FOR exp TO exp DO exp { result = ForNode.new(val[1],val[3],val[5])}
     | '(' exp ')' { result = val[1] }
     | '{' explist '}' {result = BlockNode.new(val[1])}
     | '-' NUMBER  =UMINUS { result = UMinusNode.new(val[1]) }
     | VAR '=' exp { result = EqualNode.new(val[0],val[2]) }
     | NUMBER {result = NumberNode.new(val[0]) }
     | VAR { result = VarNode.new(val[0])}
     | STRING { result = StringNode.new(val[0]) }

  explist: {result = []}
         | exp {result=[val[0]]}
         | explist ';' exp {result=val[0] << val[2]}

end


---- header
# $Id: calc.y,v 1.4 2005/11/20 13:29:32 aamine Exp $

class VarNode
  def initialize(name)
    @name = name
  end
  def eval(var_table)
    return var_table[@name]
  end
end

class NumberNode
  def initialize(value)
    @value = value
  end
  def eval(var_table)
    return @value
  end
end

class StringNode
  def initialize(value)
    @value = value
  end
  def eval(var_table)
    return @value
  end
end

class AddNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "|Add node|\n| #{@left}  #{@right}"
  end
  def eval(var_table)
    return @left.eval(var_table) + @right.eval(var_table)
  end
end

class MinusNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "|Minus node|\n|#{"-"*(@right.to_s.length+2)}|\n#{@left}  #{@right}"
  end
  def eval(var_table)
    return @left.eval(var_table) - @right.eval(var_table)
  end
end

class MultipleNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "|Multiple node|\n|#{"-"*(@right.to_s.length+2)}|\n#{@left}  #{@right}"
  end
  def eval(var_table)
    return @left.eval(var_table) * @right.eval(var_table)
  end
end

class DevNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "|Dev node|\n|#{"-"*(@right.to_s.length+2)}|\n#{@left}  #{@right}"
  end
  def eval(var_table)
    return @left.eval(var_table) / @right.eval(var_table)
  end
end

class ModNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "|Mod node|\n|#{"-"*(@right.to_s.length+2)}|\n#{@left}  #{@right}"
  end
  def eval(var_table)
    @left.eval(var_table)% @right.eval(var_table)
  end
end

class UMinusNode
  def initialize(num)
    @num = num
  end
  def to_s()
    return "|UMinus node|\n|#{@num}"
  end
  def eval(var_table)
    return -1 * @num.eval(var_table)
  end
end

class EqualNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "Mod node\n|#{"-"*(@right.to_s.length+2)}|\n#{@left}  #{@right}"
  end
  def eval(var_table)
    var_table[@left] = @right.eval(var_table)
  end
end

class BoolNode
  def initialize(bool)
    @bool = bool
  end
  def eval(var_table)
    return @bool
  end
end


class IsNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(var_table)
    return BoolNode.new(@left.eval(var_table)==@right.eval(var_table)).eval(var_table)
  end
end

class IsNotNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(var_table)
    return BoolNode.new(@left.eval(var_table)!=@right.eval(var_table)).eval(var_table)
  end
end

class IfNode
  def initialize(boolexp,exp)
    @boolexp = boolexp
    @exp = exp
  end
  def eval(var_table)
    if @boolexp.eval(var_table)
      return @exp.eval(var_table)
    end
  end
end

class ForNode
  def initialize(initexp,boolexp,doexp)
    @initexp = initexp
    @boolexp = boolexp
    @doexp = doexp
  end
  def eval(var_table)
    @initexp.eval(var_table)
    while(not @boolexp.eval(var_table))
      @doexp.eval(var_table)
    end
  end
end

class IfElseNode
  def initialize(boolexp,trueexp,falseexp)
    @boolexp = boolexp
    @trueexp = trueexp
    @falseexp = falseexp
  end
  def eval(var_table)
    if @boolexp.eval(var_table)
      return @trueexp.eval(var_table)
    else
      return @falseexp.eval(var_table)
    end
  end
end

class BlockNode
  def initialize(nodelist)
    @nodelist = nodelist
  end
  def eval(var_table)
    answer = 0
    @nodelist.each do |node|
      answer = node.eval(var_table)
    end
    return answer
  end
end

class PrintNode
  def initialize(value)
    @value = value
  end
  def eval(var_table)
    puts @value.eval(var_table)
  end
end
---- inner

  def initialize()
    @nodes = []
  end

  def parse(str)
    @q = []
    until str.empty?
      case str
      when /\A\s+/
      when /\A\d+\.?\d*/
        @q.push [:NUMBER, $&.to_f]
      when /\Aif/
        @q.push [:IF,nil]
      when /\Aisnot/
        @q.push [:ISNOT,nil]
      when /\Ais/
        @q.push [:IS,nil]
      when /\Athen/
        @q.push [:THEN,nil]
      when /\Aelse/
        @q.push [:ELSE,nil]
      when /\Aprint/
        @q.push [:PRINT,nil]
      when /\Afor/
        @q.push [:FOR,nil]
      when /\Ato/
        @q.push [:TO,nil]
      when /\Ado/
        @q.push [:DO,nil]
      when /\A"(.*?)"/
        @q.push [:STRING,$1]
      when /\A\w+/
        @q.push [:VAR,$&.to_s]
      when /\A.|\n/o
        s = $&
        @q.push [s, s]
      end
      str = $'
    end
    @q.push [false, '$end']
    do_parse
  end

  def next_token
    @q.shift
  end

---- footer

if ARGV.length == 0
    parser = Calcp.new
    puts
    puts 'type "Q" to quit.'
    puts
    var = {}
    while true
      puts
      print '? '
      str = gets.chop!
      break if /q/i =~ str
      begin
        parsed = parser.parse(str)
        parsed.eval(var)
      rescue ParseError
        puts $!
      end
    end
else
    parser = Calcp.new
    var = {}
    f = open(ARGV[0])
    begin
      str = f.read
      parsed = parser.parse(str)
      parsed.eval(var)
    rescue ParseError => e
      puts e
    end
    f.close
end
