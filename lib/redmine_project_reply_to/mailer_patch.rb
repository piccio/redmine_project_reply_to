module RedmineProjectReplyTo
  module MailerPatch

    def mail(headers = {}, &block)
      if !Setting.plugin_redmine_project_reply_to['reply_to_field'].nil? && !@issue.nil?
        reply_to_field = CustomValue.joins(:custom_field).
          where('custom_fields.id' => Setting.plugin_redmine_project_reply_to['reply_to_field'],
                customized_type: Project,
                customized_id: @issue.project.id).first
        headers.merge! 'Reply-To' => reply_to_field.value unless reply_to_field.nil?
      end

      super
    end

  end
end
