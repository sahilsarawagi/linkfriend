module ApplicationHelper
  def user_profile_photo(user)
    if user.profile_photo.attached? && user.profile_photo.persisted?
      user.profile_photo  
    else
      "/assets/default_profile.jpg"
    end
  end

  def follow_unfollow_button(user,pending=false)
    if user.id == current_user.id
      {label: "Edit profile", path: edit_user_registration_path, method: :get}   
    elsif pending
      {label: "Requested", path: unfollow_user_path(user), method: :post}      
    elsif current_user.followees.include?(user) 
      {label: "Unfollow", path: unfollow_user_path(user), method: :post}
    else 
      {label: "Follow", path: follow_user_path(user), method: :post }
    end
                     
  end

  def user_name(user)
    link_to  "#{user.first_name.capitalize} #{user.last_name.capitalize}", user_path(user), data: { turbo_frame: "_top" }
  end
  
  def user_email(user)
    "#{user.email}"
  end
end
