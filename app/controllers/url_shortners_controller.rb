class UrlShortnersController < ApplicationController
  before_action :validate_if_url_is_already_shortened, only: :create
  before_action :set_url_shortner, only: %i[show process_a]

  # GET /url_shortners or /url_shortners.json
  def index
    @url_shortners = UrlShortner.order(frequency: :desc).limit(100)
  end

  # GET /url_shortners/1 or /url_shortners/1.json
  def show

  end
  # GET /:generated_url
  def process_a
    @url_shortner.update(frequency: @url_shortner.frequency + 1)
    redirect_to @url_shortner.given_url, allow_other_host: true
  end

  # GET /url_shortners/new
  def new
    @url_shortner = UrlShortner.new
  end

  # POST /url_shortners or /url_shortners.json
  def create
    @url_shortner = UrlShortner.new(url_shortner_params)

    respond_to do |format|
      if @url_shortner.save
        FetchPageTitleJob.perform_later(@url_shortner.id)
        format.html { redirect_to url_shortner_path(generated_url: @url_shortner.generated_url), notice: "Url shortner was successfully created." }
        format.json { render :show, status: :created, location: @url_shortner }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @url_shortner.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url_shortner
      @url_shortner = UrlShortner.find_by(generated_url: params[:generated_url])
      return if @url_shortner

      flash[:alert] = 'No matching URL found'
      redirect_to root_path
    end

    # Only allow a list of trusted parameters through.
    def url_shortner_params
      params.require(:url_shortner).permit(:given_url).tap do |given|
        unless UrlShortner.find_by(given_url: given[:given_url]).present?
          given[:generated_url] = generate_unique_url_path
        end
      end
    end

  def generate_unique_url_path
    unique = false
    new_path = ''
    loop do
      new_path = (0...8).map { (65 + rand(26)).chr }.join.downcase
      unless UrlShortner.find_by(generated_url: new_path)
        unique = true
      end
      break if unique
    end

    new_path
  end

  def validate_if_url_is_already_shortened
    return unless UrlShortner.find_by(given_url: params[:given_url]).present?

    flash[:alert] = 'Url is already shortened'
    render :new
  end
end
