module Api
    module V1
        class AspectController < ApplicationController
            def format_bounding_box
                image_dimensions = params['image_dimensions']
                bounding_box = params['bounding_box']
                bounding_width = bounding_box.first.to_f
                bounding_height = bounding_box.last.to_f

                scaled_dimensions = []

                if image_dimensions.length == 2 || image_dimensions.length % 2 == 0
                    dimension_pairs = image_dimensions.slice(2).to_a
                    dimension_pairs.each do |dimension|
                        width = dimension.first.to_f
                        height = dimension.last.to_f
                        scaled_width = width/bounding_width
                        scaled_height = height/bounding_height
                        if scaled_width > scaled_height
                            scaled_height = (height/scaled_width).to_i
                            scaled_width = (width/scaled_width).to_i
                        else
                            scaled_height = (height/scaled_height).to_i
                            scaled_width = (width/scaled_height).to_i
                        end
                        scaled_dimensions << [scaled_width, scaled_height]
                    end
                    scaled_dimensions.flatten!
                    render :json => {scaled_dimensions: scaled_dimensions, bounding_box: [bounding_width, bounding_height]}
                else
                    error = "Cannot interpret input. Try again."
                    render json: error, status: 400
                end
            end
        end
    end
end
