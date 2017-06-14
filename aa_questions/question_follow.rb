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

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id,
        users.fname,
        users.lname
      FROM question_follows
      JOIN users
      ON question_follows.user_id = users.id
      WHERE question_id = ?
    SQL
    data.map { |datum| User.new(datum) }

  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id,
        questions.title,
        questions.body,
        questions.user_id
      FROM question_follows
      JOIN questions
      ON question_follows.question_id = questions.id
      WHERE questions.user_id = ?
    SQL
    data.map { |datum| Question.new(datum) }

  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM question_follows
      JOIN questions
      ON question_follows.question_id = questions.id
      GROUP BY questions.id
      ORDER BY COUNT(questions.id)
      LIMIT ?

    SQL
  end

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end
