module ApplicationHelper
  def user_profile_photo(user)
    if user.profile_photo.attached? && user.profile_photo.persisted?
      user.profile_photo  
    else
      "/assets/default_profile.jpg"
    end
  end
end
