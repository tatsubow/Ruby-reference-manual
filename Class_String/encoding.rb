p "いろは".size # => 3
p "漢字"[0] # =>"漢"
p "山本山".reverse # => "山本山"
p "ループ".reverse # => "プール"

s = "ruビー"
s[0..1] = "ル"
p s # => "ルビー"
e = "言語".encode("EUC-JP")
u = "言語".encode("UTF-8")
p e.encoding # => Encoding::EUC_JP
p u.encoding # => Encoding::UTF_8

s = "いろは"
a = s.encode("EUC-JP")
b = s.encode("UTF-8")
p a == b # =>false
s = "合".encode("EUC-JP")
p s + "\u{4f53}".encode("EUC-JP") # =>"合体"
p s + "\u{4f53}" #=> Encoding::CompatibilityError

# encoding: UTF-8
h={}
s = "いろは"
s.force_encoding("EUC-JP")
h[s] = 1
s.force_encoding("ASCII-8BIT")
p h[s] # => nil

#7bit クリーンな文字列
s = "abc"
a = s.encode("EUC-JP")
b = s.encode("UTF-8")
p a == b # =>true
p a + b # =>"abcabc"

