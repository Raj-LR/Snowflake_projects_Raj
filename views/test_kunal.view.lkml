view: test_kunal {
    derived_table: {
      persist_for: "24 hours"
      create_process: {
        sql_step: SHOW VIEWS LIKE 'DATA_QUALITY_METRICS' IN ACCOUNT; ;;
        sql_step: CREATE TABLE ${SQL_TABLE_NAME} AS SELECT database_name FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())) ;;
      }
    }
    dimension: db_name {
      type: string
      sql: ${TABLE}."database_name" ;;
    }
    measure: count {
      type: number
    }

  }
