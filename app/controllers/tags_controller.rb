class TagsController < ApplicationController

  def create
    respond_with requesting_system.get_document(params[:document_id]).tags << Tag.find_or_create_by_name(params[:name])
  end

  def destroy
    document = requesting_system.get_document(params[:document_id])
    tag = Tag.find_by_name(params[:id])
    document.tags.delete(tag) if document.tags.include?(tag)
    respond_with document
  end

end
