require_relative 'question_database.rb'

class QuestionFollow
  attr_accessor :id, :user_id, :question_id
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_follows
      WHERE id = ?
    SQL
    data.map { |datum| self.new(datum) }
  end

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end
