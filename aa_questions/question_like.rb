require_relative 'question_database.rb'

class QuestionLike
  attr_accessor :id, :user_id, :question_id, :likes
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_likes
      WHERE id = ?
    SQL
    data.map { |datum| self.new(datum) }
  end

  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM question_likes
      JOIN users
      ON question_likes.user_id = users.id
      WHERE question_likes.question_id = ?
    SQL
    data.map { |datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
    COUNT(likes) AS like_count
    FROM question_likes
    WHERE question_likes.question_id = ?

    SQL
    data[0]['like_count']
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
    questions.*
    FROM question_likes
    JOIN questions
      ON question_likes.question_id = questions.id
    WHERE question_likes.user_id = ?
    SQL

    data.map { |datum| Question.new(datum) }

  end




  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @likes = options['likes']
  end
end
