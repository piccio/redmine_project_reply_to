module RedmineProjectReplyTo
  module MailerPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        alias_method_chain :mail, :reply_to
      end
    end

    module InstanceMethods
      def mail_with_reply_to(headers={}, &block)
        if !Setting.plugin_redmine_project_reply_to[:reply_to_field].nil? && !@issue.nil?
          reply_to_field = CustomValue.joins(:custom_field).
            where('custom_fields.id' => Setting.plugin_redmine_project_reply_to[:reply_to_field],
            customized_type: Project,
            customized_id: @issue.project.id).first
          headers.merge! 'Reply-To' => reply_to_field.value unless reply_to_field.nil?
        end

        mail_without_reply_to(headers, &block)
      end
    end
  end
end
