module PostsHelper
  def createdBy post
    user_id=post.User_id
    user=User.find(user_id)
    if user
      user.name
    end
  end



  def getUserNamePosts user_id
    user=User.find(user_id)

    if user
      user.name
    end
  end

  def getCategory post
    category_id=post.Category_id
    category=Category.find(category_id)
    if category
      category.name
    end
  end

  def getVotes(post)
    current_post=Post.find(post)
    votes=current_post.p_votes
    votes
  end

  def getCVotes(comment)
    current_comment=Comment.find(comment)
    votes=current_comment.c_votes
    votes
  end

  def getCVoteCount(comment)
    votes=comment.c_votes
    votes.length
  end

  def hasUserVotedComment? (comment)
    current_comment=Comment.find(comment)
    votes=current_comment.c_votes
    vote=votes.where(:User_id=>session[:user_id])
    if vote.first
      voted=true
    else
      voted=false
    end
    voted
  end

  def getPVoteCount (post)
    votes=post.p_votes
    votes.length
  end

  def hasUserVoted? (post)
    current_post= Post.find(post)
    votes=current_post.p_votes
    vote=votes.where(:User_id=>session[:user_id])
    if vote.first
      voted=true
    else
      voted=false
    end
    voted
  end
  end

