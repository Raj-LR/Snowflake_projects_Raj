#Ainclude: "/PoP_files/pop_parameters_snow.view.lkml"
include: "/views/pop_main.view.lkml"
view: users {
  sql_table_name: "LOOKER_TEST"."USERS";;
 # extends: [pop_parameters_snow]
  #sql_table_name: "LOOKER_TEST"."ORDERS" ;;
#extends: [pop_parameters_snow]
#------------------------------------------------------template---------------------------------------------
#----------- Looker Period Control Block -----------
  extends: [pop_main]


  dimension: event_date {
    sql: ${TABLE}."CREATED_AT";;
    # Important. If this field only contains a date, with no time, this must be set to no. You will have major problems
    # if a date such as 2022-01-01 is converted to local time. Looker will think of this as 2022-01-01 00:00:00 and in the case
    # of a -5 conversion, would turn that into 2021-12-31 19:00:00.
    convert_tz: yes

    # --- Do Not Edit Below this Line ----
    type: date_raw
    hidden: yes
    # --- End No Not Edit block       ----

  }

  parameter: convert_tz {
    # Instructions: If your date is just a date with no time, set this value to no. If your date is a date with time, set to yes. It is VERY important that you do
    # not set this value to yes if you only have a date. Bad things will happen.
    default_value: "yes"

    # --- Do Not Edit Below this Line ----
    type: yesno
    hidden: yes
    # --- End No Not Edit block       ----
  }

  # Do not edit table_name. This should stay as is.
  dimension: table_name {
    # --- Do Not Edit Below this Line ----
    type: string
    sql: ${TABLE};;
    hidden: yes
    # --- End No Not Edit block       ----
  }

  # Origin event date and origin period name are required when using the "Last Data" filter option. The value here will be
  # used to create a (select max(date_field) from table) type query. This will be used to limit the date range to the max date.
  # When using a derived table, the query has no way to know what table name to query for last data. If using a derived table,
  # these values should be set to whatever source table contains the "max" date.

  dimension: origin_event_date {
    # Instructions: Replace with the name of the origin date column
    sql: ${event_date};;
    # --- Do Not Edit Below this Line ----
    type: string
    hidden: yes
    # --- End No Not Edit block       ----
  }

  dimension: origin_table_name {
    # Instructions: The origin_table_name dimension allows for the use of "Last Data" filter option. If you are
    # using a PDT, you must hand enter the schema and table name of whatever table contains the date dimension.
    # For example, if you had a PDT that mostly derived from shop.orders, you would enter that. If using a
    # standard SQL table, you can enter the name of the view and SQL_TABLE_NAME. For example ${my_view.
    # SQL_TABLE_NAME}.
    sql: ${users.SQL_TABLE_NAME};;
    # --- Do Not Edit Below this Line ----
    type: string
    hidden: yes
    # --- End No Not Edit block       ----
  }

  #------------ End Looker Period Control Block ------------
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}."AGE" ;;
  }

  dimension_group: original_user_created {
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
  #dimension_group: event {
  #  type: time
  #  hidden: yes
  #  label: "users_event"
  #  timeframes: [
  #    raw,
  #    time,
  ##    date,
  #    week,
  #    month,
  #    quarter,
  #    year
  # ]
  #  sql: ${TABLE}."CREATED_AT" ;;
  #}

  dimension: epoch_at {
    type: number
    sql: ${TABLE}."EPOCH_AT" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: yyyymmdd_at {
    type: number
    sql: ${TABLE}."YYYYMMDD_AT" ;;
  }
measure: ave_age {
  type: average
  sql: ${age} ;;
}
  measure: count {
    type: count
    drill_fields: [id, name, fatal_error_incremental_bug.count, orders.count, orders_view.count]
  }

}
