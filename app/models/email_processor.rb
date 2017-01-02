class EmailProcessor
  def self.process(email)
    Project.create!({ title: "New project", description: email.body })
  end
end
