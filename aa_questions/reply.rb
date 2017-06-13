require_relative 'question_database.rb'

class Reply
  attr_accessor :id, :question_id, :parent_id, :user_id, :body
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE id = ?
    SQL
    data.map {|datum| self.new(datum)}
  end

  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
  end
end
