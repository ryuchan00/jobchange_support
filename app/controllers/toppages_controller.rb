class ToppagesController < ApplicationController
  def index
    @items = Item.order('updated_at DESC')
    @code = '<?php echo "Hello, Woeld";'
  end
end