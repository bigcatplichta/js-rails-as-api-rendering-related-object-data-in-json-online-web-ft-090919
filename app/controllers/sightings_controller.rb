class SightingsController < ApplicationController

    def index
        sightings = Sighting.all
        # render json: sightings

        # to include nested objects
        # render json: sightings, include: [:bird, :location]
        # which is same as doing below, but with Rails magic
        render json: sightings.to_json(include: [:bird, :location])
    end

    def show
        sighting = Sighting.find_by(id: params[:id])
        # render json: sighting

        # below will render nested objects for 'bird' and 'location'
        # since 'sighting.bird' and 'sighting.location' return the associated objects
        # render json: { id: sighting.id, bird: sighting.bird, location: sighting.location }
        # or use 'include'
        if sighting # check if resource exists
            render json: sighting, include: [:bird, :location]
        else # render error message
            render json: { message: 'No sighting found with that id' }
        end

        # below will include and exclude nested resources, but is annoying to look at
        # render json: sighting.to_json(:include => {
        # :bird => {:only => [:name, :species]},
        # :location => {:only => [:latitude, :longitude]}
        # }, :except => [:updated_at])

    end

end
