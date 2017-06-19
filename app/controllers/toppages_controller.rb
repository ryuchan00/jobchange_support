class ToppagesController < ApplicationController
  def index
    @items = Item.order('updated_at DESC')
    @code = CodeForm.new
    @code.code = '<?php echo "Hello, Woeld";'
  end

  def enter
    @code = CodeForm.new(params[:code_form])
    p @code.code
  end
end