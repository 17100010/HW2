class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @var =  params[:sort_by]
    if @var=='title' or @var =='release_date'
      @movies=Movie.order(@var)  
    else
      @movies = Movie.all
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def change
  end
  
  def change_update
    @info = params[:movie]
    @movie = Movie.find_by(title: @info[:title_check] )
     
    if(@movie)
      @theTitle =  @info[:title]
      @theRating =  @info[:rating]
      @theRelease =  @info[:release_date]
      if @theTitle!='' && @theRating!='' && @theRelease!=''
        @movie.update_attributes!(movie_params)
        # @movie.update_attributes!(:rating, @theRating)
        # @movie.update_attributes!(:release_date, @theRelease)
        # @movie.update_attributes!(movie_params)
        flash[:notice] = "#{@movie.title} #{@movie.release_date} #{@movie.rating} was successfully updated."
      else
        flash[:notice] = "No updates yet ."
      end
    else
      flash[:notice] = "in else condition"
    end
      redirect_to movies_path
    
  
  end
  
  
  def delete
  end
  
  def the_delete
      @info = params[:movie]
      @theMovie = @info[:title]
      @therating = @info[:rating]
      if(@theMovie!='')
        @movie = Movie.find_by(title: @info[:title] )
        
        if(@movie)
          @movie.destroy
          flash[:notice] = "#{@theMovie} was successfully deleted."
        end
      end
      
      if(@therating!='')
        # @fromcanada = User.find(:all, :conditions => { :country => 'canada' })
        # Movie.where(’title = "Requiem for a Dream"’)
        # @customers = Customer.where('first_name LIKE ?', params[:query])
        @mov = Movie.where('rating =  ?', @therating)
        @mov.each do |m|
          m.destroy
        end
        flash[:notice] = "the movies were successfully deleted."
      end
      redirect_to movies_path 
  end
  
  
  

end
