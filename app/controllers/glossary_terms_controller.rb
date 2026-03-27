class GlossaryTermsController < ApplicationController
  def index
    @glossary_term = GlossaryTerm.new
    @glossary_terms = GlossaryTerm.order(:term)
  end

  def edit
    @glossary_term = GlossaryTerm.find(params[:id])
  end

  def delete_modal
    @glossary_term = GlossaryTerm.find(params[:id])

    respond_to do |format|
      format.turbo_stream { render "glossary_terms/delete_modal" }
    end
  end

  def create
    @glossary_term = GlossaryTerm.new(glossary_term_params)

    if @glossary_term.save
      redirect_to glossary_terms_path, notice: "用語を登録しました"
    else
      @glossary_terms = GlossaryTerm.order(:term)
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @glossary_term = GlossaryTerm.find(params[:id])

    if @glossary_term.update(glossary_term_params)
      redirect_to glossary_terms_path, notice: "用語を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    glossary_term = GlossaryTerm.find(params[:id])
    glossary_term.destroy

    redirect_to glossary_terms_path, notice: "用語を削除しました"
  end

  private

  def glossary_term_params
    params.require(:glossary_term).permit(:term, :description)
  end
end