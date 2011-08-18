#
# DO NOT MODIFY!!!!
# This file is automatically generated by racc 1.4.5
# from racc grammer file "prpr.y".
#

require 'racc/parser'



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

class Prprp < Racc::Parser

module_eval <<'..end prpr.y modeval..iddbe0c3cc77', 'prpr.y', 274

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

..end prpr.y modeval..iddbe0c3cc77

##### racc 1.4.5 generates ###

racc_reduce_table = [
 0, 0, :racc_error,
 1, 30, :_reduce_none,
 0, 30, :_reduce_2,
 3, 31, :_reduce_3,
 3, 31, :_reduce_4,
 3, 31, :_reduce_5,
 3, 31, :_reduce_6,
 3, 31, :_reduce_7,
 3, 31, :_reduce_8,
 3, 31, :_reduce_9,
 3, 31, :_reduce_10,
 3, 31, :_reduce_11,
 3, 31, :_reduce_12,
 2, 31, :_reduce_13,
 4, 31, :_reduce_14,
 6, 31, :_reduce_15,
 6, 31, :_reduce_16,
 3, 31, :_reduce_17,
 3, 31, :_reduce_18,
 2, 31, :_reduce_19,
 3, 31, :_reduce_20,
 1, 31, :_reduce_21,
 1, 31, :_reduce_22,
 1, 31, :_reduce_23,
 0, 32, :_reduce_24,
 1, 32, :_reduce_25,
 3, 32, :_reduce_26 ]

racc_reduce_n = 27

racc_shift_n = 55

racc_action_table = [
     8,    18,    33,    23,    24,    25,     3,    16,     6,    20,
    37,     9,    32,   nil,     1,     8,     2,   nil,     4,     5,
     7,     3,   nil,     6,   nil,   nil,     9,   nil,   nil,     1,
     8,     2,   nil,     4,     5,     7,     3,   nil,     6,   nil,
   nil,     9,   nil,   nil,     1,     8,     2,   nil,     4,     5,
     7,     3,   nil,     6,   nil,   nil,     9,   nil,   nil,     1,
     8,     2,   nil,     4,     5,     7,     3,   nil,     6,   nil,
   nil,     9,   nil,   nil,     1,     8,     2,   nil,     4,     5,
     7,     3,   nil,     6,   nil,   nil,     9,   nil,   nil,     1,
     8,     2,   nil,     4,     5,     7,     3,   nil,     6,   nil,
   nil,     9,   nil,   nil,     1,     8,     2,   nil,     4,     5,
     7,     3,   nil,     6,   nil,   nil,     9,   nil,   nil,     1,
     8,     2,   nil,     4,     5,     7,     3,   nil,     6,   nil,
   nil,     9,   nil,   nil,     1,     8,     2,   nil,     4,     5,
     7,     3,   nil,     6,   nil,   nil,     9,   nil,   nil,     1,
   nil,     2,   nil,     4,     5,     7,    23,    24,    25,    26,
    27,    28,    29,    30,    21,    22,     8,    23,    24,    25,
    26,   nil,     3,   nil,     6,   nil,    31,     9,   nil,   nil,
     1,     8,     2,   nil,     4,     5,     7,     3,   nil,     6,
   nil,   nil,     9,   nil,   nil,     1,     8,     2,   nil,     4,
     5,     7,     3,   nil,     6,   nil,   nil,     9,   nil,   nil,
     1,     8,     2,   nil,     4,     5,     7,     3,   nil,     6,
   nil,   nil,     9,   nil,   nil,     1,     8,     2,   nil,     4,
     5,     7,     3,   nil,     6,   nil,   nil,     9,   nil,   nil,
     1,     8,     2,   nil,     4,     5,     7,     3,   nil,     6,
   nil,   nil,     9,   nil,   nil,     1,     8,     2,   nil,     4,
     5,     7,     3,   nil,     6,   nil,   nil,     9,   nil,   nil,
     1,     8,     2,   nil,     4,     5,     7,     3,   nil,     6,
   nil,   nil,     9,   nil,   nil,     1,     8,     2,   nil,     4,
     5,     7,     3,   nil,     6,   nil,   nil,     9,   nil,   nil,
     1,     8,     2,   nil,     4,     5,     7,     3,   nil,     6,
   nil,   nil,     9,   nil,   nil,     1,     8,     2,   nil,     4,
     5,     7,     3,   nil,     6,   nil,   nil,     9,   nil,   nil,
     1,     8,     2,   nil,     4,     5,     7,     3,   nil,     6,
   nil,   nil,     9,   nil,   nil,     1,   nil,     2,   nil,     4,
     5,     7,    23,    24,    25,    26,    27,    28,    29,    30,
    21,    22,    23,    24,    25,    26,    27,    28,    29,   -27,
    52,    23,    24,    25,    26,    27,    28,    29,    30,    21,
    22,    23,    24,    25,    26,    27,    28,   -27,    36,    23,
    24,    25,    26,    27,    28,    29,    30,    21,    22,    23,
    24,    25,    26,   nil,    51,    23,    24,    25,    26,    27,
    28,    29,    30,    21,    22,   nil,   nil,   nil,   nil,    35,
    23,    24,    25,    26,    27,    28,    29,    30,    21,    22,
    23,    24,    25,    26,    27,    28,    29,    30,    21,    22,
    23,    24,    25,    26,    27,    28,    29,    30,    21,    22,
    23,    24,    25,    26,    27,    28,    29,    30,    21,    22,
    23,    24,    25,    26,    27,    28,    29,    30,    21,    22,
    23,    24,    25,    26,    27,    28,    29,    30,    21,   -27,
    23,    24,    25,    26,    27,    28,    29,    30,    21,    22,
    23,    24,    25,    26,    27,    28,    29,    30,    21,    22,
    23,    24,    25,    26,    27,    28,    29,    30,   -27 ]

