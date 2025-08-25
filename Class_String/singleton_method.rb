#特異メソッド: stringと同じ内容の新しい文字列を作成して返す
new(string = "") -> String
new(string = "", encoding: string.encoding, capacity: 63) -> String
new(string = "", encoding: string.encoding, capacity: string.bytesize) -> String

#string: 文字列
#encoding: 作成する文字列のエンコーディングを指定。省略された場合はstringのエンコーディングと同じ
#capacity: 文字列をつくるときにRubyがデータを保持するために確保する内部バッファのサイズを予め指定する。これによりパフォーマンスが改善される可能性がある。

text = "hoge".encode("EUC-JP")
no_option = String.new(text)# => "hoge"
no_option.encoding == Encoding::EUC_JP# =>true
with_encoding = String.new(text, encoding: "UTF-8")# => "hoge"
with_encoding.encoding == Encoding::UTF_8# =>true
String.new("text", encoding: "UTF-8", capacity: 100_000)# => "text"

#objをStringに変換しようと試みる。変換後に文字列を返すか、何らかの理由により変換できなかった場合はnilが返される。
try_convert(obj) -> String | nil
#obj: 変換する任意のオブジェクト

String.try_convert("str")# => "str"
String.try_convert(/re/)# => nil
