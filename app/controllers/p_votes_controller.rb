class PVotesController < ApplicationController
  # GET /p_votes
  # GET /p_votes.json
  def index
    @p_votes = PVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @p_votes }
    end
  end

  # GET /p_votes/1
  # GET /p_votes/1.json
  def show
    @p_vote = PVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @p_vote }
    end
  end

  # GET /p_votes/new
  # GET /p_votes/new.json
  def new
    @p_vote = PVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @p_vote }
    end
  end

  # GET /p_votes/1/edit
  def edit
    @p_vote = PVote.find(params[:id])
  end

  # POST /p_votes
  # POST /p_votes.json
  def create
    #@p_vote = PVote.new(params[:p_vote])
    @p_vote=PVote.new
    post_id=params[:post_id]
    @p_vote.Post_id=post_id
    @p_vote.User_id=session[:user_id]


    respond_to do |format|
      if @p_vote.save
        format.html { redirect_to request.referer  }
        format.json { render json: @p_vote, status: :created, location: @p_vote }
      else
        format.html { render action: "new" }
        format.json { render json: @p_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /p_votes/1
  # PUT /p_votes/1.json
  def update
    @p_vote = PVote.find(params[:id])

    respond_to do |format|
      if @p_vote.update_attributes(params[:p_vote])
        format.html { redirect_to @p_vote, notice: 'P vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @p_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /p_votes/1
  # DELETE /p_votes/1.json
  def destroy
    @p_vote = PVote.find(params[:id])
    @p_vote.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.json { head :no_content }
    end
  end
end
