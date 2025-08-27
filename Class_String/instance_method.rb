#インスタンスメソッド


self % args -> String
#printfと同じ規則に従ってargsをフォーマットする
#[PARAM]args: フォーマットする値、もしくはその配列
#[RETURN]: フォーマットされた文字列
p "i = %d" % 10# => "i=10"
p "i = %x" % 10# => "i=a"
p "i = %o" % 10# => "i=12"

p "i = %#d" % 10# => "i=10"
p "i = %#x" % 10# => "i=0xa"
p "i = %#o" % 10# => "i=012"

p "%d" % 10# => "10"
p "%d, %o" % [10, 10]# => "10, 12"

#sprintf フォーマット
#Rubyのsprintfフォーマットは基本的にC言語のsprintfと同じ。整数の大きさに上限はなく、負の数を与えると、..fのような表示をする。（%+x, %xのように指定して、絶対値に符号をつけた形で出力させる)
%[nth$][フラグ][幅][.精度]指示子
%[<name>][フラグ][幅][.精度]指示子

#フラグ: #,+,スペース,-,0の5種類がある
#"#"について、2,8,16進数の指示子にはそれぞれプレフィックスとして"0b","0B"などを付加する。
p sprintf("%#b", 10)# => "0b1010"
p sprintf("%#B", 10)# => "0B1010"
p sprintf("%#b", 0)# => "0"
p sprintf("%#o", 10)# => "012"
p sprintf("%#x", 10)# => "0xa"
p sprintf("%#X", 10)# => "0XA"

#浮動小数点数の場合は必ず出力に"."をつける。
p sprintf("%.0f", 10)# => "10"
p sprintf("%#.0f", 10)# => "10."
p sprintf("%.0e", 10)# => "1e+01"
p sprintf("%#.0e", 10)# => "1.e+01"

#g,Gでは上記に加えて末尾の余分な0が残る
p sprintf("%.05g", 10)# => "10"
p sprintf("%#.05g", 10)# => "10.000"

#"+"について、出力文字列を符号付きにする。
p sprintf("%d", 1)# => "1"
p sprintf("%+d", 1)# => "+1"
p sprintf("%x", -1)# => "..f" (fが無限に続くことを意味している)
p sprintf("%+x", -1)# => "-1"

#"スペース"について、"+"と同じだが、正の符号の代わりに空白を使う。
p sprintf("%d", 1)# => "1"
p sprintf("%+d", 1)# => "+1"
p sprintf("% d", 1)# => " 1"
p sprintf("%x", -1)# => "..f"
p sprintf("% x", 1)# => " 1"
p sprintf("% x", -1)# => "-1"

#"-"について、出力を左詰めにする。幅の指定がないと意味がない。

#"0"について、出力が右詰めの場合に余った部分に空白の代わりに0を詰める。
p sprintf("%010d", 10)# => "0000000010"
p sprintf("%#010x", 10)# => "0x0000000a"
p sprintf("%#010o", 10)# => "0000000012"
p sprintf("%#010b", 10)# => "0b00001010"
p sprintf("%#10.8x", 10)# => "0x0000000a"
p sprintf("%#10.9o", 10)# => "0000000012"
p sprintf("%#10.8b", 10)# => "0b00001010"
p sprintf("%#10x", 10)# => "       0xa"
p sprintf("%#10o", 10)# => "       012"
p self("%#10b", 10)# => "    0b1010"

#幅: 0以外の数字で始まる数字列は幅指定になる。幅は生成文字列の長さを示し、精度の値によらずこの幅分だけの文字列が生成される。
p sprintf("%+5d", 11)# => "  +11"
p sprintf("%+-5d", 11)# => "+11  "
p sprintf("%+05d", 11)# => "+0011"
#指定した幅を超える場合は幅の指定は無効となり、幅として*を指定すると幅の値を引数から得ることになる。
p sprintf("%#05x", 10)# => "0x00a"
p sprintf("%#0*x", 5, 10)# => "0x00a"

#精度: "."の後に続く数字列は精度を表す。精度は整数の指示子に対しては、数値列部分の長さを意味する。
p sprintf("%10.5d", 1)# => "     00001"
p sprintf("%#10.5x", 1)# => "   0x00001"
p sprintf("%+10.5x", 1)# => "     00001"
p sprintf("%10.5f", 1)# => "   1.00000"
p sprintf("%10.5f", 10)# => "  10.00000"
p sprintf("%10.5e", 1)# => "1.00000e+00"
p sprintf("%10.5e", 10)# => "1.00000e+01"
p sprintf("%10.5g", 10)# => "        10"
p sprintf("%#10.5G", 10)# => "    10.000"
p sprintf("%10.2s", "foo")# => "        fo"
p sprintf("%5.5s", "foo")# => "  foo"
p sprintf("%5.5s", "foobar")# => "fooba"
p sprintf("%.5s", "foobar")# => "fooba"
p sprintf("%.*s", 5, "foobar")# => "fooba"

