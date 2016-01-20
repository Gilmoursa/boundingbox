module Api
    module V1
        class AspectController < ApplicationController
            def format_bounding_box
                image_dimensions = params["image_dimensions"].gsub(/"|\[|\]/, "").split(",")
                bounding_box = params["bounding_box"].gsub(/"|\[|\]/, "").split(",")
                bounding_width = bounding_box.first.to_f
                bounding_height = bounding_box.last.to_f
                scaled_dimensions = []

                if image_dimensions.length % 2 == 0
                    image_dimensions = image_dimensions.each_slice(2).to_a
                    image_dimensions.each do |dimensions|
                        width = dimensions.first.to_f
                        height = dimensions.last.to_f
                        scaled_width = width/bounding_width
                        scaled_height = height/bounding_height
                        if scaled_width > scaled_height
                            scaled_height = (height/scaled_width).to_i
                            scaled_width = (width/scaled_width).to_i
                        else
                            scaled_width = (width/scaled_height).to_i
                            scaled_height = (height/scaled_height).to_i
                        end
                        scaled_dimensions << [scaled_width, scaled_height]
                    end
                    scaled_dimensions.flatten!
                    render :json => {scaled_dimensions: scaled_dimensions, bounding_box: [bounding_width, bounding_height]}
                else
                    error = "I cannot read your input. Make sure each dimension has a width and height."
                    render json: error, status: 400
                end
            end
        end
    end
end

600
