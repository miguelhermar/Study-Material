# FROM points to the base image to get started
FROM quay.io/astronomer/astro-runtime:10.4.0

# installs dbt-snowflake into a virtual environment
RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
    pip install --no-cache-dir dbt-snowflake && deactivate