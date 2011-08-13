# $Id: calc.y,v 1.4 2005/11/20 13:29:32 aamine Exp $
#
# Very simple calculater.

class Calcp
  prechigh
    nonassoc UMINUS
    left '*' '/' '%'
    left '+' '-'
    nonassoc IS
    right '='
  preclow

rule
  target: exp
        | /* none */ { result = 0 }

  exp: exp '+' exp { result = AddNode.new(val[0],val[2]) }
     | exp '-' exp { result = MinusNode.new(val[0],val[2]) }
     | exp '*' exp { result = MultipleNode.new(val[0],val[2]) }
     | exp '/' exp { result = DevNode.new(val[0],val[2]) }
     | exp '%' exp { result = ModNode.new(val[0],val[2]) }
     | exp IS exp { result = IsNode.new(val[0],val[2]) }
     | '(' exp ')' { result = val[1] }
     | '-' NUMBER  =UMINUS { result = UMinusNode.new(val[1]) }
     | VAR '=' exp { result = EqualNode.new(val[0],val[2]) }
     | NUMBER {result = NumberNode.new(val[0]) }
     | VAR { result = VarNode.new(val[0])}
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
    return BoolNode.new(@left.eval(var_table)==@right.eval(var_table))
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
      when /\Ais/
        @q.push [:IS,nil]
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
    puts parsed.eval(var)
  rescue ParseError
    puts $!
  end
end
