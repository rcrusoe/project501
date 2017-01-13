desc 'Send an email to all users with a summary of projects created in the past week.'
namespace :db do
    namespace :projects do
        task :send_digest_email => :environment do
            @projects = Project.all
            @users = User.all
            @users.each do |user|
              UserNotifierMailer.send_project_digest_email(user, @projects).deliver
            end
        end
    end
end
