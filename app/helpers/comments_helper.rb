module CommentsHelper
  def getUserName comment
    user_id=comment.User_id
    User.find(user_id).name
  end
end
