require_relative 'question_database.rb'

class Question
  attr_accessor :id, :title, :body, :user_id
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions
      WHERE id = ?
    SQL
    data.map {|datum| self.new(datum)}
  end

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT *
    FROM questions
    WHERE user_id = ?
    SQL
    data.map {|datum| self.new(datum)}
  end

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end
end
