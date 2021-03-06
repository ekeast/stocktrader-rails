require 'open-uri'
require 'json'
require 'net/http'

class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /stocks
  # GET /stocks.json
  def index

    @current_prices = []
    @properties = current_user.properties



    @properties.each do |stock|
      url = 'https://www.google.com/finance/info?q=NYSE%3A' + stock.symbol.to_s
      uri = URI(url)
      response = Net::HTTP.get(uri)
      json = JSON.parse(response[5..(response.length - 3)])
      current_price = json["l"].to_f
      @current_prices.push(current_price)
    end
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new(:symbol => params[:symbol])
    url = 'https://www.google.com/finance/info?q=NYSE%3A' + @stock.symbol.to_s
    uri = URI(url)
    response = Net::HTTP.get(uri)
    json = JSON.parse(response[5..(response.length - 3)])
    @stock.price = json["l"].to_f
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(stock_params)
    @stock.user = current_user



    respond_to do |format|
      if @stock.save

            if Property.where(symbol: @stock.symbol).first
              property = Property.where(symbol: @stock.symbol).first
              property.shares = property.shares + @stock.shares
              property.purchased_price = property.purchased_price + (@stock.shares * @stock.price)
              property.save!
            else
              Property.create(symbol: @stock.symbol, purchased_price: @stock.price * @stock.shares, shares: @stock.shares, user: current_user)
            end
        current_user.bank = current_user.bank - (@stock.price * @stock.shares)
          format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
          format.json { render :show, status: :created, location: @stock }
          current_user.save!
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:user_id, :price, :shares, :symbol)
    end
end
