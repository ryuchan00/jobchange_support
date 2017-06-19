class CodeForm
  include ActiveModel::Model

  attr_accessor :code

  validates :code, presence: true

  def initialize(params = {})
    if params.is_a?(ActionController::Parameters)
      [:code].each do |attribute|
        params[attribute] = attribute
      end
    end
    super
  end
end