#指示子: 引数の型の解釈を示す。省略することはできない。
#文字列を表す指示子: c, s, p
#整数を表す指示子: d, i, u, b, B, o, x, X
#浮動小数点数を表す指示子: f, g, e, E, G

#"c"について、引数の数値0-255を文字コードとみなして対応する文字を出力する。フラグと幅の指定だけが意味を持つ。to_intメソッド
p sprintf("%c", 97)# => "a"
p sprintf("%c", 'a')# => "a"

#"s"について、文字列を出力する。to_sメソッド

#"p"について、Object#inspectの結果を出力します。
p sprintf("%s", /e+/)# => "(?-mix:e+)"
p sprintf("%p", /e+/)# => "/e+/"

#"d, i"について、引数の数値を10進表現の整数として出力する。
p sprintf("%d", -1)# => "-1"
p sprintf("%d", 3.1)# => "3"
p sprintf("%d", '0b1010')# => "10"

#"u"について、引数の数値を符号なし整数とみなして10進表現の整数として出力する。
p sprintf("%u", '0b1010')# => "10"
p sprintf("%u", -1)# => "-1"

#"b, B, o, x, X"について、整数をそれぞれ2進、2進(大文字)、8進、16進、16進(大文字)表現の文字列で出力する。
p sprintf("%#b", 10)# => "0b1010"
p sprintf("%#B", 10)# => "0B1010"
p sprintf("%#o", 10)# => "012"
p sprintf("%#x", 10)# => "0xa"
p sprintf("%#X", 10)# => "0XA"

#負の数に対しては".."が付加される。
p sprintf("%#b", -1)# => "0b..1"
p sprintf("%#o", -1)# => "0..7"
p sprintf("%#x", -1)# => "0x..f"
p sprintf("%10x", -1)# => "       ..f"
p sprintf("%-10x", -1)# => "..f       "
p sprintf("%.10x", -1)# => "..ffffffff"

#"f, e, E, g, G, a, A"について、
#"f"は小数点表現で数値を出力する
#"e"は指数表現で数値を出力する
#"g"は指数が-4より小さいか精度以上の場合にeと同じ出力を、それ以外では"f"と同じ出力を行う。ただし、小数部の末尾のは取り除かれる。
#"a, A"は指数表現の16進数で数値を出力する。
p sprintf("%a", -0.0)# => "-0x0p+0"
p sprintf("%a", 729.0/10)# => "0x1.239999999999ap+6"
p sprintf("%a", Float::INFINITY)# => "Inf"

p sprintf("%f", 1.0)# => "1.000000"
p sprintf("%e", 1.0)# => "1.000000e+00"
p sprintf("%g", 1.0)# => "1"
p sprintf("%f", 10.1)# => "10.100000"
p sprintf("%e", 10.1)# => "1.010000e+01"
p sprintf("%g", 10.1)# => "10.1"
p sprintf("%g", 10 ** 6)# => "1e+06"
p sprintf("%g", 10 ** -5)# => "1e-05"

#無限大に対する出力
p sprintf("%f", 1.0/0)# => "inf"
p sprintf("%f", -1.0/0)# => "-inf"
p sprintf("%f", 0.0/0)# => "nan"
p sprintf("%E", 1.0/0)# => "INF"
p sprintf("%E", -1.0/0)# => "-INF"
p sprintf("%E", 0.0/0)# => "NAN"

#引数指定:
#nath$: nth番目の引数のフォーマットを行うことを示す。
p sprintf("%d, %x, %o", 1, 2, 3)# => "1, 2, 3"
#何番目の引数を使うかを$で指定
p sprintf("%3$d, %2$x, %1$o", 1, 2, 3)# => "3, 2, 1"
p sprintf("%1$d, %1$x, %1$o", 10)# => "10, a, 12"

case ENV['LC_TIME']
when /^ja_JP/
    fmt = "%1$d年%2$d月%3$d日"
else
    fmt = "%2$02d/%03$2d/%1$02d"
end

p sprintf(fmt, 1, 4, 22)# => "04/22/01"

p sprintf("%5.2f", 1)# => " 1.00"
p sprintf("%*.*f", 5, 2, 1)# => " 1.00"
#一つのフォーマットにあとから精度などを付加していく。
p sprintf("%1$*2$.*3$f", 1, 5, 2)# => " 1.00"

