view: timestamp_test {
  sql_table_name: "LOOKER_TEST"."TIMESTAMP_TEST"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: test_val {
    type: string
    sql: ${TABLE}."TEST_VAL" ;;
  }

  dimension_group: timestamp_ltz {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."TIMESTAMP_LTZ" ;;
  }

  dimension_group: timestamp_ntz {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."TIMESTAMP_NTZ" ;;
  }

  dimension_group: timestamp_tz {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.CAST(${TABLE}."TIMESTAMP_TZ" AS TIMESTAMP_NTZ) ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
