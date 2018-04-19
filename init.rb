require 'redmine_project_reply_to/mailer_patch'

Rails.configuration.to_prepare do
  unless Mailer.included_modules.include? RedmineProjectReplyTo::MailerPatch
    Mailer.prepend(RedmineProjectReplyTo::MailerPatch)
  end
end

Redmine::Plugin.register :redmine_project_reply_to do
  name 'Redmine Project Reply To plugin'
  author 'Roberto Piccini'
  description %q{set a own 'reply_to' field for every project}
  version '2.0.0'
  url 'https://github.com/piccio/redmine_project_reply_to'
  author_url 'https://github.com/piccio'

  settings default: { 'reply_to_field' => nil }, partial: 'settings/project_reply_to'
end
