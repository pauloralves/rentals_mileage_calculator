class CsvFilesController < ApplicationController
  before_action :set_csv_file, only: [:show, :edit, :update, :destroy]

  # GET /csv_files
  # GET /csv_files.json
  def index
    @csv_files = CsvFile.all
  end

  # GET /csv_files/1
  # GET /csv_files/1.json
  def show
  end

  # GET /csv_files/new
  def new
    @csv_file = CsvFile.new
  end

  # POST /csv_files
  # POST /csv_files.json
  def create
    response = ""
    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @csv_file = CsvFile.new({ rental_id: csv_file_params[:rental_id] })
          @csv_file.save!
          @csv_file.create_lines(csv_file_params[:file])
          @csv_file.delay.calculate_mileage
        end 
        response = "success"
      rescue ActiveRecord::RecordInvalid => invalid
        # raise ActiveRecord::Rollback
      end
    
      if response == "success"
        format.html { redirect_to rental_path(id: @csv_file.rental_id), notice: 'CSV file was successfully uploaded and will be processed soon.' }
        # format.json { render :show, status: :created, location: @csv_file }
      else
        format.html { render :new }
        format.json { render json: @csv_file.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /csv_files/1
  # DELETE /csv_files/1.json
  def destroy
    @csv_file.destroy
    respond_to do |format|
      format.html { redirect_to csv_files_url, notice: 'Csv file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_csv_file
      @csv_file = CsvFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def csv_file_params
      params.require(:csv_file).permit(:rental_id, :file)
    end
end
