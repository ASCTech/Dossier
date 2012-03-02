class TagsController < ApplicationController

  respond_to :xml, :json

  def create
    document = Document.find(params[:document_id])
    if params[:id].present?
      tag = Tag.find(params[:id])
    elsif params[:name].present?
      tag = Tag.find_or_create_by_name(params[:name])
    end
    document.document_tags.create(:tag_id => tag.id)
    respond_with document
  end

end
