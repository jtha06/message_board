module UsersHelper

  def gravatar_for(user, options = { :size => 45 })
    gravatar_image_tag(user.email.downcase, :class => 'gravatar',
                                            :gravatar => options)
  end
  
  def remove_sensitive_error_messages_from_user(user)
    @user.errors.full_messages.delete_if { |msg| msg =~ /digest/ }
  end
end
