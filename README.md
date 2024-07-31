# DBT and Airflow Integration Test

This repository demonstrates the integration of **DBT (Data Build Tool)** with **Apache Airflow** for data modeling and orchestration. The project is set up to manage data warehouse transformations using DBT and schedule those transformations via Airflow.

## Repository Structure

- **`airflow.py`**: The Airflow DAG definition file. This file contains the logic to trigger DBT commands as part of an Airflow workflow.

- **`dbt_project.yml`**: The configuration file for DBT. This file defines the project's structure, including the location of the models, seeds, and other resources.

- **`hub_Projects.sql`**: A DBT model file, likely implementing a Hub in a Data Vault schema. This SQL script defines the structure and transformations for the `Projects` entity.

- **`lnk_Projects.sql`**: A DBT model file for a Link table in a Data Vault schema. This script defines the relationships between hubs or between hubs and satellites for the `Projects` entity.

- **`profiles.yml`**: The configuration file for DBT profiles. This file contains connection settings for the data warehouse, including credentials and database details.

- **`sat_Projects.sql`**: A DBT model file for a Satellite table in a Data Vault schema. This script captures the changing attributes of the `Projects` entity over time.

- **`src_Projects.sql`**: A DBT model file for a Source table. This script defines the raw source data that is ingested into the data warehouse before being transformed by other DBT models.

## Getting Started

### Prerequisites

- **Python 3.6+**
- **Apache Airflow**
- **DBT**
- **A data warehouse** (e.g., Snowflake, BigQuery, Redshift, or a compatible SQL database)

### Setup

1. **Clone the repository**:

    ```sh
    git clone https://github.com/jiggo089/dbt_airflow_test.git
    cd dbt_airflow_test
    ```

2. **Install DBT and Airflow**:

    Install DBT:

    ```sh
    pip install dbt
    ```

    Install Airflow (this can vary depending on your environment):

    ```sh
    pip install apache-airflow
    ```

3. **Configure DBT**:

    - Update the `profiles.yml` file with your database connection details.
    - Ensure your data warehouse is accessible and that you have the necessary permissions.

4. **Organize DBT Model Files**:

    - Ensure that all model files (`hub_Projects.sql`, `lnk_Projects.sql`, `sat_Projects.sql`) are placed in the `models` directory within your DBT project. This is crucial for the DBT project structure and ensures proper dependency management and execution.
    - The `src_Projects.sql` file should be placed in the `snapshots` directory to implement Slowly Changing Dimensions Type 2 (SCD2). The `snapshots` folder is where you should define your SCD2 logic, which allows tracking historical data changes over time.

    The directory structure should look like this:

    ```plaintext
    dbt_project/
    ├── models/
    │   ├── hub_Projects.sql
    │   ├── lnk_Projects.sql
    │   └── sat_Projects.sql
    ├── snapshots/
    │   └── src_Projects.sql
    ├── profiles.yml
    └── dbt_project.yml
    ```

5. **Set Up Airflow**:

    - Place the `airflow.py` DAG file into your Airflow DAGs directory.
    - Start the Airflow web server and scheduler:

    ```sh
    airflow webserver
    airflow scheduler
    ```

6. **Run the DAG**:

    - Use the Airflow web interface to trigger the DAG defined in `airflow.py`. This will run the DBT models and execute the data transformations.

## Usage

1. **DBT Models**:

    - The DBT models included in this repository follow the Data Vault methodology, with `hub`, `link`, and `satellite` tables for `Projects`.
    - Customize these models based on your data and business requirements.

2. **SCD2 Implementation**:

    - Ensure that the source model (`src_Projects.sql`) is properly defined in the `snapshots` directory to manage Slowly Changing Dimensions Type 2 (SCD2).
    - This allows you to track historical changes in your data over time, ensuring accurate and complete data lineage.

3. **Airflow Orchestration**:

    - The `airflow.py` file defines the orchestration logic, including tasks for running DBT commands.
    - You can modify this DAG to add additional DBT commands or integrate with other ETL processes.