#%<name>: SymbolのインスタンスnameをキーとするHashを引数にした場合、対応する値をフォーマットして参照する。
p sprintf('%<foo>f : %<bar>+d', foo: 1, bar: 2)# => "1.000000 : +2"


self * times -> String


#文字列の内容をtimes回だけ繰り返した文字列を作成して返す。
#[PARAM]times: 整数
#[RETURN]: selfをtimes回繰り返した新しい文字列
#[EXCEPTION]ArgumentError: 引数に負数を指定したときに発生する。
p "str" * 3# => "strstrstr"

str = "abc"
p str * 4# => "abcabcabcabc"
p str * 0# => ""
p str# => "abc"(変化なし)


self + other -> String
#文字列とotherを連結した新しい文字列を返す。
#[PARAM]other: 文字列
#[RETURN]: selfとotherを連結した文字列
p "str" + "ing"# => "string"

a = "abc"
b = "def"
p a +b# => "abcdef"
p a# => "abc"(変化なし)
p b# => "def"


+self -> String | self
#selfがfreeze(破壊的変更ができない)されている文字列の場合、もとの文字列の複製を返す。freezeされていない場合はselfを返す。
# frozen_string_literal: false
original_text = "text"
unfrozen_text = +original_text
unfrozen_text.frozen?# => false
original_text == unfrozen_text# => true
original_text.equal?(unfrozen_text)# => true

original_text = "text"
unfrozen_text = +original_text
unfrozen_text.frozen?# => false
original_text == unfrozen_text# => true
original_text.equal?(unfrozen_text)# => false


- self -> String | self
dedup -> String | self
#selfがfreezeされている文字列の場合、selfを返す。freezeされていない場合はもとの文字列のfreezeされた複製を返す。
original_text = "text"
unfrozen_text = -original_text
unfrozen_text.frozen?# => true
original_text == unfrozen_text# => true
original_text.equal?(unfrozen_text)# => false

original_text = "text".freeze
unfrozen_text = -original_text
unfrozen_text.frozen?# => true
original_text == unfrozen_text# => true
original_text.equal?(unfrozen_text)# => true


self << other -> self
concat(other) -> self
#selfに文字列otherを破壊的に連結する。otherが整数である場合はother.chr(self.encoding)相当の文字を末尾に追加する。
#[PARAM]other: 文字列もしくは0以上の整数
str + "string"
str.concat "XXX"
p str# => "stringXXX"

str  <<  "YYY"
p str# => "stringXXXYYY"

str  << 65#文字AのASCIIコード
p str# => "SrringXXXYYYA"


concat(*arguments) -> self
#selfに複数の文字列を破壊的に連結する。
#[PARAM]arguments: 複数の文字列もしくは0以上の整数

str = "foo"
str.concat
p str# => "foo"

str = "foo"
str.concat "bar", "baz"
p str# => "foobarbaz"

str = "foo"
str.concat("!", 33, 33)
p str# => "foo!!!"


self <=> other -> -1 | 0 | 1 | nil
#selfとotherをASCIIコード順で比較して、selfが大きいときには1、等しいときには0、小さいときには-1を返します。otherが文字列でない場合、other.to_strとother.<=>が定義されていれば0-(other<=>self)の結果を返す。そうでなければnilを返す。
#[PARAM]other: 文字列
#[RETURN]: 比較結果の整数かnil
p "aaa" <=> "xxx"# => -1
p "aaa" <=> "aaa"# => 0
p "xxx" <=> "aaa"# => 1

p "string" <=> "stringAA"# => -1
p "string" <=> "string"# => 0
p "stringAA" <=> "string"# => 1


self == other -> bool
self === other -> bool
#otherが文字列の場合、String#eql?と同様に文字列の内容を比較します。eql?の方が厳密に評価を行う。
#[PARAM]other: 任意のオブジェクト
#[RETURN] trueかfalse
stringlike = Object.new

def  stringlike == (other)
    "string" == other
end

p "string".eql?(stringlike)# => false
p "string" == stringlike# => false

def stringlike.to_str
    raise
end

p "string".eql?(stringlike)# => false
p "string" == stringlike# => true


self =~ other -> Integer | nil
#正規表現otherとのマッチを行います。マッチが成功すればマッチした位置のインデックスを、そうでなければnilを返す。otherが正規表現でも文字列でもない場合はother =~ selfを行う。
#[PARAM]other: 正規表現もしくは=~メソッドを持つオブジェクト
#[EXCEPTION]TypeError: otherが文字列の場合に発生する。
p "string" =~ /str/# => 0
p "string" =~ /not/# => nil
p "abcfoo" =~ /foo/# => 3


