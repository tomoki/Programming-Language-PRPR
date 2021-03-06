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

class Prprp < Racc::Parser

module_eval <<'..end prpr.y modeval..id1d3bac2ab7', 'prpr.y', 296

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

..end prpr.y modeval..id1d3bac2ab7

##### racc 1.4.5 generates ###

racc_reduce_table = [
 0, 0, :racc_error,
 1, 32, :_reduce_none,
 0, 32, :_reduce_2,
 3, 33, :_reduce_3,
 3, 33, :_reduce_4,
 3, 33, :_reduce_5,
 3, 33, :_reduce_6,
 3, 33, :_reduce_7,
 3, 33, :_reduce_8,
 3, 33, :_reduce_9,
 3, 33, :_reduce_10,
 3, 33, :_reduce_11,
 3, 33, :_reduce_12,
 2, 33, :_reduce_13,
 4, 33, :_reduce_14,
 6, 33, :_reduce_15,
 6, 33, :_reduce_16,
 4, 33, :_reduce_17,
 2, 33, :_reduce_18,
 3, 33, :_reduce_19,
 3, 33, :_reduce_20,
 2, 33, :_reduce_21,
 3, 33, :_reduce_22,
 1, 33, :_reduce_23,
 1, 33, :_reduce_24,
 1, 33, :_reduce_25,
 0, 34, :_reduce_26,
 1, 34, :_reduce_27,
 3, 34, :_reduce_28 ]

racc_reduce_n = 29

racc_shift_n = 61

racc_action_table = [
    17,    18,    19,    20,    21,    22,    23,    24,    15,    16,
    11,    17,    18,    19,    20,    34,     6,    31,     8,    25,
    32,    12,    11,    46,     1,     3,     4,     5,     6,     7,
     8,     9,    10,    12,    11,    14,     1,     3,     4,     5,
     6,     7,     8,     9,    10,    12,    11,    35,     1,     3,
     4,     5,     6,     7,     8,     9,    10,    12,    11,    52,
     1,     3,     4,     5,     6,     7,     8,     9,    10,    12,
    11,   nil,     1,     3,     4,     5,     6,     7,     8,     9,
    10,    12,    11,   nil,     1,     3,     4,     5,     6,     7,
     8,     9,    10,    12,    11,   nil,     1,     3,     4,     5,
     6,     7,     8,     9,    10,    12,    11,   nil,     1,     3,
     4,     5,     6,     7,     8,     9,    10,    12,    11,   nil,
     1,     3,     4,     5,     6,     7,     8,     9,    10,    12,
    11,   nil,     1,     3,     4,     5,     6,     7,     8,     9,
    10,    12,    11,   nil,     1,     3,     4,     5,     6,     7,
     8,     9,    10,    12,    11,   nil,     1,     3,     4,     5,
     6,     7,     8,     9,    10,    12,    11,   nil,     1,     3,
     4,     5,     6,     7,     8,     9,    10,    12,    11,   nil,
     1,     3,     4,     5,     6,     7,     8,     9,    10,    12,
    11,   nil,     1,     3,     4,     5,     6,     7,     8,     9,
    10,    12,    11,   nil,     1,     3,     4,     5,     6,     7,
     8,     9,    10,    12,    11,   nil,     1,     3,     4,     5,
     6,     7,     8,     9,    10,    12,    11,   nil,     1,     3,
     4,     5,     6,     7,     8,     9,    10,    12,    11,   nil,
     1,     3,     4,     5,     6,     7,     8,     9,    10,    12,
    11,   nil,     1,     3,     4,     5,     6,     7,     8,     9,
    10,    12,    11,   nil,     1,     3,     4,     5,     6,     7,
     8,     9,    10,    12,    11,   nil,     1,     3,     4,     5,
     6,     7,     8,     9,    10,    12,   nil,   nil,     1,     3,
     4,     5,   nil,     7,    47,     9,    10,    17,    18,    19,
    20,    21,    22,    23,    24,    15,    16,    48,    17,    18,
    19,    20,    17,    18,    19,    58,    17,    18,    19,    20,
    21,    22,    23,    24,    15,    16,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    51,    17,    18,    19,    20,    21,    22,
    23,    24,    15,    16,   nil,   nil,   nil,   nil,   nil,    57,
    17,    18,    19,    20,    21,    22,    23,    24,    15,    16,
   nil,   nil,   nil,   nil,    49,    17,    18,    19,    20,    21,
    22,    23,    24,    15,    16,    17,    18,    19,    20,    21,
    22,    23,    24,    15,    16,    17,    18,    19,    20,    21,
    22,    23,    24,    15,    16,    17,    18,    19,    20,    21,
    22,    23,    24,   -29,   -29,    17,    18,    19,    20,    21,
    22,    23,    24,   -29,   -29,    17,    18,    19,    20,    21,
    22,    23,    24,    15,    16,    17,    18,    19,    20,    21,
    22,    23,    24,    15,    16,    17,    18,    19,    20,    21,
    22,    23,    24,    15,    16,    17,    18,    19,    20,    21,
    22,    23,    24,    15,    16,    17,    18,    19,    20,    21,
    22,    23,    24,    15,    16,    17,    18,    19,    20,    21,
    22,   -29,   -29,    17,    18,    19,    20,    21,    22,   -29,
   -29 ]

