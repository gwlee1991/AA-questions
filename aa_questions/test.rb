require_relative  'question_database.rb'


p test1 = Reply.find_by_id(1)
p test1[0].child_replies
