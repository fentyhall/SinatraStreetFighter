class MovesController < ApplicationController

    get '/:slug/moves/new' do
        if logged_in?
            @character = Character.find_by_slug(params[:slug])
            erb :'moves/new'
        else  
            redirect to '/login'
        end     
    end 

    post '/:slug/moves/new' do
        @character = Character.find_by_slug(params[:slug])
        @character.update(params[:character])

        if !params[:move][:name].empty?
            @character.moves << Move.find_or_create_by(name: params[:move][:name])
        end 

        @character.save

        redirect to "/characters/#{@character.slug}"
    end 

    get '/:slug/moves/edit' do 
        if logged_in?
            @character = Character.find_by_slug(params[:slug])
            erb :'moves/edit'
        else  
            redirect to '/login'
        end 
    end 

    patch '/:slug/moves/edit' do 
        @character = Character.find_by_slug(params[:slug])
        @character.update(params[:character])

        if !params[:move][:name].empty?
            @character.moves << Move.find_or_create_by(name: params[:move][:name])
        end 

        @character.save

        redirect to "/characters/#{@character.slug}"
    end 
    
end 