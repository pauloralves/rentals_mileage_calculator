class CsvLinesController < ApplicationController
  before_action :set_csv_line, only: [:show, :edit, :update, :destroy]

  # GET /csv_lines
  # GET /csv_lines.json
  def index
    @csv_lines = CsvLine.all
  end

  # GET /csv_lines/1
  # GET /csv_lines/1.json
  def show
  end

  # GET /csv_lines/new
  def new
    @csv_line = CsvLine.new
  end

  # GET /csv_lines/1/edit
  def edit
  end

  # POST /csv_lines
  # POST /csv_lines.json
  def create
    @csv_line = CsvLine.new(csv_line_params)

    respond_to do |format|
      if @csv_line.save
        format.html { redirect_to @csv_line, notice: 'Csv line was successfully created.' }
        format.json { render :show, status: :created, location: @csv_line }
      else
        format.html { render :new }
        format.json { render json: @csv_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /csv_lines/1
  # PATCH/PUT /csv_lines/1.json
  def update
    respond_to do |format|
      if @csv_line.update(csv_line_params)
        format.html { redirect_to @csv_line, notice: 'Csv line was successfully updated.' }
        format.json { render :show, status: :ok, location: @csv_line }
      else
        format.html { render :edit }
        format.json { render json: @csv_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /csv_lines/1
  # DELETE /csv_lines/1.json
  def destroy
    @csv_line.destroy
    respond_to do |format|
      format.html { redirect_to csv_lines_url, notice: 'Csv line was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_csv_line
      @csv_line = CsvLine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def csv_line_params
      params.require(:csv_line).permit(:timestamp, :latitude, :longitude, :csv_file_id)
    end
end
