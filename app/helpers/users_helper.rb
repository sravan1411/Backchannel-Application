module UsersHelper
  include PostsHelper
  def isAdmin? user
    if user.isAdmin
      true
    else
      false
    end
  end

  def  getPostsCount(user_id)
    @posts=Post.all(:conditions=>{:User_id=>user_id})
    if @posts
      @posts.count();
    end
  end

  def getPostVotesCount(user_id)
    @posts=Post.all(:User_id=>user_id)
    count=0
    if @posts
      count+=@posts.inject(0) do |result,element|
         result=PVote.all(:Post_id=>element.id).count()
      end
      count
    end
  end

  def user_get_comments_votes(user_id)
    count = 0
    @comments = Comment.all(:conditions => {:user_id => user_id})
    @comments.each do |c|
      count += CVote.all(:conditions => {:comment_id => c.id}).count()
    end
    count
  end

  def getCommentsCount(user_id)
    Comment.all(:conditions => {:User_id => user_id}).count
  end

  def getVotesCount(user_id)
    count=0;
    count+=PVote.all(:conditions=>{:User_id=>user_id}).count
    count+=CVote.all(:conditions=>{:User_id=>user_id}) .count
    count
  end
end
