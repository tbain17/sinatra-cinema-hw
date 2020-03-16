require('sinatra')
require('sinatra/contrib/all') #if development?
require('pry-byebug')


require_relative('./models/film')
require_relative('./models/screening')
require_relative('./models/customer')
require_relative('./models/ticket')
also_reload('./models/*') #GET THIS PATH RIGHT!!!

get '/' do
  erb(:home)
end

get '/films' do
  @films = Film.all()
  @film_titles = @films.map{|film|film.title}
  erb(:films)
end

get '/films/:title' do
  @films = Film.all()
  @title = params[:title]
screenings = Screening.all()
  @screenings = []
  for film in @films
    if film.title == @title
      @price = "£#{film.price}"
      for screening in screenings
        if screening.film_id == film.id
          @screenings.push(screening.start_time)
        end
      end
    end
  end
  erb(:film_page)
end
