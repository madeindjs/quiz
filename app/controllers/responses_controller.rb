class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]
  before_action :only_logged, only: [:new, :create , :edit, :update, :destroy ]
  before_action :check_owner, only: [:edit, :update, :destroy]

  # GET /responses
  # GET /responses.json
  def index
    @responses = Response.all
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
  end

  # GET /responses/new
  def new
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses
  # POST /responses.json
  def create
    @response = Response.new(response_params)
    @response.user = current_user

    respond_to do |format|
      if @response.save
        format.html {
          # todo: find a question to redirect
          if @response.good?
            unanswered_quest_for_user = current_user.unanswered_questions
            if unanswered_quest_for_user.empty?
              redirect_to root_path,notice:"Vous avez terminé le jeu !"
            else
              redirect_to unanswered_quest_for_user.last, notice: 'Bonne réponse, question suivante'
            end
          else
            redirect_to @response.question, notice: 'Essaie encore !'
          end
        }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1
  # PATCH/PUT /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: 'Response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      params.require(:response).permit(:content, :question_id)
    end

    def check_owner
      redirect_to new_user_session_path unless  can? :modify, @response
    end

end