racc_action_check = [
     0,     8,    14,    43,    43,    43,     0,     5,     0,    10,
    20,     0,    14,   nil,     0,     1,     0,   nil,     0,     0,
     0,     1,   nil,     1,   nil,   nil,     1,   nil,   nil,     1,
     2,     1,   nil,     1,     1,     1,     2,   nil,     2,   nil,
   nil,     2,   nil,   nil,     2,     3,     2,   nil,     2,     2,
     2,     3,   nil,     3,   nil,   nil,     3,   nil,   nil,     3,
    52,     3,   nil,     3,     3,     3,    52,   nil,    52,   nil,
   nil,    52,   nil,   nil,    52,     6,    52,   nil,    52,    52,
    52,     6,   nil,     6,   nil,   nil,     6,   nil,   nil,     6,
    51,     6,   nil,     6,     6,     6,    51,   nil,    51,   nil,
   nil,    51,   nil,   nil,    51,     9,    51,   nil,    51,    51,
    51,     9,   nil,     9,   nil,   nil,     9,   nil,   nil,     9,
    36,     9,   nil,     9,     9,     9,    36,   nil,    36,   nil,
   nil,    36,   nil,   nil,    36,    35,    36,   nil,    36,    36,
    36,    35,   nil,    35,   nil,   nil,    35,   nil,   nil,    35,
   nil,    35,   nil,    35,    35,    35,    12,    12,    12,    12,
    12,    12,    12,    12,    12,    12,    33,    44,    44,    44,
    44,   nil,    33,   nil,    33,   nil,    12,    33,   nil,   nil,
    33,    30,    33,   nil,    33,    33,    33,    30,   nil,    30,
   nil,   nil,    30,   nil,   nil,    30,    29,    30,   nil,    30,
    30,    30,    29,   nil,    29,   nil,   nil,    29,   nil,   nil,
    29,    16,    29,   nil,    29,    29,    29,    16,   nil,    16,
   nil,   nil,    16,   nil,   nil,    16,    28,    16,   nil,    16,
    16,    16,    28,   nil,    28,   nil,   nil,    28,   nil,   nil,
    28,    27,    28,   nil,    28,    28,    28,    27,   nil,    27,
   nil,   nil,    27,   nil,   nil,    27,    25,    27,   nil,    27,
    27,    27,    25,   nil,    25,   nil,   nil,    25,   nil,   nil,
    25,    21,    25,   nil,    25,    25,    25,    21,   nil,    21,
   nil,   nil,    21,   nil,   nil,    21,    22,    21,   nil,    21,
    21,    21,    22,   nil,    22,   nil,   nil,    22,   nil,   nil,
    22,    23,    22,   nil,    22,    22,    22,    23,   nil,    23,
   nil,   nil,    23,   nil,   nil,    23,    24,    23,   nil,    23,
    23,    23,    24,   nil,    24,   nil,   nil,    24,   nil,   nil,
    24,    26,    24,   nil,    24,    24,    24,    26,   nil,    26,
   nil,   nil,    26,   nil,   nil,    26,   nil,    26,   nil,    26,
    26,    26,    50,    50,    50,    50,    50,    50,    50,    50,
    50,    50,    47,    47,    47,    47,    47,    47,    47,    47,
    50,    19,    19,    19,    19,    19,    19,    19,    19,    19,
    19,    46,    46,    46,    46,    46,    46,    46,    19,    49,
    49,    49,    49,    49,    49,    49,    49,    49,    49,    45,
    45,    45,    45,   nil,    49,    17,    17,    17,    17,    17,
    17,    17,    17,    17,    17,   nil,   nil,   nil,   nil,    17,
    11,    11,    11,    11,    11,    11,    11,    11,    11,    11,
    15,    15,    15,    15,    15,    15,    15,    15,    15,    15,
    13,    13,    13,    13,    13,    13,    13,    13,    13,    13,
    53,    53,    53,    53,    53,    53,    53,    53,    53,    53,
    48,    48,    48,    48,    48,    48,    48,    48,    48,    48,
    39,    39,    39,    39,    39,    39,    39,    39,    39,    39,
    34,    34,    34,    34,    34,    34,    34,    34,    34,    34,
    54,    54,    54,    54,    54,    54,    54,    54,    54,    54,
    38,    38,    38,    38,    38,    38,    38,    38,    38 ]

