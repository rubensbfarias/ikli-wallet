class PostsController < ApplicationController
    attr_accessor :frase
    
    def index
        @frase = "Pega na minha rroula"
    end

end