self[nth] -> String | nil
slice(nth) -> String | nil
#nth番目の文字を返す。nthが負の場合は文字列の末尾から数える。つまり、self.size + nth番目の文字を返す。nthが範囲外を指す場合はnilを返す。
#[PARAM]nth: 文字の位置を表す整数
#[RETURN] 指定した位置の文字を表すStringオブジェクト
p 'bar'[2]# => "r"
p 'bar'[2] == ?r# => true
p 'bar'[-1]# => "r"
p 'bar'[3]# => nil
p 'bar'[-4]# => nil


self[nth, len] -> String | nil
slice(nth, len) -> String | nil
#nth文字目から長さlen文字の部分文字列を新しく作って返す。nthが負の場合は文字列の末尾から数える。
#[PARAM]nth: 取得したい文字列の開始インデックスを整数で指定する。
#[PARAM]len: 取得したい文字列の長さを正の整数で指定する。
#[RETURN] nthが範囲外を指す場合はnilを返す。
str0 = "bar"
str0[2, 1]# => "r"
str0[2, 0]# => ""
str0[2, 100]# => "r"(右側を超えても平気)
str0[-1, 1]# => "r"
str0[-1, 2]# => "r"(右に向かってlen文字)
str0[3, 1]# => ""
str0[4, 1]# => nil
str0[-4, 1]# => nil
str1 = str0[0, 1]#(strの一部をstr1とする)
str1# => ba
str1[0] = "XYZ"
str1# => "XYZa"
str0# => "bar"


self[substr] -> String | nil
slice(substr) -> String | nil
#selfがsubstrを含む場合、一致した文字列を新しく作って返す。substrを含まなければnil返す。
#[PARAM]substr: 取得したい文字列のパターン、文字列
substr = "bar"
result = "foobar"[substr]
p result# => "bar"
p substr.equal?(result)# => false


self[regexp, nth = 0] -> String
slice(regex, nth = 0) -> String
#正規表現regexpのnth番目の括弧にマッチする最初の部分文字列を返す。nthを省略したときや0の場合は正規表現がマッチした部分文字列全体を返す。正規表現がselfにマッチしなかった場合やnthに対応する括弧がないときはnilを返す。
p "foobar"[/bar/]# => "bar"
p $~.begin(0)# => 3
p "def getcnt(line)"[/def\s+(\w+)/, 1]# => "getcnt"


self[regexp, name] -> String
slice(regexp, name) -> String
#正規表現regexpのnameで指定した名前付きキャプチャにマッチする最初の部分文字列を返す。(キャプチャとは()でくくられたところのこと)正規表現がselfにマッチしなかった場合はnilを返す。
#[PARAM]regexp: 正規表現を指定する。
#[PARAM]name: 取得したい部分文字列のパターンを示す正規表現レジスタを示す名前
#[EXCEPTION]IndexError: nameに対応する括弧がない場合に発生する。
s = "FooBar"
s[/(?<foo>[A-Z]..)(?<bar>[A-Z]..)/]# => "FooBar"
s[/(?<foo>[A-Z]..)(?<bar>[A-Z]..)/, "foo"]# => "Foo"
s[/(?<foo>[A-Z]..)(?<bar>[A-Z]..)/, "bar"]# => "Bar"
s[/(?<foo>[A-Z]..)(?<bar>[A-Z]..)/, "baz"]# => IndexError


self[range] -> String
slice(range) -> String
#rangeで指定したインデックスの範囲に含まれる部分文字列を返す。
#[PARAM]range: 取得したい文字列の範囲を示すRangeオブジェクト

#rangeオブジェクトが終端を含むとき
#range.lastが文字列の長さ以上のときは-1を指定したものとみなされる。range.firstが0より小さいか文字列の長さより大きいときはnilを返す。ただしrange.firstおよびrange.lastのどちらかまたは両方が負の数のときは一度だけ文字列の長さを足して再試行する。
'abcd'[2..1]# => ""
'abcd'[2..2]# => "c"
'abcd'[2..3]# => "cd"
'abcd'[2..4]# => "cd"

'abcd'[2..-1]# =>"cd"
'abcd'[3..-1]# => "d"

'abcd'[1..2]# => "bc"
'abcd'[2..2]# => "c"
'abcd'[3..2]# => ""
'abcd'[4..2]# => "" ※開始位置が文字列の長さより大きかったらnil
'abcd'[5..2]# => nil

