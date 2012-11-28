class TagsController < ApplicationController

  respond_to :xml, :json

  def create
    document = Document.find(params[:document_id])

    if params[:id].present?
      tag = Tag.find(params[:id])
    elsif params[:name].present?
      tag = Tag.find_or_create_by_name(params[:name])
    end

    document.tags << tag if defined?(tag)

    respond_with document
  end

  def destroy
    document = Document.find(params[:document_id])
    tag = Tag.find_by_name(params[:id]) || Tag.find(params[:id])
    document.tags.delete(tag) if document.tags.include?(tag)
    respond_with document
  end

end