racc_action_pointer = [
    -8,     7,    22,    37,   nil,    -6,    67,   nil,   -25,    97,
     9,   417,   153,   437,   -13,   427,   203,   402,   nil,   368,
    10,   263,   278,   293,   308,   248,   323,   233,   218,   188,
   173,   nil,   nil,   158,   477,   127,   112,   nil,   497,   467,
   nil,   nil,   nil,     0,   164,   396,   378,   359,   457,   386,
   349,    82,    52,   447,   487 ]

racc_action_default = [
    -2,   -27,   -24,   -27,   -21,   -22,   -27,   -23,   -27,   -27,
   -27,    -1,   -27,   -25,   -27,   -13,   -27,   -27,   -19,   -27,
   -27,   -27,   -27,   -27,   -27,   -27,   -27,   -27,   -27,   -27,
   -27,   -17,   -18,   -27,   -20,   -27,   -27,    55,   -11,   -10,
    -5,    -6,    -7,    -8,    -3,    -4,    -9,   -12,   -26,   -14,
   -27,   -27,   -27,   -15,   -16 ]

racc_goto_table = [
    11,    12,    13,    15,    10,    14,    17,   nil,   nil,    19,
   nil,   nil,   nil,   nil,   nil,   nil,    34,   nil,   nil,   nil,
   nil,    38,    39,    40,    41,    42,    43,    44,    45,    46,
    47,   nil,   nil,    48,   nil,    49,    50,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,    53,    54 ]

racc_goto_check = [
     2,     2,     2,     2,     1,     3,     2,   nil,   nil,     2,
   nil,   nil,   nil,   nil,   nil,   nil,     2,   nil,   nil,   nil,
   nil,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,   nil,   nil,     2,   nil,     2,     2,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,     2,     2 ]

racc_goto_pointer = [
   nil,     4,     0,     3 ]

racc_goto_default = [
   nil,   nil,   nil,   nil ]

