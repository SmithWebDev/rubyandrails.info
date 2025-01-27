class AuthorsController < ApplicationController

  before_action :authenticate_admin!, only: %i[new edit create update destroy]
  before_action :set_author, only: %i[show edit update destroy]

  layout "admin", only: %i[new edit]

  def index
    set_meta_tags title: "#{Author.count} authors creating materials about Ruby & Ruby on Rails", description: "People who write create books, podcasts, courses about Ruby and Ruby on Rails. For each author you can see all the books they have written about the topic and their contacts: twitter, website, or github.", keywords: "Ruby book authors, Ruby on Rails book authors"

    @authors = Author.all.order("name ASC") 
    @tags = Tag.all.order(:title)

    render layout:"index_page"
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    if @author.save
      redirect_to authors_path
      render json: tag
    else
      render :new
    end
  end

  def show

    @books = Book.joins(:authors).where(authors: { id: @author })
    @courses = Course.joins(:authors).where(authors: { id: @author })
    @newsletters = Newsletter.joins(:authors).where(authors: { id: @author })
    @screencasts = Screencast.joins(:authors).where(authors: { id: @author })
    @podcasts = Podcast.joins(:authors).where(authors: { id: @author })

    @with_content = ""
    @with_tags = ""
    @with_lessons = ""
    @with_related = @screencasts.empty? && @books.empty? && @courses.empty? && @newsletters.empty? && @podcasts.empty?

    set_meta_tags title: "#{@author.name}", description: "#{@author.name} author of #{@books.map { |book| book.title }.join(", ").html_safe}.", keywords: "#{@author.name}, #{@books.map { |book| book.title }.join(", ").html_safe}"

    render layout:"show_page"
  end

  def edit
  end

  def update
    if @author.update author_params
      redirect_to author_path
    else
      render :edit
    end
  end

  def destroy
    @author.destroy
    redirect_to authors_path
  end

  private

  def set_author
    @author = Author.friendly.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :content, :twitterUrl, :siteUrl, :githubUrl, :photo)
  end

  def authenticate_admin!
    redirect_to root_path unless current_user.try(:admin?)
  end
end
