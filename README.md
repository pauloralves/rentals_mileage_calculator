# Rentals Mileage Calculator

### Calculates the mileage of a rental based on the known positions of the vehicle during rental.

## Description

* Add, edit and delete rental car;
* Upload CSV file associated with a rental;
* Every file uploaded will be processed and will have a status (pending, processing, error, success)
* Successfully processed files will have a mileage value.
* List of rental with total mileage for each
* Rental page with list of files, file mileage, total rental mileage, average mileage/file

> CSV file with positions of the vehicle during the rental, as follows:

**timestamp (integer) | latitude (float) | longitude (float)**
```csv
1473025483;48.09249;-1.64021
1473025688;48.09134;-1.65089
1473025693;48.09139;-1.65141
1473025777;48.09319;-1.65842
1473025781;48.09335;-1.65827
```

## Instructions:

* Create a config/secrets.yml with google_api_key: <API_KEY>

* This project uses DelayedJob, so the work nedds to be started: bundle exec rake jobs:work