'abcd'[-3..2]# => "bc"
'abcd'[-4..2]# => "abc" ※文字列の長さを開始位置に足す
'abcd'[-5..2]# => nil

#rangeオブジェクトが終端を含まないとき
#range.lastが文字列の長さよりも大きいときは文字列の長さを指定したものとみなす。range.firstが0より小さいか文字列の長さより大きいときはnilを返す。ただしrange.firstとrange.lastのどちらかまたは両方が負の数であるときは一度だけ文字列の長さを足して再試行する。
'abcd'[2...3]# => "c"
'abcd'[2...4]# => "cd"
'abcd'[2...5]# => "cd"

'abcd'[1...2]# => "b"
'abcd'[2...2]# => ""
'abcd'[3...2]# => ""
'abcd'[4...2]# => ""
'abcd'[5...2]# => nil

'abcd'[-3...2]# => "b"
'abcd'[-4...2]# => "ab"
'abcd'[-5...2]# => nil


self[nth] = val
#nth番目の文字を文字列valで置き換える。
#[PARAM]nth: 置き換えたい文字の位置を指定する。
#[PARAM]val: 置き換える文字列を指定する。
#[RETURN]: valを返す。
buf = "string"
buf[1] = "!!"
p buf# => "s!!ring"


self[nth, len] = val
#nth番目の文字からlen文字の部分文字列を文字列valで置き換える。
#lenが0の場合は単にnthの位置から文字列の追加が行われる。nthが負の場合は文字列の末尾から数える。
#[PARAM]nth: 置き換えたい部分文字列の開始インデックス
#[PARAM]len: 置き換えたい部分文字列の長さ
#[PARAM]val: 指定範囲の部分文字列と置き換える文字列
#[RETURN]: valを返す。
buf = "string"
buf[1, 4] = "!!"
p buf# => "s!!g"

buf = "string"
buf[1, 0] = "!!"
p buf# => "s!!tring"


self[substr] = val
#文字列中のsubstrに一致する最初の部分文字列を文字列valで置き換える。
#[PARAM]sbstr: 置き換えたい部分文字列のパターンを示す文字列
#[PRAM]val: 指定範囲の部分文字列と置き換える文字列
#[RETURN]: valを返す。
#[EXCEPTION]IndexError: selfが部分文字列substrを含まない場合に発生する。
buf = "string"
buf["trin"] = "!!"
p buf# => "string"
buf["nosuchstring"] = "!!"# => IndexError


self[regexp, nth] = val
#正規表現regexpのnth番目の括弧にマッチする最初の部分文字列を文字列valで置き換える。
#nthが0の場合は、マッチした部分文字列全体をvalで置き換える。
#[PARAM]regexp: 置き換えたい部分文字列のパターンを示す正規表現レジスタの番号
#[PARAM]nth: 置き換えたい部分文字列のパターンを示す正規表現レジスタの番号
#[PARAM]val: 指定範囲の部分文字列と置き換えたい文字列
#[RETURN]: valを返す。
#[EXCEPTION]IndexError: 正規表現がマッチしなかった場合に発生する。
buf  = "def exec(cmd)"
buf[/def\s+(\w+)/, 1] = "preprogress"
p buf# => "def preprogress(cmd)"


self[regexp, name] =val
#正規表現regexpのnameで指定した名前付きキャプチャにマッチする最初の部分文字列を文字列valで置き換える。
#[PARAM]regexp: 置き換えたい部分文字列のパターンを示す正規表現
#[PARAM]name: 置き換えたい部分文字列のパターンを示す正規表現レジスタを示す名前
#[PARAM]val: 指定範囲の部分文字列と置き換えたい文字列
#[RETURN]: valを返す。
#[EXCEPTION]IndexError: nameで指定した名前付きキャプチャが存在しない場合に発生する。
s = "FooBar"
s[/(?<foo>[A-Z]..)(?<bar>[A-Z]..)/, "foo"] = "Baz"
p s# => "BazBar"


self[regexp] = val
#正規表現regexpにマッチした部分文字列全体をvalで置き換える。
#[PARAM]regexp: 置き換えたい部分文字列のパターンを示す正規表現
#[PARAM]val: 置き換えたい文字列
#[RETURN]: valを返す。
#[EXCEPTION]IndexError: 正規表現がマッチしなかった場合に発生する。
buf = "string"
buf[/tr../] = "!!"
p buf# => "s!!g"


self[range] = val
#rangeで指定したインデックスの範囲に含まれる部分文字列を文字列valで置き換える。
#[PARAM]range: 置き換えたい範囲を示すRangeオブジェクト
#[RETURN]: valを返す。
