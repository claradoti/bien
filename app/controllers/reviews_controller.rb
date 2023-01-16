class ReviewsController < ApplicationController
  def index
    # this is our list page for our reviews
    @price = params[:price]
    @cuisine = params[:cuisine]
    @location = params[:location]

    # start with all of the reviews
    @reviews = Review.all

    # filter by price
    if @price.present?
      @reviews = @reviews.where(price: @price)
    end

    # filter by cuisine
    if @cuisine.present?
      @reviews = @reviews.where(cuisine: @cuisine)
    end

    # find near location
    if @location.present?
      @reviews = @reviews.near(@location)
    end

  end

  def new
    # the form for adding a new review
    @review = Review.new
  end

  def create
    # take the info from the form and add it to the model
    @review = Review.new(form_params)

    #check if the model can be saved
    #if it is, we're going to the homepage again
    #if it isn't, show the new form
    if @review.save
      redirect_to root_path
    else
      #show the view for new.html.erb
      render "new", status: :unprocessable_entity
    end

  end

  def show
    # individual review page
    @review = Review.find(params[:id])
  end

  def destroy
    # find the individual review
    @review = Review.find(params[:id])
    # destroy it
    @review.destroy
    # redirect to the homepage
    redirect_to root_path
  end

  def edit
    # find the individual review (to edit)
    @review = Review.find(params[:id])
  end

  def update
    # find the individual review
    @review = Review.find(params[:id])
    # update with the new info from the form
    if @review.update(form_params)
      # redirect back to original page
      redirect_to review_path(@review)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def form_params
    params.require(:review).permit(:title, :restaurant, :body, :cuisine, :price, :score, :ambiance, :address)
  end
end
