class CategoriesController < ApplicationController
  def index
    @categories = scope.all
    authorize @categories
    respond_to do |format|
      format.json
    end
  end

  private

  def scope
    policy_scope(Category)
  end
end
