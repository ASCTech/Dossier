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

  def destroy
    document = Document.find(params[:document_id])
    tag = Tag.find_by_name(params[:id]) || Tag.find(params[:id])
    document.document_tags.find_by_tag_id(tag.id).destroy rescue
    respond_with document
  end

end
