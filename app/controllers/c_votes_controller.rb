class CVotesController < ApplicationController
  # GET /c_votes
  # GET /c_votes.json
  def index
    @c_votes = CVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @c_votes }
    end
  end

  # GET /c_votes/1
  # GET /c_votes/1.json
  def show
    @c_vote = CVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @c_vote }
    end
  end

  # GET /c_votes/new
  # GET /c_votes/new.json
  def new
    @c_vote = CVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @c_vote }
    end
  end

  # GET /c_votes/1/edit
  def edit
    @c_vote = CVote.find(params[:id])
  end

  # POST /c_votes
  # POST /c_votes.json
  def create
    @c_vote = CVote.new(params[:c_vote])

    respond_to do |format|
      if @c_vote.save
        format.html { redirect_to @c_vote, notice: 'C vote was successfully created.' }
        format.json { render json: @c_vote, status: :created, location: @c_vote }
      else
        format.html { render action: "new" }
        format.json { render json: @c_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /c_votes/1
  # PUT /c_votes/1.json
  def update
    @c_vote = CVote.find(params[:id])

    respond_to do |format|
      if @c_vote.update_attributes(params[:c_vote])
        format.html { redirect_to @c_vote, notice: 'C vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @c_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /c_votes/1
  # DELETE /c_votes/1.json
  def destroy
    @c_vote = CVote.find(params[:id])
    @c_vote.destroy

    respond_to do |format|
      format.html { redirect_to c_votes_url }
      format.json { head :no_content }
    end
  end
end
