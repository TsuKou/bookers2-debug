class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "User" #応用課題4で追加　#「class_name: モデル名」→これによりUersテーブルを参照できる。逆側相手側のモデルファイル「User.rb」の「has_many」にも、同様の記述をする必要がある。
  belongs_to :followed, class_name: "User"#応用課題4で追加

end
