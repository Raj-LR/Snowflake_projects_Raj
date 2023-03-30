#include: "/PoP_files/pop_parameters_snow.view.lkml"
view: orders {
  sql_table_name: "LOOKER_TEST"."ORDERS"
    ;;
    #extends: [pop_parameters_snow]
  drill_fields: [id]
#extends: [pop_parameters_snow]
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: original_created {
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
    sql: ${TABLE}."CREATED_AT" ;;
  }
  dimension_group: event {
    type: time
    label: "order_event"
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: order_amount {
    type: number
    sql: ${TABLE}."ORDER_AMOUNT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.name,
      users.id,
      billion_orders.count,
      hundred_million_orders.count,
      order_items.count
    ]
  }
}
