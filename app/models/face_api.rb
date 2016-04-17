class FaceApi
  include HTTParty
  base_uri 'http://apicn.faceplusplus.com/v2'
  logger ::HTTP_LOGGER


  def initialize
    @auth = {api_key: Content::APP_KEY, api_secret: Content::APP_SECRET}
  end
  # 检测一张照片中的人脸信息（脸部位置、年龄、种族、性别等等）
  def get_main_content(response)
    result = MultiJson.load(response.body,:symbolize_keys => true)
    faces = result[:face]
  end
  def detection_detect(options = {})
    options[:query].merge!(@auth)
    HTTP_LOGGER.info "#{options}"

    response = self.class.get('/detection/detect',options)
    if response.code != 200
      HTTP_LOGGER.error "#{response.code}  |  #{Oj.load(response.body)["error"]}"
      return nil
    end

    begin
      HTTP_LOGGER.debug response.body
      faces = get_main_content(response)
      face_ids = faces.map { |face| face[:face_id] }
      return face_ids
    rescue
      HTTP_LOGGER.error "can't load response body => #{response.body}"
    end

  end
  # 对于一个待查询的Face列表（或者对于给定的Image中所有的Face），在一个Group中查询最相似的Person。
  # "candidate": [
  #     {
  #         "confidence": 94.299985,
  #         "person_id": "c1e580c0665f6ed11d510fe4d194b37a",
  #         "person_name": "1",
  #         "tag": ""
  #     },
  #     {
  #         "confidence": 43.930084,
  #         "person_id": "f5898c65a44771103166c77a8ebdfa37",
  #         "person_name": "2",
  #         "tag": ""
  #     },
  #     {
  #         "confidence": 29.234959,
  #         "person_id": "30b512232c5444779ce0bf5310a44e73",
  #         "person_name": "3",
  #         "tag": ""
  #     }
  # ]
  def recognition_identify(options = {})
    options[:query].merge!(@auth)
    response = self.class.get('/recognition/identify',options)
    if response.code != 200
      HTTP_LOGGER.error "#{response.code}  |  #{Oj.load(response.body)["error"]}"
      return nil
    end
    begin
      faces = get_main_content(response)
      people = faces[:candidate]
      return people
    rescue
      HTTP_LOGGER.error "can't load response body => #{response.body}"
      return nil
    end
  end

end