-- +goose Up
CREATE TABLE statement_execution_insights (
   timestamp                  TIMESTAMPTZ,
   org_id                     STRING,
   cluster_id                 STRING,
   tenant_id                  STRING,
   event_id                   STRING,
   session_id                 STRING,
   transaction_id             STRING,
   transaction_fingerprint_id STRING,
   statement_id               STRING,
   statement_fingerprint_id   STRING,
   problem                    INT,
   causes                     INT[],
   query                      STRING,
   status                     INT,
   start_time                 TIMESTAMPTZ,
   end_time                   TIMESTAMPTZ,
   full_scan                  BOOL,
   user_name                  STRING,
   app_name                   STRING,
   user_priority              STRING,
   database_name              STRING,
   plan_gist                  STRING,
   retries                    INT8,
   last_retry_reason          STRING,
   execution_node_ids         INT[],
   index_recommendations      STRING[],
   implicit_txn               BOOL,
   cpu_sql_nanos              INT8,
   error_code                 STRING,
   contention_time            INTERVAL,
   details                    JSONB,
   crdb_internal_end_time_start_time_shard_16 INT4 NOT VISIBLE NOT NULL AS (mod(fnv32(md5(crdb_internal.datums_to_bytes(end_time, start_time))), 16:::INT8)) VIRTUAL,
   CONSTRAINT "primary" PRIMARY KEY (statement_id, transaction_id),
   INDEX transaction_id_idx (transaction_id),
   INDEX transaction_fingerprint_id_idx (transaction_fingerprint_id, start_time DESC, end_time DESC),
   INDEX statement_fingerprint_id_idx (statement_fingerprint_id, start_time DESC, end_time DESC),
   INDEX time_range_idx (start_time DESC, end_time DESC) USING HASH,
   FAMILY "primary" (
     session_id,
     transaction_id,
     transaction_fingerprint_id,
     statement_id,
     statement_fingerprint_id,
     problem,
     causes,
     query,
     status,
     start_time,
     end_time,
     full_scan,
     user_name,
     app_name,
     user_priority,
     database_name,
     plan_gist,
     retries,
     last_retry_reason,
     execution_node_ids,
     index_recommendations,
     implicit_txn,
     cpu_sql_nanos,
     error_code,
     contention_time,
     details
     )
);

-- +goose Down
DROP TABLE statement_execution_insights;