racc_action_check = [
    26,    26,    26,    26,    26,    26,    26,    26,    26,    26,
    49,    43,    43,    43,    43,    13,    49,    10,    49,     4,
    11,    49,    57,    26,    49,    49,    49,    49,    57,    49,
    57,    49,    49,    57,    31,     1,    57,    57,    57,    57,
    31,    57,    31,    57,    57,    31,     5,    14,    31,    31,
    31,    31,     5,    31,     5,    31,    31,     5,     6,    34,
     5,     5,     5,     5,     6,     5,     6,     5,     5,     6,
     7,   nil,     6,     6,     6,     6,     7,     6,     7,     6,
     6,     7,     8,   nil,     7,     7,     7,     7,     8,     7,
     8,     7,     7,     8,    35,   nil,     8,     8,     8,     8,
    35,     8,    35,     8,     8,    35,    51,   nil,    35,    35,
    35,    35,    51,    35,    51,    35,    35,    51,    12,   nil,
    51,    51,    51,    51,    12,    51,    12,    51,    51,    12,
    58,   nil,    12,    12,    12,    12,    58,    12,    58,    12,
    12,    58,    47,   nil,    58,    58,    58,    58,    47,    58,
    47,    58,    58,    47,    15,   nil,    47,    47,    47,    47,
    15,    47,    15,    47,    47,    15,     0,   nil,    15,    15,
    15,    15,     0,    15,     0,    15,    15,     0,    17,   nil,
     0,     0,     0,     0,    17,     0,    17,     0,     0,    17,
    18,   nil,    17,    17,    17,    17,    18,    17,    18,    17,
    17,    18,    19,   nil,    18,    18,    18,    18,    19,    18,
    19,    18,    18,    19,    20,   nil,    19,    19,    19,    19,
    20,    19,    20,    19,    19,    20,    21,   nil,    20,    20,
    20,    20,    21,    20,    21,    20,    20,    21,    22,   nil,
    21,    21,    21,    21,    22,    21,    22,    21,    21,    22,
    23,   nil,    22,    22,    22,    22,    23,    22,    23,    22,
    22,    23,    24,   nil,    23,    23,    23,    23,    24,    23,
    24,    23,    23,    24,    16,   nil,    24,    24,    24,    24,
    16,    24,    16,    24,    24,    16,   nil,   nil,    16,    16,
    16,    16,   nil,    16,    29,    16,    16,    56,    56,    56,
    56,    56,    56,    56,    56,    56,    56,    29,    42,    42,
    42,    42,    41,    41,    41,    56,    33,    33,    33,    33,
    33,    33,    33,    33,    33,    33,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    33,    55,    55,    55,    55,    55,    55,
    55,    55,    55,    55,   nil,   nil,   nil,   nil,   nil,    55,
    30,    30,    30,    30,    30,    30,    30,    30,    30,    30,
   nil,   nil,   nil,   nil,    30,    28,    28,    28,    28,    28,
    28,    28,    28,    28,    28,    60,    60,    60,    60,    60,
    60,    60,    60,    60,    60,    27,    27,    27,    27,    27,
    27,    27,    27,    27,    27,    36,    36,    36,    36,    36,
    36,    36,    36,    36,    36,    37,    37,    37,    37,    37,
    37,    37,    37,    37,    37,    54,    54,    54,    54,    54,
    54,    54,    54,    54,    54,    50,    50,    50,    50,    50,
    50,    50,    50,    50,    50,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,    59,    59,    59,    59,    59,
    59,    59,    59,    59,    59,    53,    53,    53,    53,    53,
    53,    53,    53,    53,    53,    45,    45,    45,    45,    45,
    45,    45,    45,    44,    44,    44,    44,    44,    44,    44,
    44 ]

racc_action_pointer = [
   158,    12,   432,   nil,    -4,    38,    50,    62,    74,   nil,
     4,    -9,   110,    15,    27,   146,   266,   170,   182,   194,
   206,   218,   230,   242,   254,   nil,    -3,   382,   362,   279,
   347,    26,   nil,   313,    59,    86,   392,   402,   nil,   nil,
   nil,   309,   305,     8,   470,   462,   nil,   134,   nil,     2,
   422,    98,   nil,   452,   412,   331,   294,    14,   122,   442,
   372 ]

