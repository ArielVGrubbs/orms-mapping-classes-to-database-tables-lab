class Student
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_reader :id, :name, :grade

  @@all = []

  def initialize (name, grade)
    @name = name
    @grade = grade
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.create_table
    sql =  "CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER
        )"
        # SQL
    DB[:conn].execute(sql) 
  end

  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create (hash)
    t_name = hash[:name]
    t_grade = hash[:grade]
    stud = Student.new(t_name, t_grade)
    stud.save
    stud
  end
end
