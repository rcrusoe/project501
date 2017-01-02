class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    Project.create!({ title: "New project", description: email.body })
  end
end