racc_action_default = [
    -2,   -29,    -1,   -25,   -29,   -29,   -29,   -26,   -29,   -23,
   -24,   -29,   -29,   -29,   -29,   -29,   -29,   -29,   -29,   -29,
   -29,   -29,   -29,   -29,   -29,   -18,   -29,   -13,   -27,   -29,
   -29,   -29,   -21,   -29,   -29,   -29,   -11,   -10,    -5,    -6,
    -7,    -8,    -3,    -4,    -9,   -12,   -19,   -29,   -20,   -29,
   -22,   -29,    61,   -17,   -28,   -14,   -29,   -29,   -29,   -15,
   -16 ]

racc_goto_table = [
     2,    13,    29,   nil,   nil,    26,    27,    28,    30,   nil,
   nil,   nil,    33,   nil,   nil,    36,    37,    38,    39,    40,
    41,    42,    43,    44,    45,   nil,   nil,   nil,   nil,   nil,
   nil,    50,   nil,   nil,   nil,    53,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    54,   nil,    55,
   nil,    56,   nil,   nil,   nil,   nil,   nil,    59,    60 ]

racc_goto_check = [
     2,     1,     3,   nil,   nil,     2,     2,     2,     2,   nil,
   nil,   nil,     2,   nil,   nil,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,   nil,   nil,   nil,   nil,   nil,
   nil,     2,   nil,   nil,   nil,     2,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,     2,   nil,     2,
   nil,     2,   nil,   nil,   nil,   nil,   nil,     2,     2 ]

racc_goto_pointer = [
   nil,     1,     0,    -5 ]

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
 :LABEL => 22,
 :STRING => 23,
 :GOTO => 24,
 "(" => 25,
 ")" => 26,
 "{" => 27,
 "}" => 28,
 :NUMBER => 29,
 :VAR => 30 }

racc_use_result_var = true

racc_nt_base = 31

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
'LABEL',
'STRING',
'GOTO',
'"("',
'")"',
'"{"',
'"}"',
'NUMBER',
'VAR',
'$start',
'target',
'exp',
'explist']

Racc_debug_parser = false

##### racc system variables end #####

 # reduce 0 omitted

 # reduce 1 omitted

module_eval <<'.,.,', 'prpr.y', 19
  def _reduce_2( val, _values, result )
 result = NumberNode.new(0)
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 21
  def _reduce_3( val, _values, result )
 result = AddNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 22
  def _reduce_4( val, _values, result )
 result = MinusNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 23
  def _reduce_5( val, _values, result )
 result = MultipleNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 24
  def _reduce_6( val, _values, result )
 result = DevNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 25
  def _reduce_7( val, _values, result )
 result = ModNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 26
  def _reduce_8( val, _values, result )
 result = PowerNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 27
  def _reduce_9( val, _values, result )
 result = IsNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 28
  def _reduce_10( val, _values, result )
 result = BiggerNode.new(val[2],val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 29
  def _reduce_11( val, _values, result )
 result = BiggerNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 30
  def _reduce_12( val, _values, result )
 result = IsNotNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 31
  def _reduce_13( val, _values, result )
 result = PrintNode.new(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 32
  def _reduce_14( val, _values, result )
 result = IfNode.new(val[1],val[3])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 33
  def _reduce_15( val, _values, result )
 result = IfElseNode.new(val[1],val[3],val[5])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 34
  def _reduce_16( val, _values, result )
 result = ForNode.new(val[1],val[3],val[5])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 35
  def _reduce_17( val, _values, result )
 result=LabelNode.new(val[1],val[3])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 36
  def _reduce_18( val, _values, result )
 result = GotoNode.new(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 37
  def _reduce_19( val, _values, result )
 result = val[1]
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 38
  def _reduce_20( val, _values, result )
result = BlockNode.new(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 39
  def _reduce_21( val, _values, result )
 result = UMinusNode.new(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 40
  def _reduce_22( val, _values, result )
 result = EqualNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 41
  def _reduce_23( val, _values, result )
result = NumberNode.new(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 42
  def _reduce_24( val, _values, result )
 result = VarNode.new(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 43
  def _reduce_25( val, _values, result )
 result = StringNode.new(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 45
  def _reduce_26( val, _values, result )
result = []
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 46
  def _reduce_27( val, _values, result )
result=[val[0]]
   result
  end
.,.,

module_eval <<'.,.,', 'prpr.y', 47
  def _reduce_28( val, _values, result )
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