racc_token_table = {
 false => 0,
 Object.new => 1,
 :UMINUS => 2,
 "*" => 3,
 "/" => 4,
 :MOD => 5,
 "^" => 6,
 "+" => 7,
 "-" => 8,
 :IS => 9,
 :ISNOT => 10,
 ">" => 11,
 "<" => 12,
 "=" => 13,
 :PRINT => 14,
 ";" => 15,
 :IF => 16,
 :THEN => 17,
 :ELSE => 18,
 :FOR => 19,
 :TO => 20,
 :DO => 21,
 "(" => 22,
 ")" => 23,
 "{" => 24,
 "}" => 25,
 :NUMBER => 26,
 :VAR => 27,
 :STRING => 28 }

racc_use_result_var = true

racc_nt_base = 29

Racc_arg = [
 racc_action_table,
 racc_action_check,
 racc_action_default,
 racc_action_pointer,
 racc_goto_table,
 racc_goto_check,
 racc_goto_default,
 racc_goto_pointer,
 racc_nt_base,
 racc_reduce_table,
 racc_token_table,
 racc_shift_n,
 racc_reduce_n,
 racc_use_result_var ]

Racc_token_to_s_table = [
'$end',
'error',
'UMINUS',
'"*"',
'"/"',
'MOD',
'"^"',
'"+"',
'"-"',
'IS',
'ISNOT',
'">"',
'"<"',
'"="',
'PRINT',
'";"',
'IF',
'THEN',
'ELSE',
'FOR',
'TO',
'DO',
'"("',
'")"',
'"{"',
'"}"',
'NUMBER',
'VAR',
'STRING',
'$start',
'target',
'exp',
'explist']

Racc_debug_parser = false

##### racc system variables end #####

 # reduce 0 omitted

 # reduce 1 omitted

module_eval <<'.,.,', 'prpr.y', 22
  def _reduce_2( val, _values, result )
 result = NumberNode.new(0)
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 24
  def _reduce_3( val, _values, result )
 result = AddNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 25
  def _reduce_4( val, _values, result )
 result = MinusNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 26
  def _reduce_5( val, _values, result )
 result = MultipleNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 27
  def _reduce_6( val, _values, result )
 result = DevNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 28
  def _reduce_7( val, _values, result )
 result = ModNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 29
  def _reduce_8( val, _values, result )
 result = PowerNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 30
  def _reduce_9( val, _values, result )
 result = IsNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 31
  def _reduce_10( val, _values, result )
 result = BiggerNode.new(val[2],val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 32
  def _reduce_11( val, _values, result )
 result = BiggerNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 33
  def _reduce_12( val, _values, result )
 result = IsNotNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 34
  def _reduce_13( val, _values, result )
 result = PrintNode.new(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 35
  def _reduce_14( val, _values, result )
 result = IfNode.new(val[1],val[3])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 36
  def _reduce_15( val, _values, result )
 result = IfElseNode.new(val[1],val[3],val[5])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 37
  def _reduce_16( val, _values, result )
 result = ForNode.new(val[1],val[3],val[5])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 38
  def _reduce_17( val, _values, result )
 result = val[1]
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 39
  def _reduce_18( val, _values, result )
result = BlockNode.new(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 40
  def _reduce_19( val, _values, result )
 result = UMinusNode.new(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 41
  def _reduce_20( val, _values, result )
 result = EqualNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 42
  def _reduce_21( val, _values, result )
result = NumberNode.new(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 43
  def _reduce_22( val, _values, result )
 result = VarNode.new(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 44
  def _reduce_23( val, _values, result )
 result = StringNode.new(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 46
  def _reduce_24( val, _values, result )
result = []
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 47
  def _reduce_25( val, _values, result )
result=[val[0]]
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 48
  def _reduce_26( val, _values, result )
result=val[0] << val[2]
   result
  end
.,.,

 def _reduce_none( val, _values, result )
  result
 end

end   # class Prprp

class Env
  def initialize()
    @var_table = {}
    @for_table = {}
  end
  def var_table
    return @var_table
  end
  def for_table
    return for_table
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
