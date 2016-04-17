class FaceIdentController < ApplicationController
  def ident_image
    face_api = FaceApi.new
    result = face_api.detection_detect(:query => {url: Content::QINIU_URL + params[:filename]})
    if result.nil? || result.empty?
        render :status => 400,:json => MultiJson.dump({:error=>"no face find",:error_code=>100}) and return
    end
    render :status => :ok
  end


end
