# Tomoki Imai

class Prprp
  prechigh
    nonassoc UMINUS
    left '*' '/' MOD
    left '^'
    left '+' '-'
    nonassoc IS
    nonassoc ISNOT
    nonassoc '>'
    nonassoc '<'

    right "="
    nonassoc PRINT
    left ';'
    nonassoc IF

  preclow
rule

  target: exp
        | /* none */ { result = NumberNode.new(0)}

  exp: exp '+' exp { result = AddNode.new(val[0],val[2]) }
     | exp '-' exp { result = MinusNode.new(val[0],val[2]) }
     | exp '*' exp { result = MultipleNode.new(val[0],val[2]) }
     | exp '/' exp { result = DevNode.new(val[0],val[2]) }
     | exp MOD exp { result = ModNode.new(val[0],val[2]) }
     | exp '^' exp { result = PowerNode.new(val[0],val[2]) }
     | exp IS exp { result = IsNode.new(val[0],val[2]) }
     | exp '<' exp { result = BiggerNode.new(val[2],val[0]) }
     | exp '>' exp { result = BiggerNode.new(val[0],val[2]) }
     | exp ISNOT exp { result = IsNotNode.new(val[0],val[2])}
     | PRINT exp { result = PrintNode.new(val[1])}
     | IF exp THEN exp { result = IfNode.new(val[1],val[3])}
     | IF exp THEN exp ELSE exp { result = IfElseNode.new(val[1],val[3],val[5])}
     | FOR exp TO exp DO exp { result = ForNode.new(val[1],val[3],val[5])}
     | LABEL STRING TO exp { result=LabelNode.new(val[1],val[3]) }
     | GOTO STRING { result = GotoNode.new(val[1]) }
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

class VarNode
  def initialize(name)
    @name = name
  end
  def eval(env)
    return env.var_table[@name]
  end
end

class NumberNode
  def initialize(value)
    @value = value
  end
  def eval(env)
    return @value
  end
end

class StringNode
  def initialize(value)
    @value = value
  end
  def eval(env)
    return @value
  end
end

class AddNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(env)
    return @left.eval(env) + @right.eval(env)
  end
end

class MinusNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(env)
    return @left.eval(env) - @right.eval(env)
  end
end

class MultipleNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(env)
    return @left.eval(env) * @right.eval(env)
  end
end

class DevNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(env)
    return @left.eval(env) / @right.eval(env)
  end
end

class ModNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(env)
    return @left.eval(env)% @right.eval(env)
  end
end

class PowerNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(env)
    return @left.eval(env) **  @right.eval(env)
  end
end

class UMinusNode
  def initialize(num)
    @num = num
  end
  def eval(env)
    return -1 * @num.eval(env)
  end
end

class EqualNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(env)
    env.var_table[@left] = @right.eval(env)
  end
end

class BoolNode
  def initialize(bool)
    @bool = bool
  end
  def eval(env)
    return @bool
  end
end

class LabelNode
  def initialize(label,exp)
    @label = label
    @exp = exp
  end
  def eval(env)
    env.label_table[@label] = @exp
  end
  def gotoed(env)
    @exp.eval(env)
  end
end

class GotoNode
  def initialize(label)
    @label = label
  end
  def eval(env)
    return env.label_table[@label].eval(env)
  end
end


class IsNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(env)
    return BoolNode.new(@left.eval(env)==@right.eval(env)).eval(env)
  end
end


class BiggerNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(env)
    return BoolNode.new(@left.eval(env) > @right.eval(env))
  end
end

class IsNotNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(env)
    return BoolNode.new(@left.eval(env)!=@right.eval(env)).eval(env)
  end
end

class IfNode
  def initialize(boolexp,exp)
    @boolexp = boolexp
    @exp = exp
  end
  def eval(env)
      b =  @boolexp.eval(env)
      puts(b)
      print(b.class)
      if b.class == true.class
        return @exp.eval(env)
      elsif b.class != false.class
        raise ParseError
      end
    end
  end

class ForNode
  def initialize(initexp,boolexp,doexp)
    @initexp = initexp
    @boolexp = boolexp
    @doexp = doexp
  end
  def eval(env)
    @initexp.eval(env)
    while(not @boolexp.eval(env))
      @doexp.eval(env)
    end
  end
end



class IfElseNode
  def initialize(boolexp,trueexp,falseexp)
    @boolexp = boolexp
    @trueexp = trueexp
    @falseexp = falseexp
  end
  def eval(env)
    b = @boolexp.eval(env)
    if b.class == true.class
      return @trueexp.eval(env)
    elsif b.class == false.class
      return @falseexp.eval(env)
    else
      raise ParseError
    end
  end
end

class BlockNode
  def initialize(nodelist)
    @nodelist = nodelist
  end
  def eval(env)
    answer = 0
    @nodelist.each do |node|
      answer = node.eval(env)
    end
    return answer
  end
end

class PrintNode
  def initialize(value)
    @value = value
  end
  def eval(env)
    puts @value.eval(env)
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
      when /\Amod/
        @q.push [:MOD,nil]
      when /\Agoto/
        @q.push [:GOTO,nil]
      when /\Alabel/
        @q.push [:LABEL,nil]
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
class Env
  def initialize()
    @var_table = {}
    @label_table = {}
  end
  def var_table
    return @var_table
  end
  def label_table
    return @label_table
  end
end

if ARGV.length == 0
    parser = Prprp.new
    environment = Env.new()
    str = ARGF.read
  begin
    parsed = parser.parse(str)
    parsed.eval(environment)
  rescue ParseError => e
    puts e
  end
else
    parser = Prprp.new
    environment = Env.new()
    f = open(ARGV[0])
    begin
      str = f.read
      parsed = parser.parse(str)
      parsed.eval(environment)
    rescue ParseError => e
      puts e
    end
    f.close()
end
