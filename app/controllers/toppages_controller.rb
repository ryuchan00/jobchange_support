class ToppagesController < ApplicationController
  def index
    @items = Item.order('updated_at DESC')
    @code = CodeForm.new
    # @code.code = '<?php echo "Hello, Woeld;"'
    @code.code = <<'EOS'
<?php 
echo "Hello,World";
EOS
  end

  def enter
    @code = CodeForm.new
    code = params[:code_form][:code]

    #こっちでいく
    http = setup_http
    res = Net::HTTP.post_form(URI.parse('http://api.paiza.io:80/runners/create'),
                              {'source_code' => code,
                               'language' => "php",
                               'longpoll' => "true",
                               'api_key' => "guest"
                              })
    puts res.body
    if res.code != '200'
      #todo:リターンコードを返す処理を入れる
      p "return false"
      # exit()
    end
    json = JSON.parse(res.body)
    id = json['id']

    query = {id: id, api_key: "guest"}.to_query
    url = URI.parse('http://api.paiza.io:80')
    res = Net::HTTP.start(url.host, url.port) { |http|
      http.get("/runners/get_details?#{query}")
    }
    puts res.body
    if res.code != '200'
      #todo:リターンコードを返す処理を入れる
      # exit()
    end
    json = JSON.parse(res.body)
    if json['stdout'].empty? then
      @output = json['stderr']
    else
      @output = json['stdout']
    end
    p @output
  end

  private

  #httpインスタンスを生成する。
  def setup_http
    http = Net::HTTP.new('http://api.paiza.io', 80)
    http.use_ssl = true
    return http
  end
end