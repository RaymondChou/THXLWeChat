class EvaluatesController < ApplicationController

  def new

  end

  def create
    params.delete(:controller)
    params.delete(:action)
    Evaluate.new(params).save
  end

end
