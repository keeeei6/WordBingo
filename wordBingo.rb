def create_bingo(count)
  num = 0
  @words = {}
  while num < count do
    @words[num] = gets.chomp
    @words[num] = @words[num].split(nil)
    num += 1
  end
end

def select_words(word_count)
  word_num = 0
  @select_words = []
  while word_num < word_count do
    @select_words[word_num] = gets.chomp
    word_num += 1
  end
end

def judg_bingo(count)
  @sigun = ""
  n = 0
  # 横列
  @words.each{|key, value|
    match = @words[key] & @select_words
    match_count = match.length
  
    if match_count === count
      @sigun = "Yes #{match.inspect} 横ビンゴ"
    end
  }

  #縦列
  vertical = []
  while n < count do
    @words.each{|key, value|
      vertical.push(@words[key][n])
    }
    n += 1
  end
  verticals = vertical.each_slice(count).to_a
  verticals.each{|vertical|
    match2 = vertical & @select_words
    match_count2 = match2.length
    if match_count2 === count
      @sigun= "Yes #{match2.inspect} 縦ビンゴ"
    end 
  }

  #斜め（左上から右下）
  n = 0
  diagonal = []
  while n < count do
    diagonal.push(@words[n][n])
    n += 1
  end
  match3 = diagonal & @select_words
  match_count3 = match3.length
  if match_count3 === count
    @sigun = "Yes #{match3.inspect} 左上から右下ビンゴ"
  end

  # 逆斜め（右上から左下）
  n = 0
  value_count = count
  rdiagonal = []
  while n < count do
    value_count -= 1
    rdiagonal.push(@words[n][value_count])
    n += 1
  end
  match4 = rdiagonal & @select_words
  match_count4 = match4.length
  if match_count4 === count
    @sigun = "Yes #{match4.inspect} 斜め(右上から左した)ビンゴ"
  end

end

def result
  if @sigun.include?("Yes")
    puts "出力結果"
    puts @sigun
  else
    puts "出力結果"
    puts "No"
  end
end

def error(count, word_count)
  @e = []
  judg_arrays = []

  if count < 3 || count >= 1000
    @e.push("行の数は3以上 1000以下で入力してください")
  end

  if word_count < 1 || word_count >= 2000
    @e.push("ワードの数(N)は1以上 2000以下で入力してください")
  end

  @words.each{|key, word|
    word.each{|value|
      judg_arrays.push(value)
    }
  }
  e_judg = judg_arrays.select{ |e| judg_arrays.count(e) > 1 }.uniq
  if !e_judg.empty?
    @e.push("ビンゴ内に重複するワード(A)は使えません")
  end

  judg_arrays.each{|judg_word|
    word_length = judg_word.length
    if word_length < 1 || word_length >= 100
      @e.push("ビンゴ内のワード(A)は1文字以上100文字以下にしてください")
    end
  }

  w_judg = @select_words.select{ |e| @select_words.count(e) > 1 }.uniq
if !w_judg.empty?
    @e.push("選択ワード(w)に重複する文字は使えません")
  end
end


# ビンゴシート入力
puts "形式通り入力してください"
count = gets.to_i

create_bingo(count)

# 単語入力
word_count = gets.to_i
select_words(word_count)

# ビンゴ判定
judg_bingo(count)

# エラー判定 ・エラーがあればエラーメッセージ　・エラーがなければ結果出力
error(count, word_count)
if !@e.empty?
  @e.each{|e|
    puts e
  }
  return
else
  result
end
