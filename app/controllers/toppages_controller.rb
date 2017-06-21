class ToppagesController < ApplicationController
  def index
    @items = Item.order('updated_at DESC')
    @code = CodeForm.new
    # @code.code = '<?php echo "Hello, Woeld;"'
    @code.code = <<'EOS'
<?php 
echo 'ようこそ！プログラミングの世界へ';
EOS
  end

  def enter
    @code = CodeForm.new(params[:code_form])
    p @code.code
  end
end