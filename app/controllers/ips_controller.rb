class IpsController < ApplicationController
  before_action :set_ip, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token # может я чего - то не понимаю, но стековерфлов говорит делать так

  # GET /ips
  # GET /ips.json
  def index
    @ips = Ip.all
  end

  # GET /ips/1
  # GET /ips/1.json
  def show
  end

  # GET /ips/new
  def new
    @ip = Ip.new
  end

  # GET /ips/1/edito
  def edit
  end

  # POST /ips
  # POST /ips.json
  def create
    @ip = Ip.new(ip_params)

    respond_to do |format|
      if @ip.save
        format.html { redirect_to @ip, notice: 'Ip was successfully created.' }
        format.json { render :show, status: :created, location: @ip }
        makecountry(@ip.ip)
      else
        format.html { render :new }
        format.json { render json: @ip.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /ips/1
  # PATCH/PUT /ips/1.json
  def masscreate
    post_params = JSON.parse(request.body.read)
    logger.debug post_params
    post_params.each {|a| 
      if isip(a["ip"])
        Ip.create(ip: a["ip"])
        makecountry(a["ip"])
      end
      
    }
    render json: { "a": 42}
  end

  def update
    respond_to do |format|
      if @ip.update(ip_params)
        format.html { redirect_to @ip, notice: 'Ip was successfully updated.' }
        format.json { render :show, status: :ok, location: @ip }
        makecountry(@ip.ip)
        

      else
        format.html { render :edit }
        format.json { render json: @ip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ips/1
  # DELETE /ips/1.json
  def destroy
    @ip.destroy
    respond_to do |format|
      format.html { redirect_to ips_url, notice: 'Ip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ip
      @ip = Ip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ip_params
      params.require(:ip).permit(:ip, :country)
    end
end
