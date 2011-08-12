# $Id: calc.y,v 1.4 2005/11/20 13:29:32 aamine Exp $
#
# Very simple calculater.

class Calcp
  prechigh
    nonassoc UMINUS
    left '*' '/' '%'
    left '+' '-'
    right '='
  preclow

rule
  target: exp
        | /* none */ { result = 0 }

  exp: exp '+' exp { result += val[2] }
     | exp '-' exp { result -= val[2] }
     | exp '*' exp { result *= val[2] }
     | exp '/' exp { result /= val[2] }
     | exp '%' exp { result %= val[2] }
     | '(' exp ')' { result = val[1] }
     | '-' NUMBER  =UMINUS { result = -val[1] }
     | VAR '=' exp { result = @var[val[0]] = val[2] }
     | NUMBER
     | VAR { result=@var[val[0]]}
end


---- header
# $Id: calc.y,v 1.4 2005/11/20 13:29:32 aamine Exp $

class AddNode
  def initialize(left,right)
    @left = left
    @right = right
  end
end

class MinusNode
  def initialize(left,right)
    @left = left
    @right = right
  end
end

class MultipleNode
  def initialize(left,right)
    @left = left
    @right = right
  end
end

class DevNode
  def initialize(left,right)
    @left = left
    @right = right
  end
end

class ModNode
  def initialize(left,right)
    @left = left
    @right = right
  end
end

---- inner

  def initialize()
    @var = {}
    @nodes = []
  end

  def parse(str)
    @q = []
    until str.empty?
      case str
      when /\A\s+/
      when /\A\d+\.?\d*/
        @q.push [:NUMBER, $&.to_f]
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
while true
  puts
  print '? '
  str = gets.chop!
  break if /q/i =~ str
  begin
    puts "= #{parser.parse(str)}"
  rescue ParseError
    puts $!
  end
end
