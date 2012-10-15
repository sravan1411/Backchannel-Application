class CategoriesController < ApplicationController
  include LoginHelper
  # GET /categories
  # GET /categories.json
  def index
    if authenticated?
      if IsAdmin?
        @categories = Category.all

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @categories }
        end
      else
        flash[:alert]="You are not privileged to view this page"
        redirect_to :controller => 'posts', :action => 'index'
      end
    else
      redirect_to :controller=>'login', :action => 'new'
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    if authenticated?
      if IsAdmin?
        @category = Category.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @category }
        end
      else
        flash[:alert]="You are not privileged to view this page"
        redirect_to :controller => 'posts', :action => 'index'
      end
    else
      redirect_to :controller => 'login', :action => 'new'
    end

  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    if authenticated?
      if IsAdmin?
        @category = Category.new
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @category }
        end
      else
        flash[:alert]="You are not privileged to view this page"
        redirect_to :controller => 'posts', :action => 'index'
      end
      else
      redirect_to :controller => 'login', :action => 'new'
    end
  end

  # GET /categories/1/edit
  def edit
    if authenticated?
      if IsAdmin?
        @category = Category.find(params[:id])
      else
        flash[:alert]="You are not privileged to view this page"
        redirect_to :controller => 'posts', :action => 'index'
      end
    else
      redirect_to :controller => 'login', :action => 'new'
    end
  end

  # POST /categories
  # POST /categories.json
  def create

    if authenticated?
      if IsAdmin?
        @category = Category.new(params[:category])
        respond_to do |format|
          if @category.save
            format.html { redirect_to :controller=>'categories', :action => 'index', notice: 'Category was successfully created.' }
            format.json { render json: @category, status: :created, location: @category }
          else
            format.html { render action: "new" }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      else
        flash[:alert]="You are not privileged to view this page"
        redirect_to :controller => 'posts', :action => 'index'
      end
    else
      redirect_to :controller => 'login', :action => 'new'
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    if authenticated?
      if IsAdmin?
        @category = Category.find(params[:id])
        respond_to do |format|
          if @category.update_attributes(params[:category])
            format.html { redirect_to :controller=>'categories', :action => 'index', notice: 'Category was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      else
        flash[:alert]="You are not privileged to view this page"
        redirect_to :controller => 'posts', :action => 'index'
      end
    else
      redirect_to :controller => 'login', :action => 'new'
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if authenticated?
      if IsAdmin?
        @category = Category.find(params[:id])
        @category.destroy
        respond_to do |format|
          format.html { redirect_to categories_url }
          format.json { head :no_content }
        end
      else
        flash[:alert]="You are not privileged to view this page"
        redirect_to :controller => 'login', :action => 'display'
      end
    else
      redirect_to :controller => 'login', :action => 'new'
    end
  end
end
