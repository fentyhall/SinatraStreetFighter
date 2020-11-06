class CharactersController < ApplicationController 
    get '/characters' do 
        if logged_in?
            erb :'characters/index'
        else 
            redirect to '/login'
        end 
    end 
    
    post '/characters' do 
        @character = Character.find_by_id(params[:character_id])
        if current_user.characters.include?(@character)
            flash[:message] = "You already have this character."
            
            redirect to '/characters' 
        else 
            current_user.characters << @character 
        end 
        redirect to "/characters/#{@character.slug}"
    end 
    
    delete '/characters/:id' do 
        @character = Character.find_by_id(params[:id])
        @character.delete

        redirect to '/characters'
    end 

    get '/characters/:slug' do 
        if logged_in?
            @character = Character.find_by_slug(params[:slug])
                        
            @character.moves.each do |move|
                move.stage_moves.each do |stage_move|
                    @stage = Stage.all.find {|stage| stage.id == stage_move.stage_id}
                end 
            end 

            erb :'characters/show'
        else  
            redirect to '/login'
        end 
    end 

    get '/characters/:slug/battle' do 
        if logged_in?
            @character = Character.find_by_slug(params[:slug])

            erb :'characters/battle'
        else
            redirect to '/login'
        end 
    end 
end 